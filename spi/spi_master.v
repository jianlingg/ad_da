// 以下是使用Verilog编写的四线SPI主机接口的示例代码：

```verilog
module spi_master (
    input clk,             // 主时钟信号
    input resetn,          // 复位信号，低电平有效
    output reg cs_n,       // 片选信号，高电平有效
    output reg sclk,       // 时钟信号
    output reg mosi,       // 主设备输出数据信号
    input miso            // 从设备输出数据信号
);

    parameter IDLE = 2'b00;
    parameter WRITE = 2'b01;
    parameter READ = 2'b10;
    parameter END = 2'b11;

    reg [7:0] tx_data;      // 待发送数据
    reg [7:0] rx_data;      // 接收到的数据
    reg [1:0] state;        // 状态机状态
    reg [2:0] bit_count;    // 当前传输的位数，最大为 8

    // 主状态机
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= IDLE;
            bit_count <= 0;
            sclk <= 0;
            mosi <= 0;
            cs_n <= 1;
        end else begin
            case (state)
                IDLE: begin
                    if (cs_n == 0) begin
                        state <= WRITE;
                        bit_count <= 0;
                        sclk <= 0;
                        mosi <= tx_data[bit_count];
                    end
                end
                WRITE: begin
                    mosi <= tx_data[bit_count];
                    sclk <= ~sclk;
                    bit_count <= bit_count + 1;
                    if (bit_count == 8) begin
                        state <= READ;
                        bit_count <= 0;
                        sclk <= 0;
                        mosi <= 0;
                    end
                end
                READ: begin
                    sclk <= ~sclk;
                    bit_count <= bit_count + 1;
                    rx_data[bit_count] <= miso;
                    if (bit_count == 8) begin
                        state <= END;
                        bit_count <= 0;
                        sclk <= 0;
                        mosi <= 0;
                    end
                end
                END: begin
                    rx_data[0] <= 0;           // 清除最高位，表示传输完成
                    cs_n <= 1;
                    state <= IDLE;
                    bit_count <= 0;
                    sclk <= 0;
                    mosi <= 0;
                end
            endcase
        end
    end

    // 输入数据寄存器
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            tx_data <= 0;
        end else begin
            if (state == IDLE) begin
                tx_data <= 0;
            end else begin
                tx_data <= tx_data;
            end
        end
    end

endmodule
```

该代码使用主状态机控制SPI接口的操作，包括等待状态、写数据状态、读数据状态和结束状态。在写数据状态下，主设备向从设备发送单个字节的数据。在读数据状态下，主设备通过MISO线接收来自从设备的单个字节的数据。在结束状态下，从设备将最高位清零，以表示传输完成。这个例子适用于4线SPI协议。