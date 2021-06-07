//Nbit Carry Lookahead Adder Verilog Behavioural Model
module CLA(input [N-1:0] A,
		   input [N-1:0] B,
		   input Cin,
		   output Cout,
		   output reg [N-1:0] S);
		   
	parameter N = 32;
	integer i;
	reg [N-1:0] G;   //Carry Generator
	reg [N-1:0] P;   //Carry Propagator
	reg [N:0] C;
	
	always @(*)
	begin
		C[0] = Cin;
	 for(i = 0; i < N; i = i + 1)
		begin
		G[i] = A[i] & B[i];
		P[i] = A[i] ^ B[i];
		C[i+1] = G[i] | (P[i] & C[i]);
		S[i] = P[i] ^ C[i];
	    end
	end
    	assign Cout = C[N];
endmodule

module test();
	
	parameter N = 32;
	reg [N-1:0] A, B;
	reg Cin;
	wire Cout;
	wire [N-1:0] S;
	
	CLA dut(A, B, Cin, Cout, S);
	
	initial
	begin
	$dumpfile ("CLA_B.vcd");
	$dumpvars(0,test);
	$monitor($time , "A=%d, B=%d, Cin=%d, Cout=%d; S=%d", A, B, Cin, Cout, S);
	
	A = 1209;
	B = 4565;
	Cin = 0;
	#15 $finish;
	
	end
endmodule
