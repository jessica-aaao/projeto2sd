module seletor(
input clk, 
input sinal, 
output wire Ada, Adb, Adc, Add, Ade, Adf, Adg, Aua, Aub, Auc, Aud, Aue, Auf, Aug,//para cada bcd o conjunto de fios de saída são diferentes
output wire Bda, Bdb, Bdc, Bdd, Bde, Bdf, Bdg, Bua, Bub, Buc, Bud, Bue, Buf, Bug,
output wire Rda, Rdb, Rdc, Rdd, Rde, Rdf, Rdg, Rua, Rub, Ruc, Rud, Rue, Ruf, Rug
output reg ledA, ledB);

reg [7:0] Ad, Au, Bd, Bu, Rc, Rd, Ru;
reg [7:0] cmd;
reg on_off, neg;
parameter Liga = 8'b00010010, Zera_A = 8'b00001111, Zera_B = 8'b00010011, Zera_All = 8'b00010000, Soma = 8'b00011010, Subtrai = 8'b00011110, Inverte = 8'b00001100;
integer last_number;//se = 0(nem A e nem B foram os últimos comandos)
										//se = 1(A foi o último digitado)
										//se = 2(B foi o último digitado)
wire [7:0] Keycode, Number;

initial on_off <= 0;
initial neg <= 0;

always@(sinal)begin//não tenho ctz se precisa do always e se é sempre que sinal mudar mesmo

	leitor CMD(clk, sinal, Keycode);//eu vi que reg não pode ser ligado a uma output port, por isso coloquei um wire primeiro

	cmd = Keycode;

	if(cmd == Liga)begin
		on_off = ~on_off;
		last_number <= 0;
	end

	if(on_off == 1)begin
	/*pensei em acender um led talvez, colocando on_off como output reg*/

	/*Só vai executar o cmd se a tela tiver ligada*/
		case(cmd)
			
		Zera_A:begin
			ledA <= 0;
			Ad <= 0;
			Au <= 0;
			bcd A(Ad, Au, Ada, Adb, Adc, Add, Ade, Adf, Adg, Aua, Aub, Auc, Aud, Aue, Auf, Aug);
			leitor num(clock, sinal, Number);
			Ad <= Number;
			leitor num(clock, sinal, Number);
			Au <= Number;
			bcd A(Ad, Au, Ada, Adb, Adc, Add, Ade, Adf, Adg, Aua, Aub, Auc, Aud, Aue, Auf, Aug);
			last_number <= 1;

		end

		Zera_B:begin
			ledB <= 0;
			Bd <= 0;
			Bu <= 0;
			bcd B(Bd, Bu, Bda, Bdb, Bdc, Bdd, Bde, Bdf, Bdg, Bua, Bub, Buc, Bud, Bue, Buf, Bug);
			leitor num(clock, sinal, Number);//como o sinal vai mudar, ele vai voltar pro inicio do always? Pode atrapalhar?
			Bd <= Number;
			leitor num(clock, sinal, Number);
			Bu <= Number;
			bcd B(Bd, Bu, Bda, Bdb, Bdc, Bdd, Bde, Bdf, Bdg, Bua, Bub, Buc, Bud, Bue, Buf, Bug);
			last_number <= 2;
		
		end

		Zera_All:begin
			ledA <= 0;
			ledB <= 0;
			Ad <= 0;
			Au <= 0;
			Bd <= 0;
			Bu <= 0;
			//zerar resultado(depende de como vai ser bcd)
			bcd A(Ad, Au, Ada, Adb, Adc, Add, Ade, Adf, Adg, Aua, Aub, Auc, Aud, Aue, Auf, Aug);
			bcd B(Bd, Bu, Bda, Bdb, Bdc, Bdd, Bde, Bdf, Bdg, Bua, Bub, Buc, Bud, Bue, Buf, Bug);
			//mandar pro bcd do resultado
			last_number <= 0;
			
		end

		Soma:begin

			last_number <= 0;			
		end

		Subtrai:begin
			
			last_number <= 0;
		end

		Inverte:begin
			neg <= ~neg;
			if(last_number == 1)begin
				ledA <= neg;
			end
			if (last_number == 2) begin
				ledB <= neg;
			end
	end else begin
	//desliga led
		leitura CMD(clk, sinal);		
	end
end
endmodule