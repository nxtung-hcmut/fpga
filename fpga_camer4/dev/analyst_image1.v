`timescale 1ns / 1ps

module analyst_image1(
			input 	clk,
			input 	rx_data,
			input 	uart_enw	,
			input 	new_frm,
				/////
			input [9:0]	current_pos_x,
			input [9:0]	current_pos_y,
				/////
			output [9:0]	top_pos_x,
			output [9:0]	top_pos_y,
			output [9:0]	bottom_pos_x,
			output [9:0]	bottom_pos_y,
			output [9:0]	left_pos_x,
			output [9:0]	left_pos_y,
			output [9:0]	right_pos_x,
			output [9:0]	right_pos_y,
			output [11:0]	centre_pos_x,
			output [11:0]	centre_pos_y,
			output [9:0]	angle_x,
			output [9:0]	angle_y,
			output chieu_xoay
			
//			//////////////////
//			output [11:0]	centre_pos_x_rs232,
//			output [11:0]	centre_pos_y_rs232,
//			output [9:0]	angle_x_rs232,
//			output [9:0]	angle_y_rs232,
//			output chieu_xoay_rs232,
//			///////////////////
//			output [9:0]	top_pos_x_vga,
//			output [9:0]	top_pos_y_vga,
//			output [9:0]	bottom_pos_x_vga,
//			output [9:0]	bottom_pos_y_vga,
//			output [9:0]	left_pos_x_vga,
//			output [9:0]	left_pos_y_vga,
//			output [9:0]	right_pos_x_vga,
//			output [9:0]	right_pos_y_vga
			);

reg wr_load_r1 = 0;
reg wr_load_r2 = 0;	
always@(posedge clk)
begin
	wr_load_r1 <= new_frm;
	wr_load_r2 <= wr_load_r1;
end
wire	wr_load_flag = ~wr_load_r2 & wr_load_r1;



reg [9:0]	top_pos_x_r = 10'd639;
reg [9:0]	top_pos_y_r = 10'd479;

always@(posedge clk)
begin
	if(wr_load_flag == 1)
		begin
			top_pos_x_r <= 10'd639;
			top_pos_y_r <= 10'd479;	
		end
	else
		begin
			if((uart_enw == 1'b1) && (rx_data == 1'b0))
				begin		
							if (top_pos_y_r > current_pos_y)
								begin
									top_pos_x_r <= current_pos_x;
									top_pos_y_r <= current_pos_y;
								end
							else if((top_pos_y_r == current_pos_y) && (top_pos_x_r > current_pos_x))
								begin
									top_pos_x_r <= current_pos_x;
									top_pos_y_r <= current_pos_y;
								end
							else
								begin
									top_pos_x_r <= top_pos_x_r;
									top_pos_y_r <= top_pos_y_r;
								end
				end
		end
end
assign	top_pos_x = top_pos_x_r;
assign	top_pos_y = top_pos_y_r;	

/////////////////////////////////////////////////////////////////////////////////
reg [9:0]	bottom_pos_x_r = 10'd0;
reg [9:0]	bottom_pos_y_r = 10'd0;	

always@(posedge clk)
begin
	if(wr_load_flag == 1)
		begin
			bottom_pos_x_r <= 10'd0;
			bottom_pos_y_r <= 10'd0;
		end
	else
		begin
			if((uart_enw == 1'b1) && (rx_data == 1'b0))
				begin
							if (bottom_pos_y_r < current_pos_y)
								begin
									bottom_pos_x_r <= current_pos_x;
									bottom_pos_y_r <= current_pos_y;
								end
							else if((bottom_pos_y_r == current_pos_y) && (bottom_pos_x_r < current_pos_x))
								begin
									bottom_pos_x_r <= current_pos_x;
									bottom_pos_y_r <= current_pos_y;
								end
							else
								begin
									bottom_pos_x_r <= bottom_pos_x_r;
									bottom_pos_y_r <= bottom_pos_y_r;
								end
				end
		end
end
assign	bottom_pos_x = bottom_pos_x_r;
assign	bottom_pos_y = bottom_pos_y_r;
//////////////////////////////////////////////////////////////////////////
reg [9:0]	left_pos_x_r = 10'd639;
reg [9:0]	left_pos_y_r = 10'd0;	

always@(posedge clk)
begin
	if(wr_load_flag == 1)
		begin
			left_pos_x_r <= 10'd639;
			left_pos_y_r <= 10'd0;		
		end
	else
		begin
			if((uart_enw == 1'b1) && (rx_data == 1'b0))
				begin
							if (left_pos_x_r > current_pos_x)
								begin
									left_pos_x_r <= current_pos_x;
									left_pos_y_r <= current_pos_y;
								end
							else if((left_pos_x_r == current_pos_x) && (left_pos_y_r < current_pos_y))
								begin
									left_pos_x_r <= current_pos_x;
									left_pos_y_r <= current_pos_y;
								end
							else
								begin
									left_pos_x_r <= left_pos_x_r;
									left_pos_y_r <= left_pos_y_r;
								end
				end
		end
end
assign	left_pos_x = left_pos_x_r;
assign	left_pos_y = left_pos_y_r;	

//////////////////////////////////////////////////////////////////////////////////
reg [9:0]	right_pos_x_r = 10'd0;
reg [9:0]	right_pos_y_r = 10'd479;	

always@(posedge clk)
begin
	if(wr_load_flag == 1)
		begin
			right_pos_x_r <= 10'd0;
			right_pos_y_r <= 10'd479;		
		end
	else
		begin
			if((uart_enw == 1'b1) && (rx_data == 1'b0))
				begin
							if (right_pos_x_r < current_pos_x)
								begin
									right_pos_x_r <= current_pos_x;
									right_pos_y_r <= current_pos_y;
								end
							else if((right_pos_x_r == current_pos_x) && (right_pos_y_r > current_pos_y))
								begin
									right_pos_x_r <= current_pos_x;
									right_pos_y_r <= current_pos_y;
								end
							else
								begin
									right_pos_x_r <= right_pos_x_r;
									right_pos_y_r <= right_pos_y_r;
								end
				end
		end
end
assign	right_pos_x = right_pos_x_r;
assign	right_pos_y = right_pos_y_r;	


 
reg [11:0] centre_pos_x_r;
reg [11:0] centre_pos_y_r;
always@(posedge clk)
begin
	centre_pos_x_r <= top_pos_x_r + bottom_pos_x_r + left_pos_x_r + right_pos_x_r;
	centre_pos_y_r <= top_pos_y_r + bottom_pos_y_r + left_pos_y_r + right_pos_y_r;
end
assign	centre_pos_x = centre_pos_x_r;
assign	centre_pos_y = centre_pos_y_r;	

reg [9:0] angle_x_r;
reg [9:0] angle_y_r;
reg chieu_xoay_r;
always@(posedge clk)
begin
	if ((left_pos_y_r - top_pos_y_r) < (top_pos_x_r - left_pos_x_r))
		begin
			angle_x_r <= top_pos_x_r - left_pos_x_r;
			angle_y_r <= left_pos_y_r - top_pos_y_r;
			chieu_xoay_r <= 1'b1;
		end
	else
		begin
			angle_x_r <= right_pos_x_r - top_pos_x_r;
			angle_y_r <= right_pos_y_r - top_pos_y_r;
			chieu_xoay_r <= 1'b0;
		end
end
assign	angle_x = angle_x_r;
assign	angle_y = angle_y_r;
assign	chieu_xoay = chieu_xoay_r;	
	
//////////////////////////////////////////////////
//reg [11:0]	centre_pos_x_rs232_r;
//reg [11:0]	centre_pos_y_rs232_r;
//reg [9:0]	angle_x_rs232_r;
//reg [9:0]	angle_y_rs232_r;
//reg chieu_xoay_rs232_r;
//
//reg [9:0]	top_pos_x_vga_r;
//reg [9:0]	top_pos_y_vga_r;
//reg [9:0]	bottom_pos_x_vga_r;
//reg [9:0]	bottom_pos_y_vga_r;
//reg [9:0]	left_pos_x_vga_r;
//reg [9:0]	left_pos_y_vga_r;
//reg [9:0]	right_pos_x_vga_r;
//reg [9:0]	right_pos_y_vga_r;
//
//assign	centre_pos_x_rs232 = centre_pos_x_rs232_r;
//assign	centre_pos_y_rs232 = centre_pos_y_rs232_r;
//assign	angle_x_rs232 = angle_x_rs232_r;
//assign	angle_y_rs232 = angle_y_rs232_r;
//assign   chieu_xoay_rs232 = chieu_xoay_rs232_r;
//
//
//assign	top_pos_x_vga = top_pos_x_vga_r;
//assign	top_pos_y_vga = top_pos_y_vga_r;
//assign	bottom_pos_x_vga = bottom_pos_x_vga_r;
//assign	bottom_pos_y_vga = bottom_pos_y_vga_r;
//assign	left_pos_x_vga = left_pos_x_vga_r;
//assign	left_pos_y_vga = left_pos_y_vga_r;
//assign	right_pos_x_vga = right_pos_x_vga_r;
//assign	right_pos_y_vga = right_pos_y_vga_r;
//
//always@(posedge clk)
//begin
//	centre_pos_x_rs232_r <= centre_pos_x_r;
//	centre_pos_y_rs232_r <= centre_pos_y_r;
//	angle_x_rs232_r <= angle_x_r;
//	angle_y_rs232_r <= angle_y_r;
//	chieu_xoay_rs232_r <= chieu_xoay_r;
//	
//	
//	top_pos_x_vga_r <= top_pos_x_r;
//	top_pos_y_vga_r <= top_pos_y_r;
//	bottom_pos_x_vga_r <= bottom_pos_x_r;
//	bottom_pos_y_vga_r <= bottom_pos_y_r;
//	left_pos_x_vga_r <= left_pos_x_r;
//	left_pos_y_vga_r <= left_pos_y_r;
//	right_pos_x_vga_r <= right_pos_x_r;
//	right_pos_y_vga_r <= right_pos_y_r;
//end

//always@(posedge clk)
//begin
//	if (current_pos_y == 480)
//		begin
//			centre_pos_x_rs232_r <= centre_pos_x_r;
//			centre_pos_y_rs232_r <= centre_pos_y_r;
//			angle_x_rs232_r <= angle_x_r;
//			angle_y_rs232_r <= angle_y_r;
//			chieu_xoay_rs232_r <= chieu_xoay_r;
//			
//			
//			top_pos_x_vga_r <= top_pos_x_r;
//			top_pos_y_vga_r <= top_pos_y_r;
//			bottom_pos_x_vga_r <= bottom_pos_x_r;
//			bottom_pos_y_vga_r <= bottom_pos_y_r;
//			left_pos_x_vga_r <= left_pos_x_r;
//			left_pos_y_vga_r <= left_pos_y_r;
//			right_pos_x_vga_r <= right_pos_x_r;
//			right_pos_y_vga_r <= right_pos_y_r;
//		end
//	else
//		begin
//			centre_pos_x_rs232_r <= centre_pos_x_rs232_r;
//			centre_pos_y_rs232_r <= centre_pos_y_rs232_r;
//			angle_x_rs232_r <= angle_x_rs232_r;
//			angle_y_rs232_r <= angle_y_rs232_r;
//			chieu_xoay_rs232_r <= chieu_xoay_rs232_r;
//			
//			top_pos_x_vga_r <= top_pos_x_vga_r;
//			top_pos_y_vga_r <= top_pos_y_vga_r;
//			bottom_pos_x_vga_r <= bottom_pos_x_vga_r;
//			bottom_pos_y_vga_r <= bottom_pos_y_vga_r;
//			left_pos_x_vga_r <= left_pos_x_vga_r;
//			left_pos_y_vga_r <= left_pos_y_vga_r;
//			right_pos_x_vga_r <= right_pos_x_vga_r;
//			right_pos_y_vga_r <= right_pos_y_vga_r;
//		end
//end	
	
	
endmodule