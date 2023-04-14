`timescale 1ns / 1ns
module clk_en_tb;
    //global clock
    reg            clk         ;
    reg            rst_n       ;

    //user interface
    reg cs;
    wire sclk;
    

    //ʱ�����ڣ���λΪns�����ڴ��޸�ʱ�����ڡ�
    parameter CYCLE    = 20;

    //��λʱ�䣬��ʱ��ʾ��λ3��ʱ�����ڵ�ʱ�䡣
    parameter RST_TIME = 3 ;

    //�����Ե�ģ������
    clk_en clk_en_u(
    //global clock
    . clk(clk),
    . rst_n(rst_n),

    //user interface
    . cs(cs),
    . sclk(sclk) 
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
        #2;
        cs = 1;
        #(CYCLE*100);
        cs = 0;
        #(CYCLE*100);
        cs = 1;
        #(CYCLE*1000);
    end
endmodule