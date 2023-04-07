/*
�����ڣ�4096
*/
module dds (
    //global clock
    input  clk,
    input  rst_n,

    //user interface
    input [31:0] Fword,
    input [11:0] Pword,

    output[ 13:0] data     
);
    reg  [31:0] Fword_f;
    reg  [11:0] Pword_f;
    reg  [31:0] phase_add;

    wire [11:0] rom_addr;
    rom rom_u(
        .clka(clk),
        .addra(rom_addr),
        .douta(data)
    );

    //Ƶ�ʿ�����
    always  @(posedge clk)begin
        Fword_f <= Fword;
    end

    //��λ������
    always  @(posedge clk)begin
        Pword_f <= Pword;
    end

    //��λ�ۼ���:��Ƶ
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            phase_add <= 0;
        end
        else begin
            phase_add <= phase_add + Fword_f;
        end
    end

    //��λ������������
    assign rom_addr = phase_add[31:20] + Pword_f;

    
endmodule