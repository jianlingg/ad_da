/*ģ��˵��
�յ�en=1,dout����һ�����Ϊ10�ĸߵ�ƽ����
*/
// ������ʹ��Verilog��д������SPI�ӻ��ӿڣ�

module spi_slave(
    input clk, // ʱ���ź�
    input reset_n, // ��λ�źţ�����Ч��

    input cs_n, // ����Ƭѡ�źţ�����Ч��
    input sclk, // ʱ���ź�
    input mosi, // MOSI�ź�
    output reg miso // MISO�źţ��ӻ������
);
    
    reg [7:0] tx_data; // �������ݼĴ���
    reg [7:0] rx_data; // �������ݼĴ���
    
    reg [2:0] state = 3'b000; // ״̬��״̬
    
    always @(posedge clk) begin
        if (!reset_n) begin // ��λ
            state <= 3'b000;
            miso <= 1'b1;
        end else begin
            case (state)
                3'b000: begin // �ȴ�����Ƭѡ�ź�
                    if (!cs_n) begin
                        state <= 3'b001;
                    end
                end
                
                3'b001: begin // �ȴ�������������
                    if (sclk && cs_n) begin // ���������ز���ʱ������mosi����
                        tx_data <= mosi;
                        state <= 3'b010;
                    end
                end
                
                3'b010: begin // �������ݸ�����
                    if (cs_n) begin // �������ȡ��Ƭѡ�źţ�����Ե�ǰ����
                        state <= 3'b001;
                    end else begin
                        miso <= rx_data[7];
                        rx_data <= {rx_data[6:0], tx_data}; // �����ν��յ������ݱ�������ռĴ���
                        state <= 3'b011;
                    end
                end
                
                3'b011: begin // �ȴ����������������
                    if (!sclk) begin
                        state <= 3'b001;
                    end
                end
            endcase
        end
    end
    
endmodule
```

˵����

- ������Ƭѡ�źű�Ϊ�͵�ƽʱ���ӻ������ȴ�״̬�����ȴ������������ݡ�
- ÿ�������������ز���ʱ���ź�ʱ���ӻ������MOSI�źţ�������洢���������ݼĴ����С�
- �ӻ������յ������ݱ��浽�������ݼĴ����У���ͨ��MISO�ź��������������ݡ�
- �������ȡ��Ƭѡ�źţ���ӻ�����Ե�ǰ���ڷ��ͻ���յ����ݣ����ص��ȴ�״̬��
- ���������ݴ�����ɺ󣬴ӻ���ص��ȴ�״̬��