/////////////////////////////////////////////////////////////////////
// Design unit: sequencer
//            :
// File name  : sequencer.sv
//            :
// Description: Code for M4 Lab exercise
//            : Outline code for sequencer
//            :
// Limitations: None
//            : 
// System     : SystemVerilog IEEE 1800-2005
//            :
// Author     : 
//            : School of Electronics and Computer Science
//            : University of Southampton
//            : Southampton SO17 1BJ, UK
//            : 
//
// Revision   : Version 1.0 
/////////////////////////////////////////////////////////////////////

module sequencer #(parameter N=4) (input logic start, clock, Q0, n_rst,
 output logic add, shift, ready, reset);
 
enum {IDLE,ADDING,SHIFTING,STOPPED} pres_state, next_state;
logic [7:0] count;

always_ff @(posedge clock, negedge n_rst)
  begin 
    if (~n_rst) begin
      pres_state <= IDLE;
	  count <= N;
	  end
    else begin
	if (next_state == ADDING) count <= count - 1;
	else if (next_state == IDLE) count <= N;
    pres_state <= next_state;
	end
	end



always_comb
  begin
  	add = 1'b0;
	shift = 1'b0;
	reset = 1'b0;
	ready = 1'b0;	
	next_state = pres_state;
	
    unique case(pres_state)
    IDLE: begin
	reset = 1'b1;
	if(start) next_state = ADDING;
	end
	
	ADDING: begin
	next_state = SHIFTING;
	if(Q0) add = 1'b1;
	end
	
	SHIFTING: begin
	shift = 1'b1;
	if(count>0)	
	  next_state = ADDING;
	else
	  next_state = STOPPED;
	end
	
	STOPPED: begin
	ready = 1'b1;
	if(start)
	next_state = IDLE;
	end
	
	default: begin
	next_state = IDLE;
	add = 1'b0;
	shift = 1'b0;
	ready = 1'b0;
	reset = 1'b0;
	end
	
    endcase
end
endmodule

      
              
             