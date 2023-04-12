// ������ʹ��Verilog��д������SPI�����ӿڵ�ʾ�����룺

```verilog
module spi_master (
    input clk,             // ��ʱ���ź�
    input resetn,          // ��λ�źţ��͵�ƽ��Ч
    output reg cs_n,       // Ƭѡ�źţ��ߵ�ƽ��Ч
    output reg sclk,       // ʱ���ź�
    output reg mosi,       // ���豸��������ź�
    input miso            // ���豸��������ź�
);

    parameter IDLE = 2'b00;
    parameter WRITE = 2'b01;
    parameter READ = 2'b10;
    parameter END = 2'b11;

    reg [7:0] tx_data;      // ����������
    reg [7:0] rx_data;      // ���յ�������
    reg [1:0] state;        // ״̬��״̬
    reg [2:0] bit_count;    // ��ǰ�����λ�������Ϊ 8

    // ��״̬��
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
                    rx_data[0] <= 0;           // ������λ����ʾ�������
                    cs_n <= 1;
                    state <= IDLE;
                    bit_count <= 0;
                    sclk <= 0;
                    mosi <= 0;
                end
            endcase
        end
    end

    // �������ݼĴ���
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

�ô���ʹ����״̬������SPI�ӿڵĲ����������ȴ�״̬��д����״̬��������״̬�ͽ���״̬����д����״̬�£����豸����豸���͵����ֽڵ����ݡ��ڶ�����״̬�£����豸ͨ��MISO�߽������Դ��豸�ĵ����ֽڵ����ݡ��ڽ���״̬�£����豸�����λ���㣬�Ա�ʾ������ɡ��������������4��SPIЭ�顣