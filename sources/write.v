module write(
	input CLK,
	input RSTn,
	output winc,rinc,
	output[23:0] wdata,
	input [23:0] rdata,
	input[1:0] wfull,rempty
);
	reg[23:0] data,data_r;
	reg w_en,r_en;
	reg[7:0] i,j;
	
	always @(posedge CLK or negedge RSTn)
		if(!RSTn)
			begin
			data <= 24'd0;
			w_en <= 1'b0;
			i <= 8'd0;
			end
		else
			case (i)
			0:
				if(rempty == 2'b01) begin w_en <= 1'b1; data <= 24'haabbcc; i <= i + 1'b1; end
			1:
				begin w_en <= 1'b1; data <= 24'd1; i <= i + 1'b1; end
			2:
				begin w_en <= 1'b1; data <= 24'd2; i <= i + 1'b1; end
			3:
				begin data <= 24'd3; i <= i + 1'b1; end
			4:
				begin data <= 24'd4; i <= i + 1'b1; end
			5:
				begin data <= 24'd5; i <= i + 1'b1; end
			6:
				begin data <= 24'd6; i <= i + 1'b1; end
			7:
				begin data <= 24'd7; i <= i + 1'b1; end
			8:
				begin data <= 24'd8; i <= i + 1'b1; end
			9:
				begin data <= 24'd9; i <= i + 1'b1; end
			10:
				begin data <= 24'd10; i <= i + 1'b1; end
			11:
				begin data <= 24'd11; i <= i + 1'b1; end
			12:
				begin data <= 24'd12; i <= i + 1'b1; end
			13:
				begin data <= 24'd13; i <= i + 1'b1; end
			14:
				begin data <= 24'd14; i <= i + 1'b1; end
			15:
				if(!wfull[1] && !wfull[0]) begin data <= 24'd15; i <= i + 1'b1; end
				else begin w_en <= 1'b0; data <= 24'h0; i <= 8'd17; end
			16:
				if(!wfull[1] && !wfull[0]) begin data <= 24'd16; i <= i + 1'b1; end
				else begin w_en <= 1'b0; data <= 24'h0; i <= 8'd17; end
			17:
				begin w_en <= 1'b0; data <= 24'h0; end
			endcase
			
	always @(posedge CLK or negedge RSTn)
		if(!RSTn)
			begin
			data_r <= 24'd0;
			r_en <= 1'b0;
			j <= 8'd0;
			end
		else
			case (j)
			0:
				if(wfull == 2'b01) begin r_en <= 1'b1; data_r <= rdata; j <= j + 1'b1; end
			1:
				begin data_r <= rdata; j <= j + 1'b1; end
			2:
				begin data_r <= rdata; j <= j + 1'b1; end
			3:
				begin data_r <= rdata; j <= j + 1'b1; end
			4:
				begin data_r <= rdata; j <= j + 1'b1; end
			5:
				begin data_r <= rdata; j <= j + 1'b1; end
			6:
				begin data_r <= rdata; j <= j + 1'b1; end
			7:
				begin data_r <= rdata; j <= j + 1'b1; end
			8:
				begin data_r <= rdata; j <= j + 1'b1; end
			9:
				begin data_r <= rdata; j <= j + 1'b1; end
			10:
				begin data_r <= rdata; j <= j + 1'b1; end
			11:
				begin data_r <= rdata; j <= j + 1'b1; end
			12:
				begin data_r <= rdata; j <= j + 1'b1; end
			13:
				begin data_r <= rdata; j <= j + 1'b1; end
			14:
				begin data_r <= rdata; j <= j + 1'b1; end
			15:
				if(!rempty[1] && !rempty[0]) begin data_r <= rdata; j <= j + 1'b1; end
				else begin r_en <= 1'b0; data_r <= 24'h0; j <= 8'd17; end
			16:
				if(!rempty[1] && !rempty[0]) begin data_r <= rdata; j <= j + 1'b1; end
				else begin r_en <= 1'b0; data_r <= 24'h0; j <= 8'd17; end
			17:
				begin r_en <= 1'b0; data_r <= 24'h0; end
			endcase
			
	assign wdata = data;
	assign winc = w_en;
	assign rinc = r_en;
	
endmodule
