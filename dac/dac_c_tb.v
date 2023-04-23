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

    //时钟周期，单位为ns，可在此修改时钟周期。
    parameter CYCLE    = 20;

    //复位时间，此时表示复位3个时钟周期的时间。
    parameter RST_TIME = 10 ;
    reg din_vlds;

    always  @(posedge clk)begin
        din_vlds <= din_vld;
    end
    

    //待测试的模块例化

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


    //生成本地时钟50M
    initial clk = 1;
    always #(CYCLE/2) clk=~clk;
    

    //产生复位信号
    initial begin
        rst_n = 1;
        #2;
        rst_n = 0;
        #(CYCLE*RST_TIME);
        rst_n = 1;
    end

    //产生输入信号
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