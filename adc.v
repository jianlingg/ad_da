`timescale 1ns/1ns
/*模块说明

*/
module adc (
    //global clock
    input clk,
    input rst_n,

    //user interface
    input din,
    output dout,//命令
    output reg sclk

);
//模式reg配置
//---------------------------------------------------------------------
parameter devi_reg = {{12{1'b0}},{4{1'b0}},{16{1'b0}}},//设备id设置
          rstc_reg = {{32{1'b0}}},                     //复位断电控制
          sdic_reg = {{30{1'b0}},2'b00},               //输入ADC数据的协议配置cpol=0,cphase=0
          sdoc_reg = {{32{1'b0}}},                     //ADC输出数据的协议控制
          dout_reg = {{32{1'b0}}},                     //ADC输出的数据配置
          rang_reg = {{32{1'b0}}},                     //输入电压范围的控制
          alar_reg = {{32{1'b0}}},                     //报警信号
          alah_reg = {{32{1'b0}}},
          alal_reg = {{32{1'b0}}};
//命令配置
//---------------------------------------------------------------------
parameter nops = {{32{1'b0}}},
          clrh = {2'b11000,2'b00,addr, data},
          reah = {2'b11001,2'b00,addr, {16{1'b0}}},
          read = {2'b10001,2'b00,addr, {16{1'b0}}},
          writ = {2'b11010,2'b01,addr, data},           //分为三种写模式
          seth = (2'b11011,2'b00,addr, data)
reg cs = 1'b1;
reg [2:0]cs_cnt = 3'b0;

//计数器0:命令
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt0 <= 0;
      end
    else if(add_cnt0)begin
      if(end_cnt0)
         cnt0 <= 0;
      else
         cnt0 <= cnt0 + 1;
      end      
end

assign add_cnt0 = !cs;
assign end_cnt0 = add_cnt0 && cnt0 == 32-1;

//将并行命令转换为spi的串行输出
always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        dout <= 0;
    end
    else if(add_cnt0)begin
        dout <=cmd[cnt0]
    end
end


    
endmodule