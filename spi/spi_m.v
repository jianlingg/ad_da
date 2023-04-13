`timescale 1ns/1ns
/*ģ��˵��
������ģ�����32λ������յ�writ_flag���������spi�Ĵ��豸
�գ���ģ���յ�read_flag��cs���ͣ������մ��豸��16λ�������ݣ�ת��Ϊ16λ���������
�����֮����ģ�����һ��������������ת��ģ�顣

*/
module spi_m (
    //global clock
    input clk,
    input rst_n,

    //user interface
    input         cs_key, //����Ƭѡ�źŸߵ͵İ���

    input         read_flag,
    input         writ_flag,

    input      [31:0] writ_data,
    output reg [32:0] read_data,
    output        rdy,

    //���ADC���ӵ��ź�
    input         miso,
    output        sclk,
    output reg    cs_n,
    output reg    mosi
);
//ǰ���ź�
//---------------------------------------------------------------------

    reg [31:0] writ_data_tmp;
    reg [5:0] cnt;
    wire end_cnt;
    wire add_cnt;

    wire idle_to_read_start ;
    wire idle_to_writ_start ;
    wire read_to_idle_start ;
    wire writ_to_idle_start ;
    reg [1:0] state_c, state_n;


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

    assign add_cnt = state_c == writ || state_c == read;
    assign end_cnt = add_cnt && cnt == 32-1;

    //�ݴ�����
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            writ_data_tmp <= 0;
        end
        else if(writ_flag)begin
            writ_data_tmp <= writ_data;
        end
    end
    

//Pin�ź�
//---------------------------------------------------------------------

assign sclk = clk;

//��������Ƭѡ�ź�
always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cs_n <= 1;
    end
    else if (cs_key) begin
        cs_n <= !cs_n;
    end
end

//����������ת��Ϊspi�Ĵ��������mosi �ȷ���λ
always  @(*)begin
    if(add_cnt && state_c == writ)begin
        mosi <= writ_data_tmp[31-cnt];
    end
    else begin
        mosi <= 32'bz;
    end
end

assign rdy = !(state_c == writ);

//dout  miso���ȷ���λ
always  @(*)begin
    if(add_cnt && state_c == read)begin
        read_data[32-cnt] <= miso;
    end
    else begin
        read_data <= 32'bz;
    end
end

    
endmodule