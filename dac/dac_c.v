`timescale 1ns/1ns
/*模块说明
dac转换模块，频率最大为20M，现采用3分频12.5M
*/
module dac_c (
    //global clock
    input         clk,
    input         rst_n,

    //user interface
    input  [15:0] din,
    input         din_vld,

    output        cs,
    output        sclk,
    output reg    sdi,
    output reg    ldac 
);
reg flag_add;
// 分频器:end_cnt_div后是下降沿
//---------------------------------------------------------------------
    parameter div = 3;//分频系数
    reg [div-1:0]cnt_div;
    wire add_cnt_div;
    wire end_cnt_div;
    wire clk_neg = end_cnt_div;
    wire clk_pos = cnt_div[0]==1 && cnt_div[1]==1 && cnt_div[2]==0;

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt_div <= 0;
          end
        else if(add_cnt_div)begin
          if(end_cnt_div)
             cnt_div <= 0;
          else
             cnt_div <= cnt_div + 1;
          end      
    end
  
    assign add_cnt_div = flag_add;
    assign end_cnt_div = add_cnt_div && cnt_div == {div{1'b1}};

    assign sclk = !cs ? cnt_div[div-1] : 0;

    reg [4:0]cnt;
    wire add_cnt;
    wire end_cnt;
    reg [1:0]cnt1;
    wire add_cnt1;
    wire end_cnt1;

    reg [5:0]x;
    
    reg [15:0] dins;

    //
    always  @(*)begin
        if(!rst_n)begin
            dins <= 0;
        end
        else if(din_vld)begin
            dins <= din;
        end
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
    
    assign add_cnt = clk_neg || din_vld;
    assign end_cnt = add_cnt && cnt == x-1;

    //计数器1
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt1 <= 0;
        end
        else if(add_cnt1)begin
           if(end_cnt1)
              cnt1 <= 0;
           else
              cnt1 <= cnt1 + 1;
         end      
    end
    
    assign add_cnt1 = end_cnt;
    assign end_cnt1 = add_cnt1 && cnt1 == 2-1;

    //变量选择器
    always  @(*)begin
       case(cnt1)
          0:      begin    x=17;      end
          1:      begin    x= 1;      end
          default:begin    x= 1;      end
       endcase
    end

    //加一条件
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            flag_add <= 0;
        end
        else if(din_vld)begin
            flag_add <= 1;
        end
        else if(end_cnt)begin 
            flag_add <= 0;
        end
    end


    //cs
    assign cs = ~flag_add;

    //sdi
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            sdi <= 0;
        end
        else if(rdy && (clk_neg || din_vld))begin
            sdi <= dins[15-cnt];
        end
    end

    //ldac
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            ldac <= 1;
        end
        else if(end_cnt)begin
            ldac <= 0;
        end
        else begin
            ldac <= 1;
        end
    end
    

    
endmodule