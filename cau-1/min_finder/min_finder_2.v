`timescale 1ns / 100ps

module test_bench_2(min1, min2, index_min1);
	output [3:0] min1, min2, index_min1;
	reg [3:0] I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15;
	
	min_finder_2 test4(I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, min1, min2, index_min1);
	
	initial 
		begin
			I0=2; I1=3; I2=1; I3=2; I4=5; I5=6; I6=9; I7=9; I8=9; I9=9; I10=9; I11=9; I12=9; I13=9; I14=9; I15=9; #1
			I0=1; I1=4; I2=2; I3=1; I4=2; I5=12; I6=9; I7=9; I8=9; I9=9; I10=9; I11=9; I12=9; I13=9; I14=9; I15=9; #1
			I0=5; I1=2; I2=10; I3=0; I4=4; I5=1; I6=9; I7=9; I8=9; I9=9; I10=9; I11=9; I12=9; I13=9; I14=9; I15=9; 
		end

endmodule


module min_finder_2(I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, min1, min2, index_min1);
	input [3:0] I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15;
	output [3:0] min1, min2, index_min1;
	wire [3:0] index_min2;
	wire [63:0] arr, new_arr;
	assign arr = {I15, I14, I13, I12, I11, I10, I9, I8, I7, I6, I5, I4, I3, I2, I1, I0};
	
	find_min_in_arr fma1(arr, min1, index_min1);
	replace15_by_index rbi(arr, index_min1, new_arr);
	find_min_in_arr fma2(new_arr, min2, index_min2);

endmodule


module find_min_in_arr(arr, min, index_min);
	input [63:0] arr;
	wire [3:0] I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15;
	output [3:0] min, index_min;

	wire [3:0] min_val_a [7:0], id_out_a [7:0];
	wire [3:0] min_val_b [3:0], id_out_b [3:0];
	wire [3:0] min_val_c [1:0], id_out_c [1:0];
	assign {I15, I14, I13, I12, I11, I10, I9, I8, I7, I6, I5, I4, I3, I2, I1, I0} = arr;
	
	find_min_index match_a0(I0, I1, 0, 1, min_val_a[0], id_out_a[0]);
	find_min_index match_a1(I2, I3, 2, 3, min_val_a[1], id_out_a[1]);
	find_min_index match_a2(I4, I5, 4, 5, min_val_a[2], id_out_a[2]);
	find_min_index match_a3(I6, I7, 6, 7, min_val_a[3], id_out_a[3]);
	find_min_index match_a4(I8, I9, 8, 9, min_val_a[4], id_out_a[4]);
	find_min_index match_a5(I10, I11, 10, 11, min_val_a[5], id_out_a[5]);
	find_min_index match_a6(I12, I13, 12, 13, min_val_a[6], id_out_a[6]);
	find_min_index match_a7(I14, I15, 14, 15, min_val_a[7], id_out_a[7]);
	
	find_min_index match_b0(min_val_a[0], min_val_a[1], id_out_a[0], id_out_a[1], min_val_b[0], id_out_b[0]);
	find_min_index match_b1(min_val_a[2], min_val_a[3], id_out_a[2], id_out_a[3], min_val_b[1], id_out_b[1]);
	find_min_index match_b2(min_val_a[4], min_val_a[5], id_out_a[4], id_out_a[5], min_val_b[2], id_out_b[2]);
	find_min_index match_b3(min_val_a[6], min_val_a[7], id_out_a[6], id_out_a[7], min_val_b[3], id_out_b[3]);
	
	find_min_index match_c0(min_val_b[0], min_val_b[1], id_out_b[0], id_out_b[1], min_val_c[0], id_out_c[0]);
	find_min_index match_c1(min_val_b[2], min_val_b[3], id_out_b[2], id_out_b[3], min_val_c[1], id_out_c[1]);
	
	find_min_index match_d(min_val_c[0], min_val_c[1], id_out_c[0], id_out_c[1], min, index_min);
	
endmodule


module replace15_by_index(arr_in, index, arr_out);
	input [63:0] arr_in;
	output [63:0] arr_out;
	input [3:0] index;
	
	assign arr_out = arr_in | (15 << index*4);

endmodule


module find_min_index(A, B, idA, idB, min_val, id_out);
	input [3:0] A, B, idA, idB;
	output [3:0] min_val, id_out;
	wire Oe, Og, Ol;
	wire [2:0] result;
	reg [3:0] min_val, id_out;
	
	compare_4bit compare_4bit_1(A, B, Oe, Og, Ol);
	assign result = {Ol, Og, Oe};
	
	always @(*)
		case (result)
			3'b001,3'b100:
				begin
				min_val = A;
				id_out = idA;
				end
			3'b010:
				begin
				min_val = B;
				id_out = idB;
				end
			default
				begin
				min_val = 4'bx;
				id_out = 4'bx;
				end
		endcase	

endmodule


module compare_4bit(A, B, Oe, Og, Ol);
	input [3:0] A, B;
	output Oe, Og, Ol;
	wire [1:0] A0, A1, B0, B1;
	wire Oe0, Og0, Ol0, Oe1, Og1, Ol1;
	wire [1:0] R0, R1;
	
	assign A0 = A[1:0];
	assign A1 = A[3:2];
	assign B0 = B[1:0];
	assign B1 = B[3:2];
	
	compare_2bit compare0(A0, B0, Oe0, Og0, Ol0);
	compare_2bit compare1(A1, B1, Oe1, Og1, Ol1);
	simple_result sR0(Oe0, Og0, Ol0, R0);
	simple_result sR1(Oe1, Og1, Ol1, R1);
	compare_result cr(R1, R0, Oe, Og, Ol);
	
endmodule


module compare_2bit(A, B, Oe, Og, Ol);
	input [1:0] A, B;
	output Oe, Og, Ol;
	
	assign Og = (A[1]&~B[1])|(A[0]&~B[1]&~B[0])|(A[1]&A[0]&~B[0]);
	assign Oe = (A[1]~^B[1])&(A[0]~^B[0]);
	assign Ol = (~A[1]&B[1])|(~A[1]&~A[0]&B[0])|(~A[0]&B[1]&B[0]);
	
endmodule


module simple_result(Oe, Og, Ol, R);
	input Oe, Og, Ol;
	output [1:0] R;
	
	assign R[1] = ~Oe&(Ol^Og);
	assign R[0] = ~Og&(Ol^Oe);
	
endmodule


module compare_result(R1, R0, Oe, Og, Ol);
	input [1:0] R0, R1;
	output Oe, Og, Ol;
	
	assign Oe = ~R1[1]&R1[0]&~R0[1]&R0[0];
	assign Og = (R1[1]&~R1[0])|(~R1[1]&R1[0]&R0[1]&~R0[0]);
	assign Ol = (R1[1]&R1[0])|(R1[0]&R0[1]&R0[0]);
	
endmodule
