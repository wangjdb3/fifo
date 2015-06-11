module rptr_empty #(parameter ADDRSIZE = 4)
(
	output reg[1:0] rempty,
	output[ADDRSIZE - 1:0] raddr,
	output reg[ADDRSIZE :0] rptr,
	input[ADDRSIZE :0] rq2_wptr,
	input rinc, rclk, rrst_n
);
	reg[ADDRSIZE:0] rbin;
	wire[ADDRSIZE:0] rgraynext, rbinnext, rgray_2next, rbin_2next;
	
	always @(posedge rclk or negedge rrst_n)
		if (!rrst_n)
			{rbin, rptr} <= 0;
		else
			{rbin, rptr} <= {rbinnext, rgraynext};
	
// Memory read - address pointer (okay to use binary to address memory)
	assign raddr = rbin[ADDRSIZE - 1:0];
	assign rbinnext = rbin + (rinc & ~rempty);
	assign rbin_2next = rbinnext + 1'b1;
	assign rgraynext = (rbinnext>>1) ^ rbinnext;
	assign rgray_2next = (rbin_2next>>1) ^ rbin_2next;
// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
// FIFO empty when the next rptr == synchronized wptr or on reset
// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	wire rempty_val, rnextempty_val;
	assign rempty_val = (rgraynext == rq2_wptr);
	assign rnextempty_val = (rgray_2next == rq2_wptr);
	
	always @(posedge rclk or negedge rrst_n)
		if (!rrst_n)
			rempty <= 2'b01;
		else
			rempty <= {rnextempty_val, rempty_val};
	
endmodule
