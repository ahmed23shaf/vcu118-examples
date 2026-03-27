`timescale 1ns / 1ps

module top (
    input  logic clk_n, // Map to AY23
    input  logic clk_p, // Map to AY24
    input  logic rst,   // Map to L19

    output logic led_o  // Map to AT32
);

        logic clk;
        logic [26:0] counter;

    IBUFDS clk_gen (
        .O(clk),
        .I(clk_p),  // 1-bit input: Diff_p
        .IB(clk_n)  // 1-bit input: Diff_n
    );


    always_ff @(posedge clk) begin
        if (rst) begin // CPU_RESET is Active-High on VCU118
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end

    assign led_o = counter[26];

endmodule