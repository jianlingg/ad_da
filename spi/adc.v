`timescale 1ns/1ns
/*ģ��˵��

*/
module adc (
    //global clock
    input clk,
    input rst_n,

    //user interface
    input rvs,
    output dout,//����
    output reg sclk

);
//reg��ַ
//---------------------------------------------------------------------
parameter devi_addr = {8'h00,1'b0},
          rstc_addr = {8'h04,1'b0},
          sdic_addr = {8'h08,1'b0},
          sdoc_addr = {8'h0c,1'b0},
          dout_addr = {8'h10,1'b0},
          rang_addr = {8'h14,1'b0},
          alar_addr = {8'h20,1'b0},
          alah_addr = {8'h24,1'b0},
          alal_addr = {8'h28,1'b0};

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
          clrh = {2'b11000,2'b00,addr, data},          //�����16λ
          reah = {2'b11001,2'b00,addr, {16{1'b0}}},    //��ȡ��16λ
          read = {2'b10001,2'b00,addr, {16{1'b0}}},
          writ = {2'b11010,2'b01,addr, data},           //��Ϊ����дģʽ
          seth = (2'b11011,2'b00,addr, data)



spi_m spi_m_u(
    //global clock
    . clk(clk),
    . rst_n(rst_n),

    //user interface
    . cs_key(cs_key_s),

    . read_flag(read_flag_s),
    . writ_flag(writ_flag_s),

    . writ_data(writ_data),
    . read_data(read_data),
    . rdy(rdy),

    //���ADC���ӵ��ź�
    . sclk(sclk),
    . miso(miso),
    . cs_n(sc_n),
    . mosi(mosi)
);

wire acq_to_rst_start ;
wire acq_to_cov_start ;
wire rst_to_acq_start ;
wire cov_to_acq_start ;
wire cov_to_rst_start ;


localparam  acq = 1;
localparam  rst = 2;
localparam  cov = 3;

always @(posedge clk or negedge rst_n) begin
    if (rst_n==0)
        state_c <= acq ;
    else
        state_c <= state_n;
end

always @(*) begin
    case(state_c)
        acq :begin
            if(acq_to_rst_start)
                state_n = rst ;
            else if(acq_to_cov_start)
                state_n = cov ;
            else
                state_n = state_c ;
        end
        rst :begin
            if(rst_to_acq_start)
                state_n = acq ;
            else
                state_n = state_c ;
        end
        cov :begin
            if(cov_to_acq_start)
                state_n = acq ;
            else if(cov_to_rst_start)
                state_n = rst ;
            else
                state_n = state_c ;
        end
        default : state_n = acq ;
    endcase
end

assign acq_to_rst_start = state_c==acq && ();
assign acq_to_cov_start = state_c==acq && ();
assign rst_to_acq_start = state_c==rst && ();
assign cov_to_acq_start = state_c==cov && ();
assign cov_to_rst_start = state_c==cov && ();


always  @(posedge clk)begin
    if (rvs && rdy) begin
        writ_flag <= 1;
    end
    else begin
        writ_flag <= 0;
    end
end


    
endmodule