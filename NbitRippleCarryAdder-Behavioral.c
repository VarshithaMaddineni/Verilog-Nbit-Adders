module NbitAdder(input [N-1:0] A,
				 input [N-1:0] B,
				 output reg [N-1:0] S,
				 output Cout);
	parameter N=32;			 
	reg [N-1:0] C;
	integer i;

	always @(*)		
	begin	 
	  S[0] = A[0] + B[0];
	  C[0] = A & B;
	
	for(i = 1; i < N;i = i+1)
		begin
		S[i] = A[i] ^ B[i] ^ C[i-1];
		C[i] = (A[i] & B[i]) | (B[i] & C[i-1]) | (A[i] & C[i-1]);
		end
	end
	assign Cout = C[N-1];
endmodule
