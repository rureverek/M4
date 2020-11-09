/////////////////////////////////////////////////////////////////////
// Design unit: register
//            :
// File name  : register.sv
//            :
// Description: Code for M4 Lab exercise
//            : registers C and AQ
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

module register (input logic clock, reset, add_shift,add_nshift, C, q_en, m_en,
              input logic[7:0] Min, Sum, output logic[15:0] AQ);

logic Creg; // MSB carry bit storage

always_ff @ (posedge clock)
  if (reset && q_en)  // clear C,A and load Q, M
  begin
   Creg <= 0;
   AQ[15:8] <= 0;
   AQ[7:0] <= Min; // load multiplier into Q
  end
  else if (add_shift) // out Sum in A, Q and shift 
  begin
 //  Creg <= C;
 //  AQ[7:4] <= Sum;
   {Creg,AQ} <= {1'b0,C,Sum,AQ[7:1]};
  end
  else if (add_nshift)// shift A, Q
  begin
   {Creg,AQ} <= {1'b0,C,AQ[15:1]};
  end
  else if (!reset && m_en)
  begin
  AQ[7:0] <= AQ[15:8];
  end
  
endmodule
