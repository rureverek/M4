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
// Author     : Piotr Mikulowski
//            : School of Electronics and Computer Science
//            : University of Southampton
//            : Southampton SO17 1BJ, UK
//            : pm4u19@soton.ac.uk
//
// Revision   : Version 1.0 09/11/2020
/////////////////////////////////////////////////////////////////////

module sequencer #(parameter N=8) (input logic start, clock, Q0, n_rst,
 output logic add_shift, add_nshift,ready, reset, q_en, m_en);
 
enum {IDLE_M,IDLE_Q,ADDING_SHIFTING,STOPPED_FIRST,STOPPED_SECOND} pres_state, next_state;
logic [3:0] count;

always_ff @(posedge clock, negedge n_rst)
  begin 
    if (~n_rst) begin
      pres_state <= IDLE_M;
	  count <= N;
	  end
    else begin
	if (next_state == ADDING_SHIFTING) count <= count - 1;
	else if (next_state == IDLE_M) count <= N;
    pres_state <= next_state;
	end
	end



always_comb
  begin
	add_shift = 1'b0;
	reset = 1'b0;
	ready = 1'b0;
	add_nshift = 1'b0;
	m_en = 1'b0;
	q_en = 1'b0;
	next_state = pres_state;

	
    unique case(pres_state)
    IDLE_M: begin
	reset = 1'b1;
	m_en = 1'b1;
	if(start) next_state = IDLE_Q;
	end
		
	IDLE_Q: begin
	reset = 1'b1;
	q_en = 1'b1;
	next_state = ADDING_SHIFTING;
	end
	
	ADDING_SHIFTING: begin
	if(Q0) add_shift = 1'b1;
	else add_nshift = 1'b1;
	if(count>0)	
	  next_state = ADDING_SHIFTING;
	else
	  next_state = STOPPED_FIRST;
	end
	
	STOPPED_FIRST: begin
	ready = 1'b1;
	m_en = 1'b1;
	next_state = STOPPED_SECOND;
	end
	
	STOPPED_SECOND: begin
	ready = 1'b1;
	if(start)
	next_state = IDLE_M;
	end
	
	default: begin
	next_state = IDLE_M;
	add_shift = 1'b0;
	add_nshift = 1'b0;
	ready = 1'b0;
	reset = 1'b0;
	end
	
    endcase
end


endmodule

      
              
             
