`timescale 1ns / 1ns
module adc_tb;
    //global clock
    reg            clk         ;
    reg  rsts;
    reg            rst_n       ;

    //user interface
    reg rvs;
    wire cs;
    wire sclk;
    

    //时钟周期，单位为ns，可在此修改时钟周期。
    parameter CYCLE    = 20;

    //复位时间，此时表示复位3个时钟周期的时间。
    parameter RST_TIME = 3 ;

    always  @(posedge clk)begin
        rst_n <= rsts;
    end

    //待测试的模块例化
    adc adc_u(
    //global clock
    .clk(clk),
    .rst_n(rst_n),

    //user interface

//---------------------------------------------------------------------
    .rvs(rvs),
    .cs(cs),
    .sclk(sclk)
);
   reg [33:0] i;

   always  @(posedge clk)begin
       
   end

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


    //
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            rvs <= 1;
        end
        else if(i == 99)begin
            rvs <= 1;
        end
        else begin
            rvs <= 0;
        end
    end

    //产生输入信号
    initial begin
        for (i = 0; i<1000 ;i = i+1 ) begin
            if(i<100)begin
                #1;
            end
            else begin
                i = 0;
            end
        end
    end
endmodule