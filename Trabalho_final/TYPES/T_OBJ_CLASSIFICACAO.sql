CREATE OR REPLACE TYPE T_OBJ_CLASSIFICACAO
AS
	OBJECT
	(
		NOME_TIME      VARCHAR2(150),
		PONTUACAO      NUMBER,
		QTD_JOGOS      NUMBER,
		QTD_VITORIAS   NUMBER,
		QTD_EMPATES    NUMBER,
		QTD_DERROTAS   NUMBER,
		GOLS_PRO       NUMBER,
		GOLS_CONTRA    NUMBER,
		GOLS_SALDO     NUMBER,
		APROVEITAMENTO NUMBER );
	/