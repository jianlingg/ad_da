`timescale 1ns/1ns
/*模块说明
发：该模块接收32位信号，在收到writ_flag后串行输出到spi的从设备
收：该模块收到read_flag后，cs拉低，并接收从设备的串行信号，转化为16位并行输出，

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

    //与从设备连接的信号
    input        rvs,
    input        sclk,
    input        miso,
    output reg   sc_n,
    output reg   mosi
);
//前置信号
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

    //变量选择器
    always  @(*)begin
       case(state_c)
          read:      begin    x=16;      end
          writ:      begin    x=32;      end
          default:   begin    x=32;      end
       endcase
    end

    //加一条件
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

    assign add_cnt = flag_add;
    assign end_cnt = add_cnt && cnt == x-1;
    

//Pin信号
//---------------------------------------------------------------------
//将并行命令转换为spi的串行输出：mosi 先发高位
always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        mosi <= 0;
    end
    else if(add_cnt0)begin
        mosi <=writ_data[31-cnt]
    end
end


//dout  miso：先发高位
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