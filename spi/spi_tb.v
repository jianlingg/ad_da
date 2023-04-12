`timescale 1ns / 1ns
module spi_tb;
    //global clock
    reg            clk         ;
    reg            rst_n       ;

    //user interface
    wire dout;
    //时钟周期，单位为ns，可在此修改时钟周期。
    parameter CYCLE    = 10;

    //复位时间，此时表示复位3个时钟周期的时间。
    parameter RST_TIME = 3 ;

    //待测试的模块例化
    spi spi_u(
    //global clock
    . clk(clk),
    . rst_n(rst_n),

    //user interface
    . dout(dout) 
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
        #1;
        #(CYCLE*10000);
    
    end
    

endmodule