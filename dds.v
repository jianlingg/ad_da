module dds (
    //global clock
    input  clk,
    input  rst_n,

    //user interface
    input [31:0] Fcword,
    input [11:0] Pcword,

    output[ 9:0] data     
);
    reg  [31:0] Fcword_f;
    reg  [12:0] Pcword_f;
    reg  [31:0] phase_add;
    reg  [31:0] phase;

    wire [11:0] rom_addr;


    //频率控制字
    always  @(posedge clk)begin
        Fcword_f <= Fcword;
    end

    //相位控制字
    always  @(posedge clk)begin
        Pcword_f <= Pcword;
    end

    //相位累加器
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            phase_add <= 0;
        end
        else begin
            phase_add <= phase_add + Fcword_f;
        end
    end

    //相位调制器
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            phase <= 0;
        end
        else begin
            phase <= phase_add + Pcword_f;
        end
    end

    assign rom_addr = phase[31:20];

    
endmodule