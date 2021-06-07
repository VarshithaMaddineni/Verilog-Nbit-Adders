//N bit Ripple Carry Adder - Structural
module NbitAdder(input [N-1:0] A,
				 input [N-1:0] B,
				 input Cin,
				 output [N-1:0] S,
				 output Cout);
	
	parameter N = 32;
    wire [N:0] C;
	assign C[0] = Cin;
	
	genvar i;
	generate
	for(i = 0; i < N; i = i + 1)
	begin
	fa fa1(A[i], B[i], C[i], S[i], C[i+1]);
	end
	endgenerate
	assign Cout = C[N-1];
	
endmodule

module fa(A, B, Cin, S, Cout);
	input A, B, Cin;
	output S, Cout;
	wire w1, w2, w3;
	
    ha h0(A, B, w1, w2);
	ha h1(w1, Cin, S, w3);
	or o1(Cout, w2, w3);
	
endmodule

module ha(A, B, S, C);
	input A, B;
	output S, C;
	
	xor g0(S, A, B);
	and g1(C, A, B);
	
endmodule

//Testbench
module test();

	reg [31:0] A, B;
	reg Cin;
	wire [31:0] S;
	wire C;
	
	NbitAdder dut(A, B, Cin, S, C);
	
	initial 
	begin
	$dumpfile ("NbitadderS.vcd");
	$dumpvars(0,test);
	$monitor ($time, "A=%d, B=%d, Cin=%d, S=%d, C=%d", A, B, Cin, S, C);
	
	A = 5782;
	B = 6785;
	Cin = 1;

  //S = 12568;
	//C = 0;
	#15 $finish;
	
	end
endmodule
