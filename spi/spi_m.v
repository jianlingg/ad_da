`timescale 1ns/1ns
/*ģ��˵��
������ģ�����32λ�źţ����յ�writ_flag���������spi�Ĵ��豸
�գ���ģ���յ�read_flag��cs���ͣ������մ��豸�Ĵ����źţ�ת��Ϊ16λ���������

*/
module spi_m (
    //global clock
    input clk,
    input rst_n,

    //user interface
    input         read_flag,
    input         writ_flag,
    input  [31:0] writ_data,

    output [15:0] read_data,

    //����豸���ӵ��ź�
    input        rvs,
    input        sclk,
    input        miso,
    output reg   sc_n,
    output reg   mosi
);
//ǰ���ź�
//---------------------------------------------------------------------
    wire idle_to_read_start ;
    wire idle_to_writ_start ;
    wire read_to_idle_start ;
    wire writ_to_idle_start ;
    reg [1:0] state_c, state_n;
    reg [4:0] x;


    localparam  idle = 1;
    localparam  read = 2;
    localparam  writ = 3;


    always @(posedge clk or negedge rst_n) begin
    if (rst_n==0)
        state_c <= idle ;
    else
        state_c <= state_n;
    end

    always @(*) begin
    case(state_c)
        idle :begin
            if(idle_to_read_start)
                state_n = read ;
            else if(idle_to_writ_start)
                state_n = writ ;
            else
                state_n = state_c ;
        end
        read :begin
            if(read_to_idle_start)
                state_n = idle ;
            else
                state_n = state_c ;
        end
        writ :begin
            if(writ_to_idle_start)
                state_n = idle ;
            else
                state_n = state_c ;
        end
        default : state_n = idle ;
    endcase
    end

    assign idle_to_read_start = state_c==idle && (read_flag);
    assign idle_to_writ_start = state_c==idle && (writ_flag);
    assign read_to_idle_start = state_c==read && (end_cnt);
    assign writ_to_idle_start = state_c==writ && (end_cnt);

    //����ѡ����
    always  @(*)begin
       case(state_c)
          read:      begin    x=16;      end
          writ:      begin    x=32;      end
          default:   begin    x=32;      end
       endcase
    end

    //��һ����
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            flag_add <= 0;
        end
        else if(writ_flag)begin
            flag_add <= 1;
        end
        else if(end_cnt)begin 
            flag_add <= 0;
        end
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

    assign add_cnt = flag_add;
    assign end_cnt = add_cnt && cnt == x-1;
    

//Pin�ź�
//---------------------------------------------------------------------
//����������ת��Ϊspi�Ĵ��������mosi �ȷ���λ
always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        mosi <= 0;
    end
    else if(add_cnt0)begin
        mosi <=writ_data[31-cnt]
    end
end


//dout  miso���ȷ���λ
always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        read_data <= 0;
    end
    else if(add_cnt)begin
        read_data[15-cnt] <= miso;
    end
end

//
always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cs <= 1;
    end
    else if(idle_to_read_start || idle_to_writ_start)begin
        cs <= 0;
    end
end
    
endmodule