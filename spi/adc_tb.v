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

//---------------------------------------------------------------------
    .rvs(rvs),
    .cs(cs),
    .sclk(sclk)
);
   reg [33:0] i;

   always  @(posedge clk)begin
       
   end

    //���ɱ���ʱ��50M
    initial clk = 1;
    always #(CYCLE/2) clk=~clk;
    

    //������λ�ź�
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

    //���������ź�
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