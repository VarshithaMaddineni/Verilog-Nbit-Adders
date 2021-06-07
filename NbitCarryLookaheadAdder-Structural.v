//N bit Carry Look Ahead Adder - Verilog Structural Model
module CLA(input [N-1:0] A,
		   input [N-1:0] B,
		   input Cin,
		   output Cout,
		   output [N-1:0] S);
		   
	parameter N = 32;
	genvar i;
	wire [N-1:0] G,P;  //Carry Generate and Propagate
	wire [N:0] C;
	 
	assign C[0] = Cin;

	generate for(i = 0; i < N; i = i + 1)
		begin
		    ha ha0(A[i], B[i], P[i], G[i]);
		    ha ha1(P[i], C[i], S[i], T);     //T = Temporary 
		    assign C[i+1] = G[i] | T;
		end
	endgenerate
    assign Cout = C[N];
endmodule

module ha(m, n, y, c);
	input m, n;
	output y, c;
	
	xor g0(y, m, n);
	and g1(c, m, n);
	
endmodule

module tes
t();
	
	reg [31:0] A, B;
	reg Cin;
	wire Cout;
	wire [31:0] S;
	
	CLA dut(A, B, Cin, Cout, S);
	
	initial
	begin
	$dumpfile ("CLA_S.vcd");
	$dumpvars(0,test);
	$monitor($time , "A=%d, B=%d, Cin=%d, Cout=%d; S=%d", A, B, Cin, Cout, S);
	
	A = 1349;
	B = 4755;
	Cin = 0;
	#15 $finish;
	
	end
endmodule
