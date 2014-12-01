CREATE OR REPLACE FUNCTION fn_cartoes_amarelo ( 
  v_cod_jogador Jogador.cod_jogador%TYPE) RETURN NUMBER AS
  
  v_valor NUMBER;

BEGIN
  
     select count (*) into v_valor from cartao where cod_jogador = v_cod_jogador
	 and descricao_cartao = 'amarelo';
	 
	 return v_valor;
     
END fn_cartoes_amarelo;