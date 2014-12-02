CREATE OR REPLACE FUNCTION fn_cartoes_amarelo(
		v_cod_jogador Jogador.cod_jogador%TYPE)
	RETURN NUMBER
AS
	v_valor NUMBER;
BEGIN
		SELECT  COUNT (*)
					INTO v_valor
					FROM cartao
				WHERE cod_jogador  = v_cod_jogador
		AND descricao_cartao = 'amarelo';
	RETURN v_valor;
END fn_cartoes_amarelo;