module bcd(D, U, da, db, dc, dd, de, df, dg, ua, ub, uc, ud, ue, uf, ug);

input [7:0] D, U;
output da, db, dc, dd, de, df, dg, ua, ub, uc, ud, ue, uf, ug;
reg [7:0] one, two;
reg [7:0] SeteSegmentos1, SeteSegmentos2;


always @(*) 
begin
	one <= D;
	two <= U;
	
		case(one)
			8'b0000: SeteSegmentos1 = 7'b0000001; //0						
			8'b0001: SeteSegmentos1 = 7'b1001111; //1							
			8'b0010: SeteSegmentos1 = 7'b0010010; //2							
			8'b0011: SeteSegmentos1 = 7'b0000110; //3						
			8'b0100: SeteSegmentos1 = 7'b1001100; //4							
			8'b0101: SeteSegmentos1 = 7'b0100100; //5							
			8'b0110: SeteSegmentos1 = 7'b0100000; //6							
			8'b0111: SeteSegmentos1 = 7'b0001111; //7							
			8'b1000: SeteSegmentos1 = 7'b0000000; //8								
			8'b1001: SeteSegmentos1 = 7'b0000100; //9				
		endcase
		
		case(two)
			8'b0000: SeteSegmentos2 = 7'b0000001; //0						
			8'b0001: SeteSegmentos2 = 7'b1001111; //1							
			8'b0010: SeteSegmentos2 = 7'b0010010; //2							
			8'b0011: SeteSegmentos2 = 7'b0000110; //3						
			8'b0100: SeteSegmentos2 = 7'b1001100; //4							
			8'b0101: SeteSegmentos2 = 7'b0100100; //5							
			8'b0110: SeteSegmentos2 = 7'b0100000; //6							
			8'b0111: SeteSegmentos2 = 7'b0001111; //7							
			8'b1000: SeteSegmentos2 = 7'b0000000; //8								
			8'b1001: SeteSegmentos2 = 7'b0000100; //9			
		endcase

end

assign {da, db, dc, dd, de, df, dg} = SeteSegmentos1;
assign {ua, ub, uc, ud, ue, uf, ug} = SeteSegmentos2;

endmodule
