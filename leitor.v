module leitor(clk, sinal, keyCode);

input clk,sinal;
output reg [7:0] keyCode;

reg contador, cont_bits, pos;

initial contador = 0; 
initial pos = 0;
initial cont_bits = 0;

always @(posedge clk || sinal) begin
	
	if (sinal==1)begin
			contador <= contador+1;//quantidade de pulsos - sinal high
	end

	if (sinal == 0)begin
		cont_bits <= cont_bits+1;//quantidade de bits recebidos pelo sinal
		if(cont_bits > 17 && cont_bits <= 25)begin//intervalo do key code
			if(contador == 23000)begin
				keyCode[pos] <= 0;
				pos <= pos+1;
			end
			if(contador == 79000)begin
				keyCode[pos] <= 1;
				pos <= pos+1;
			end
		end

		if(cont_bits == 34)begin
			pos <= 0;	
			cont_bits <= 0;	
		end
		contador <= 0;
	end
end

endmodule