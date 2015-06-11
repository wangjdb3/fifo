module wptr_full #(parameter ADDRSIZE = 4)
(
	output reg[1:0] wfull,
	output[ADDRSIZE - 1:0] waddr,
	output reg[ADDRSIZE :0] wptr,
	input[ADDRSIZE :0] wq2_rptr,
	input winc, wclk, wrst_n
);
	reg[ADDRSIZE:0] wbin;
	wire[ADDRSIZE:0] wgraynext, wbinnext, wgray_2next, wbin_2next;
// GRAYSTYLE2 pointer
	always @(posedge wclk or negedge wrst_n)
		if (!wrst_n)
			{wbin, wptr} <= 0;
		else
			{wbin, wptr} <= {wbinnext, wgraynext};
	
// Memory write - address pointer (okay to use binary to address memory)
	assign waddr = wbin[ADDRSIZE - 1:0];
	assign wbinnext = wbin + (winc & ~wfull);
	assign wbin_2next = wbinnext + 1'b1;
	assign wgraynext = (wbinnext>>1) ^ wbinnext;
	assign wgray_2next = (wbin_2next>>1) ^ wbin_2next;
// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
// Simplified version of the three necessary full - tests:
// assign wfull_val=((wgnext[ADDRSIZE] !=wq2_rptr[ADDRSIZE] ) &&
// (wgnext[ADDRSIZE - 1] !=wq2_rptr[ADDRSIZE - 1]) &&
// (wgnext[ADDRSIZE - 2:0]==wq2_rptr[ADDRSIZE - 2:0]));
// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	wire wfull_val, wnextfull_val;
	assign wfull_val = (wgraynext=={~wq2_rptr[ADDRSIZE:ADDRSIZE - 1], wq2_rptr[ADDRSIZE - 2:0]});
	assign wnextfull_val = (wgray_2next=={~wq2_rptr[ADDRSIZE:ADDRSIZE - 1], wq2_rptr[ADDRSIZE - 2:0]});
	
	always @(posedge wclk or negedge wrst_n)
		if (!wrst_n)
			wfull <= 2'b0;
		else
			wfull <= {wnextfull_val, wfull_val};
	
endmodule
