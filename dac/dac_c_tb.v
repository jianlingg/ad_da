`timescale 1ns / 1ns
module dac_c_tb;
    //global clock
    reg            clk         ;
    reg            rst_n       ;

    //user interface
    reg [15:0]din;
    reg       din_vld;

    wire      cs;
    wire      sclk;
    wire      sdi;
    wire      ldac;

    wire      rst;

    //ʱ�����ڣ���λΪns�����ڴ��޸�ʱ�����ڡ�
    parameter CYCLE    = 20;

    //��λʱ�䣬��ʱ��ʾ��λ3��ʱ�����ڵ�ʱ�䡣
    parameter RST_TIME = 10 ;
    reg din_vlds;

    always  @(posedge clk)begin
        din_vlds <= din_vld;
    end
    

    //�����Ե�ģ������

    rst rst_u(
    //global clock
    . clk(clk),
    . rst_n(rst_n),

    //user interface
    . rst(rst)
);
    dac_c dac_c_u(
    //global clock
    . clk(clk),
    . rst_n(rst),

    //user interface
    . din(din),
    . din_vld(din_vlds),

    . cs(cs),
    . sclk(sclk),
    . sdi(sdi),
    . ldac(ldac)
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
        din = 16'b1100_0101_1111_0010;
        din_vld = 0;
        #(CYCLE*100);
        din_vld = 1;
        #(CYCLE*1);
        din_vld = 0;
        #(CYCLE*10000);
        

    end
endmodule