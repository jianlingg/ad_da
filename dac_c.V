/*模块说明
时钟：50M四分频产生12.5M

*/
module dac_c (
    //global clock
    input  clk,
    input  rst_n,

    //user interface
    output sclk

);
//adc的时钟
//---------------------------------------------------------------------
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

    assign add_cnt = ;
    assign end_cnt = add_cnt && cnt == ;

    //输入adc
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            sclk <= 1;
        end
        else if(end_cnt)begin
            sclk <= !sclk;
        end
    end
//---------------------------------------------------------------------



endmodule