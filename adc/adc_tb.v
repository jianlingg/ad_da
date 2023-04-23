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
    

    //ʱ�����ڣ���λΪns�����ڴ��޸�ʱ�����ڡ�
    parameter CYCLE    = 20;

    //��λʱ�䣬��ʱ��ʾ��λ3��ʱ�����ڵ�ʱ�䡣
    parameter RST_TIME = 3 ;

    always  @(posedge clk)begin
        rst_n <= rsts;
    end

//�����Ե�ģ������
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
    .mosi(mosi)//����SDI
);
   reg [33:0] i;
   reg [10:0] cnt;
   wire add_cnt;
   wire end_cnt;
   reg [10:0] cnt1;
    wire add_cnt1;
    wire end_cnt1;



//���ɱ���ʱ��50M
    initial clk = 1;
    always #(CYCLE/2) clk=~clk;
    
    //������λ�ź�
    initial begin
        rsts= 1;
        #2;
        rsts = 0;
        #(CYCLE*RST_TIME);
        rsts = 1;
    end


//������
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
assign end_cnt = add_cnt && cnt == 100-1;

reg [15:0] ex = 16'b1011_1111_1111_1111;//���񵽵�����
always  @(*)begin
    if(add_cnt && cnt < 16)begin
        miso <= ex[15-cnt];
    end
    else begin
        miso <= 1'bz;
    end
end

//������1
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

assign add_cnt1 = cs;
assign end_cnt1 = add_cnt1 && cnt1 == 50-1;

//
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            rvs <= 1;
        end
        else if(end_cnt1)begin
            rvs <= 1;
        end
        else begin
            rvs <= 0;
        end
    end

endmodule