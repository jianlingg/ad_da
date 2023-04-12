/*模块说明
收到en=1,dout产生一个宽度为10的高电平脉冲
*/
// 以下是使用Verilog编写的四线SPI从机接口：

module spi_slave(
    input clk, // 时钟信号
    input reset_n, // 复位信号（低有效）

    input cs_n, // 主机片选信号（低有效）
    input sclk, // 时钟信号
    input mosi, // MOSI信号
    output reg miso // MISO信号（从机输出）
);
    
    reg [7:0] tx_data; // 发送数据寄存器
    reg [7:0] rx_data; // 接收数据寄存器
    
    reg [2:0] state = 3'b000; // 状态机状态
    
    always @(posedge clk) begin
        if (!reset_n) begin // 复位
            state <= 3'b000;
            miso <= 1'b1;
        end else begin
            case (state)
                3'b000: begin // 等待主机片选信号
                    if (!cs_n) begin
                        state <= 3'b001;
                    end
                end
                
                3'b001: begin // 等待主机发送数据
                    if (sclk && cs_n) begin // 主机上升沿产生时，采样mosi数据
                        tx_data <= mosi;
                        state <= 3'b010;
                    end
                end
                
                3'b010: begin // 发送数据给主机
                    if (cs_n) begin // 如果主机取消片选信号，则忽略当前数据
                        state <= 3'b001;
                    end else begin
                        miso <= rx_data[7];
                        rx_data <= {rx_data[6:0], tx_data}; // 将本次接收到的数据保存进接收寄存器
                        state <= 3'b011;
                    end
                end
                
                3'b011: begin // 等待主机接收数据完成
                    if (!sclk) begin
                        state <= 3'b001;
                    end
                end
            endcase
        end
    end
    
endmodule
```

说明：

- 在主机片选信号变为低电平时，从机会进入等待状态，并等待主机发送数据。
- 每当主机在上升沿产生时钟信号时，从机会采样MOSI信号，并将其存储到发送数据寄存器中。
- 从机将接收到的数据保存到接收数据寄存器中，并通过MISO信号向主机发送数据。
- 如果主机取消片选信号，则从机会忽略当前正在发送或接收的数据，并回到等待状态。
- 当主机数据传输完成后，从机会回到等待状态。