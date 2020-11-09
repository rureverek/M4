/////////////////////////////////////////////////////////////////////
// Design unit: multiplier
//            :
// File name  : multiplier.sv
//            :
// Description: Code for M4 Lab exercise
//            : Top-level module for shift and add multiplier
//            :
// Limitations: None
//            : 
// System     : SystemVerilog IEEE 1800-2005
//            :
// Author     : Tom Kazmierski & Mark Zwolinski & Piotr Mikulowski
//            : School of Electronics and Computer Science
//            : University of Southampton
//            : Southampton SO17 1BJ, UK
//            : mz@ecs.soton.ac.uk
//            : pm4u19@soton.ac.uk
//
// Revision   : Version 1.0 17/10/13
//            : modified for DE1-SoC: mz, 16/10/17
/////////////////////////////////////////////////////////////////////

module multiplier(input logic start, n_rst, clock, input logic [7:0] Min,
                  output logic ready, output logic[15:0] AQ);

logic C, reset, add_shift, q_en, m_en;
logic [7:0] Sum, M;


adder A0(.A(AQ[15:8]), .M(M), .C(C), .Sum(Sum));
register R0 (.*);
reg_m R1 (.*);
sequencer S(.start(start), .clock(clock), .reset(reset), .Q0(AQ[0]), .n_rst(n_rst),
 .add_shift(add_shift), .add_nshift(add_nshift) , .ready(ready), .q_en(q_en), .m_en(m_en));
  
endmodule
