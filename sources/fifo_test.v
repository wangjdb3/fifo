module fifo_test(
	input CLK,
	input RSTn
);
	wire [23:0] wdata;
	wire winc;
	wire rinc;
	wire [23:0] rdata;
	wire[1:0] wfull;
	wire[1:0] rempty;
	
	write write(
		.CLK(CLK),
		.RSTn(RSTn),
		.winc(winc),
		.rinc(rinc),
		.wdata(wdata),
		.rdata(rdata),
		.wfull(wfull),
		.rempty(rempty)
	);
	
/*	fifo_ip fifo_ip(
		.data(wdata),
		.rdclk(CLK),
		.rdreq(rinc),
		.wrclk(CLK),
		.wrreq(winc),
		.q(rdata),
		.rdempty(rempty),
		.wrfull(wfull)
	);
*/
	afifo afifo (
		.rdata(rdata),
		.wdata(wdata),
		.wclk(CLK),
		.rclk(CLK),
		.wrst_n(RSTn),
		.rrst_n(RSTn),
		.wfull(wfull),
		.rempty(rempty),
		.winc(winc),
		.rinc(rinc)
	);

endmodule
