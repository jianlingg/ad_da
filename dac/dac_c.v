`timescale 1ns/1ns
/*ģ��˵��
dacת��ģ�飬Ƶ�����Ϊ20M���ֲ���3��Ƶ12.5M
*/
module dac_c (
    //global clock
    input         clk,
    input         rst_n,

    //user interface
    input  [15:0] din,
    input         din_vld,
    output        rdy,

    output reg    cs,
    output        sclk,
    output reg    sdi,
    output reg    ldac 
);
reg flag_add;
// ��Ƶ��:end_cnt_div�����½���
//---------------------------------------------------------------------
    parameter div = 3;//��Ƶϵ��
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

    reg [4:0]cnt0;
    wire add_cnt0;
    wire end_cnt0;
    reg [1:0]cnt1;
    wire add_cnt1;
    wire end_cnt1;
    reg [4:0] x;

    
   reg [16:0] din_tmp;
   wire sdi_en = flag_add || din_vld;
   assign rdy = ~sdi_en ;

    //��һ����
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            flag_add <= 0;
        end
        else if(din_vld)begin
            flag_add <= 1;
        end
        else if(end_cnt1)begin
            flag_add <= 0;
        end
    end

    //������
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
    
    assign add_cnt0 = sdi_en && (clk_neg || din_vld);
    assign end_cnt0 = add_cnt0 && cnt0 == x-1;

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
    
    assign add_cnt1 = end_cnt0;
    assign end_cnt1 = add_cnt1 && cnt1 == 2-1;

    //����ѡ����
    always  @(*)begin
       case(cnt1)
          0:      begin    x=17;      end
          1:      begin    x=1 ;      end
       endcase
    end
    

    //cs
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cs <= 1;
        end
        else if(din_vld)begin
            cs <= 0;
        end
        else if(cnt1 == 0 && end_cnt0) begin
            cs <= 1;
        end
    end

    //�ݴ������16λ���ݣ����ݴ�����ɺ����,��һ��0����Ϊ��Ƶʱ����Ҫ��һ�������ز��ܰѵ�0�����ݲɵ�
    //
    always @(*)begin
        if(!rst_n)begin
           din_tmp <= 0;
        end
        else if(din_vld)begin
            din_tmp = {din,1'b0};
        end
    end
    //sdi 
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            sdi <= 0;
        end
        else if(clk_neg || din_vld)begin
            sdi <= din_tmp[16-cnt0];
        end
    end

    //ldac
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            ldac <= 1;
        end
        else if(end_cnt0 && cnt1 == 0)begin
            ldac <= 0;
        end
        else begin
            ldac <= 1;
        end
    end
    

    
endmodule
