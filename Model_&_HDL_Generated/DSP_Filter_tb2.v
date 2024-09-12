`timescale 1ns/1ps

module DSP_Filter_tb2;

    // Parameters
    localparam N = 7;  // Bit-width of input and output signals

    // Testbench Signals
    reg clk;           // Clock signal
    reg rst;           // Reset signal
    reg [N:0] x;       // Input signal
    wire [N:0] y;      // Output signal
    reg clk_enable = 1;
    wire ce_out;
    // File I/O reg
    reg [N:0] input_file [100:0];
    reg [N:0] output_file [100:0];
 /*
    // Instantiate the DUT (Device Under Test)
    DSP_Filter #(N) dut (
        .clk(clk),
        .rst(rst),
        .x(x),
        .y(y)
    );
*/
gm_fiter_model dut
          (clk,
           rst,
           clk_enable,
           x,
           ce_out,
           y);

    // We will use it in the for loop
    integer n;

    // Clock Generation
    always begin
        #5 clk = ~clk; // 10ns clock period
    end

    // Reset Task
    task reset_task;
        begin
                rst = 0;
            #10 rst = 1;
            #10 rst = 0;
        end
    endtask

    // Test Scenario
    initial begin

        // Open input.txt for reading and output.txt for writing

        $readmemh("input1.txt",input_file);
        $readmemh("output1.txt",output_file);

        clk = 0;
        reset_task;

        for (n=0;n<100;n=n+1)
                begin
                   // load_data (input_file[n]);
                    x = input_file[n];
                    # 10
                    if(y == output_file[n])
                    $display("Process succeeded :) ");
                    else
                    $display("Process faild :( ");
                end

        



        // Finish the simulation
        #50;
        $stop;
    end


    task load_data;
    
        input reg [7:0] IN_UnderTest;
        begin
        begin
            reset_task;
            x = IN_UnderTest;
        end
    end
endtask
endmodule
