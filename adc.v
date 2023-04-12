`timescale 1ns/1ns
/*ģ��˵��

*/
module adc (
    //global clock
    input clk,
    input rst_n,

    //user interface
    input din,
    output dout,//����
    output reg sclk

);
//ģʽreg����
//---------------------------------------------------------------------
parameter devi_reg = {{12{1'b0}},{4{1'b0}},{16{1'b0}}},//�豸id����
          rstc_reg = {{32{1'b0}}},                     //��λ�ϵ����
          sdic_reg = {{30{1'b0}},2'b00},               //����ADC���ݵ�Э������cpol=0,cphase=0
          sdoc_reg = {{32{1'b0}}},                     //ADC������ݵ�Э�����
          dout_reg = {{32{1'b0}}},                     //ADC�������������
          rang_reg = {{32{1'b0}}},                     //�����ѹ��Χ�Ŀ���
          alar_reg = {{32{1'b0}}},                     //�����ź�
          alah_reg = {{32{1'b0}}},
          alal_reg = {{32{1'b0}}};
//��������
//---------------------------------------------------------------------
parameter nops = {{32{1'b0}}},
          clrh = {2'b11000,2'b00,addr, data},
          reah = {2'b11001,2'b00,addr, {16{1'b0}}},
          read = {2'b10001,2'b00,addr, {16{1'b0}}},
          writ = {2'b11010,2'b01,addr, data},           //��Ϊ����дģʽ
          seth = (2'b11011,2'b00,addr, data)
reg cs = 1'b1;
reg [2:0]cs_cnt = 3'b0;

//������0:����
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

//����������ת��Ϊspi�Ĵ������
always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        dout <= 0;
    end
    else if(add_cnt0)begin
        dout <=cmd[cnt0]
    end
end


    
endmodule