module comparator_df1(input [3:0] A,B, output Gt,Sm,Eq);

assign Gt = (A[3]& ~B[3]) | ((A[3]~^B[3]) & (A[2]& ~B[2])) | ((A[3]~^B[3]) & (A[2]~^B[2]) & (A[1]& ~B[1])) | ((A[3]~^B[3]) & (A[2]~^B[2]) & (A[1]~^B[1]) & (A[0]& ~B[0]));	//A>B
assign Eq = &(A ~^ B);
assign Sm = ~(Gt | Eq); 
endmodule