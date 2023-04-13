`timescale 1ns/1ns
/*模块说明
发：该模块接收32位命令，在收到writ_flag后串行输出到spi的从设备
收：该模块收到read_flag后，cs拉低，并接收从设备的16位串行数据，转化为16位并行输出，
简而言之，该模块就是一个串并，并串的转换模块。

*/
module spi_m (
    //global clock
    input clk,
    input rst_n,

    //user interface
    input         cs_key, //控制片选信号高低的按键

    input         read_flag,
    input         writ_flag,

    input      [31:0] writ_data,
    output reg [32:0] read_data,
    output        rdy,

    //与从ADC连接的信号
    input         miso,
    output        sclk,
    output reg    cs_n,
    output reg    mosi
);
//前置信号
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

    assign add_cnt = state_c == writ || state_c == read;
    assign end_cnt = add_cnt && cnt == 32-1;

    //暂存命令
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            writ_data_tmp <= 0;
        end
        else if(writ_flag)begin
            writ_data_tmp <= writ_data;
        end
    end
    

//Pin信号
//---------------------------------------------------------------------

assign sclk = clk;

//按键控制片选信号
always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cs_n <= 1;
    end
    else if (cs_key) begin
        cs_n <= !cs_n;
    end
end

//将并行命令转换为spi的串行输出：mosi 先发高位
always  @(*)begin
    if(add_cnt && state_c == writ)begin
        mosi <= writ_data_tmp[31-cnt];
    end
    else begin
        mosi <= 32'bz;
    end
end

assign rdy = !(state_c == writ);

//dout  miso：先发高位
always  @(*)begin
    if(add_cnt && state_c == read)begin
        read_data[32-cnt] <= miso;
    end
    else begin
        read_data <= 32'bz;
    end
end

    
endmodule