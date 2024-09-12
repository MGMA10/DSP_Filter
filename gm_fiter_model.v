// -------------------------------------------------------------
// 
// File Name: C:\Users\most'fa\Desktop\ADI\ASS\dsp\fiter_model\gm_fiter_model\gm_fiter_model.v
// Created: 2024-09-12 19:52:51
// 
// Generated by MATLAB 9.10 and HDL Coder 3.18
// 
// 
// -- -------------------------------------------------------------
// -- Rate and Clocking Details
// -- -------------------------------------------------------------
// Model base rate: 0.2
// Target subsystem base rate: 0.2
// 
// 
// Clock Enable  Sample Time
// -- -------------------------------------------------------------
// ce_out        0.2
// -- -------------------------------------------------------------
// 
// 
// Output Signal                 Clock Enable  Sample Time
// -- -------------------------------------------------------------
// y                             ce_out        0.2
// -- -------------------------------------------------------------
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: gm_fiter_model
// Source Path: gm_fiter_model
// Hierarchy Level: 0
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module gm_fiter_model
          (clk,
           reset,
           clk_enable,
           x,
           ce_out,
           y);


  input   clk;
  input   reset;
  input   clk_enable;
  input   [7:0] x;  // uint8
  output  ce_out;
  output  [7:0] y;  // uint8


  wire enb;
  reg [7:0] Delay3_out1;  // uint8
  reg [7:0] Delay_out1;  // uint8
  reg [7:0] Delay1_out1;  // uint8
  wire [7:0] Bit_Shift2_out1;  // uint8
  wire [7:0] Bit_Shift1_out1;  // uint8
  reg [7:0] Delay2_out1;  // uint8
  wire [7:0] Bit_Shift3_out1;  // uint8
  wire [7:0] Sum_out1;  // uint8
  wire [7:0] Sum1_out1;  // uint8
  wire [7:0] Sum2_out1;  // uint8


  assign enb = clk_enable;

  always @(posedge clk or posedge reset)
    begin : Delay3_process
      if (reset == 1'b1) begin
        Delay3_out1 <= 8'b00000000;
      end
      else begin
        if (enb) begin
          Delay3_out1 <= x;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay_process
      if (reset == 1'b1) begin
        Delay_out1 <= 8'b00000000;
      end
      else begin
        if (enb) begin
          Delay_out1 <= Delay3_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay1_process
      if (reset == 1'b1) begin
        Delay1_out1 <= 8'b00000000;
      end
      else begin
        if (enb) begin
          Delay1_out1 <= Delay_out1;
        end
      end
    end



  assign Bit_Shift2_out1 = Delay1_out1 >> 8'd2;



  assign Bit_Shift1_out1 = Delay_out1 >> 8'd1;



  always @(posedge clk or posedge reset)
    begin : Delay2_process
      if (reset == 1'b1) begin
        Delay2_out1 <= 8'b00000000;
      end
      else begin
        if (enb) begin
          Delay2_out1 <= Delay1_out1;
        end
      end
    end



  assign Bit_Shift3_out1 = Delay2_out1 >> 8'd3;



  assign Sum_out1 = Bit_Shift1_out1 + Delay3_out1;



  assign Sum1_out1 = Bit_Shift2_out1 + Sum_out1;



  assign Sum2_out1 = Bit_Shift3_out1 + Sum1_out1;



  assign y = Sum2_out1;

  assign ce_out = clk_enable;

endmodule  // gm_fiter_model

