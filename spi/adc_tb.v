`timescale 1ns / 1ns
module adc_tb;
    //global clock
    reg            clk         ;
    reg            rsts;
    reg            rst_n       ;

    //user interface
    reg rvs;
    reg miso;
    wire [15:0]dout;
    wire cs;
    wire sclk;
    wire mosi;
    

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
    .dout(dout),

    //---------------------------------------------------------------------
    .rvs(rvs),
    .miso(miso),
    .cs(cs),
    .sclk(sclk),
    .mosi(mosi)//就是SDI
);
   reg [33:0] i;
   reg [10:0] cnt;
   wire add_cnt;
   wire end_cnt;



//生成本地时钟50M
    initial clk = 1;
    always #(CYCLE/2) clk=~clk;
    
    //产生复位信号
    initial begin
        rsts= 1;
        #2;
        rsts = 0;
        #(CYCLE*RST_TIME);
        rsts = 1;
    end


//计数器
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt <= 0;
    end
    else if(add_cnt)begin
      if(end_cnt)
         cnt <= 0;
      else
         cnt <= cnt + 1;
      end      
end

assign add_cnt = !cs;
assign end_cnt = add_cnt && cnt == 50-1;

reg [15:0] ex = 16'b1011_1111_1111_1111;
always  @(*)begin
    if(add_cnt && cnt < 16)begin
        miso <= ex[15-cnt];
    end
    else begin
        miso <= 1'bz;
    end
end



//
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            rvs <= 1;
        end
        else if(end_cnt)begin
            rvs <= 1;
        end
        else begin
            rvs <= 0;
        end
    end

    //产生输入信号
    initial begin
        for (i = 0; i<1000 ;i = i+1 ) begin
            if(i<143)begin
                #1;
            end
            else begin
                i = 0;
            end
        end
    end
endmodule