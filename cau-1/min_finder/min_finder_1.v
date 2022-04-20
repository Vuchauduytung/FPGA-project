`timescale 1ns / 100ps

module min_finder_1(I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, min1, min2, index_min1);
	input [3:0] I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15;
	output [3:0] min1, min2, index_min1;
	reg [63:0] arr;
	reg [3:0] min1, min2, index_min1;
	integer i;
	
	always@(I0 or I1 or I2 or I3 or I4 or I5 or I6 or I7 or I8 or I9 or I10 or I11 or I12 or I13 or I14 or I15)
		begin
			min1 = 15;
			min2 = 15;
			arr = {I15, I14, I13, I12, I11, I10, I9, I8, I7, I6, I5, I4, I3, I2, I1, I0};
			for (i=0; i<16; i=i+1)
				if (arr[i*4 +: 4] < min1)
					begin
					index_min1 = i;
//					min2 = min1;
					min1 = arr[i*4 +: 4];
					end
				else if (arr[i*4 +: 4] < min2)
					min2 = arr[i*4 +: 4];
		end

endmodule

module test_bench_1(min1, min2, index_min1);
	output [3:0] min1, min2, index_min1;
	reg [3:0] I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15;
	
	min_finder_1 test3(I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, min1, min2, index_min1);
	
	initial 
		begin
			I0=2; I1=3; I2=1; I3=2; I4=5; I5=6; I6=9; I7=9; I8=9; I9=9; I10=9; I11=9; I12=9; I13=9; I14=9; I15=9; #1
			I0=1; I1=4; I2=2; I3=1; I4=2; I5=12; I6=9; I7=9; I8=9; I9=9; I10=9; I11=9; I12=9; I13=9; I14=9; I15=9; #1
			I0=5; I1=2; I2=10; I3=0; I4=4; I5=1; I6=9; I7=9; I8=9; I9=9; I10=9; I11=9; I12=9; I13=9; I14=9; I15=9; 
		end

endmodule