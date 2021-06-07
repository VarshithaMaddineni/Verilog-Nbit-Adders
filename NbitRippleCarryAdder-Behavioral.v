//N bit Ripple Carry Adder Behavioural Model
module NbitAdder(input [N-1:0] A,
		 input [N-1:0] B,
		 input Cin,
		 output reg [N-1:0] S,
		 output Cout);

	parameter N=32;			 
	reg [N:0] C;
	integer i;
    
	always @(*)		
	begin	 
	C[0] = Cin;
	for(i = 0; i < N; i = i+1)
		begin
		S[i] = A[i] ^ B[i] ^ C[i];
		C[i+1] = (A[i] & B[i]) | (B[i] & C[i]) | (A[i] & C[i]);
		end
	end
	assign Cout = C[N];
endmodule

module test();

	reg [31:0] A, B;
	reg Cin;
	wire [31:0] S;
	wire C;
	
	NbitAdder dut(A, B, Cin, S, C);
	
	initial 
	begin
	$dumpfile ("Nbitadder.vcd");
	$dumpvars(0,test);
	$monitor ($time, "A=%d, B=%d, Cin=%d, S=%d, C=%d", A, B, Cin, S, C);
	
	A = 1209;
	B = 4565;
	Cin = 1;
	#15 $finish;
	
	end
endmodule
