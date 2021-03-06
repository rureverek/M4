/////////////////////////////////////////////////////////////////////
// Design unit: reg_m
//            :
// File name  : reg_m.sv
//            :
// Description: Code for M4 Lab exercise
//            : Storage register for m input of multiplier
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
// Revision   : Version 1.0 16/10/17
/////////////////////////////////////////////////////////////////////

module reg_m #(parameter N=8) (input logic clock, reset, q_en, m_en,
              input logic[N-1:0] Min, output logic[N-1:0] M);

always_ff @ (posedge clock)
  if (reset && m_en)  // clear C,A and load Q, M
    M <= Min;

endmodule
