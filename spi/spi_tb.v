`timescale 1ns / 1ns
module spi_tb;
    //global clock
    reg            clk         ;
    reg            rst_n       ;

    //user interface
    wire dout;
    //ʱ�����ڣ���λΪns�����ڴ��޸�ʱ�����ڡ�
    parameter CYCLE    = 10;

    //��λʱ�䣬��ʱ��ʾ��λ3��ʱ�����ڵ�ʱ�䡣
    parameter RST_TIME = 3 ;

    //�����Ե�ģ������
    spi spi_u(
    //global clock
    . clk(clk),
    . rst_n(rst_n),

    //user interface
    . dout(dout) 
);


    //���ɱ���ʱ��50M
    initial clk = 1;
    always #(CYCLE/2) clk=~clk;
    

    //������λ�ź�
    initial begin
        rst_n = 1;
        #2;
        rst_n = 0;
        #(CYCLE*RST_TIME);
        rst_n = 1;
    end

    //���������ź�
    initial begin
        #1;
        #(CYCLE*10000);
    
    end
    

endmodule