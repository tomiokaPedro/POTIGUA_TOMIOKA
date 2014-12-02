CREATE OR REPLACE PACKAGE PKG_JOGO AS
  
PROCEDURE sp_insere_cartao ( 
  v_cod_jogador Jogador.cod_jogador%TYPE, 
  v_descricao_cartao Cartao.descricao_cartao%TYPE);
  
PROCEDURE sp_insere_gol_partida(
		p_rodada         IN NUMBER,
		p_nome_mandante  IN VARCHAR2,
		p_gol_mandante   IN NUMBER default 0,
		p_gol_visitante  IN NUMBER default 0,
		p_nome_visitante IN VARCHAR2);

END PKG_JOGO;  
/

CREATE OR REPLACE PACKAGE BODY PKG_JOGO AS

PROCEDURE sp_insere_cartao ( 
  v_cod_jogador Jogador.cod_jogador%TYPE, 
  v_descricao_cartao Cartao.descricao_cartao%TYPE) AS

BEGIN
  
     insert into cartao (cod_jogador, descricao_cartao) values (v_cod_jogador, v_descricao_cartao);
     
END sp_insere_cartao;


PROCEDURE sp_insere_gol_partida(
		p_rodada         IN NUMBER,
		p_nome_mandante  IN VARCHAR2,
		p_gol_mandante   IN NUMBER default 0,
		p_gol_visitante  IN NUMBER default 0,
		p_nome_visitante IN VARCHAR2)
AS
	v_stmt          VARCHAR2(4000);
	v_flag          NUMBER DEFAULT 0;
	v_escolhido     NUMBER DEFAULT 0;
	v_cod_jogo      NUMBER;
	v_cod_jogador   NUMBER;
	v_cod_mandante  VARCHAR2(150);
	v_cod_visitante VARCHAR2(150);
BEGIN
		SELECT  cod_jogo,
			cod_equipe_mandante,
			cod_equipe_visitante
					INTO v_cod_jogo,
			v_cod_mandante,
			v_cod_visitante
					FROM jogo
				WHERE cod_equipe_mandante =
			(SELECT cod_equipe FROM equipe WHERE nome_equipe = p_nome_mandante
			)
		AND cod_equipe_visitante =
			(SELECT cod_equipe FROM equipe WHERE nome_equipe = p_nome_visitante
			)
		AND rodada = p_rodada;
	-- insere gol do mandante em um jogador aleatorio
	IF p_gol_mandante > 0 THEN
		FOR i IN 1 .. p_gol_mandante
		LOOP
			v_flag := 0;
			LOOP
				FOR c_jogador IN
				(SELECT * FROM jogador WHERE cod_equipe = v_cod_mandante
				)
				LOOP
						SELECT dbms_random.value(1,10) INTO v_flag FROM DUAL;
					IF v_flag       > 5 THEN
						v_cod_jogador := c_jogador.cod_jogador;
						EXIT;
					END IF;
				END LOOP;
				EXIT
			WHEN v_flag > 5;
			END LOOP;
				INSERT
							INTO GOL
					(
						COD_JOGO,
						COD_JOGADOR
					)
					VALUES
					(
						v_cod_jogo,
						v_cod_jogador
					);
		END LOOP;
	END IF;
	-- insere gol do visitante em um jogador aleatorio
	IF p_gol_visitante > 0 THEN
		FOR i IN 1 .. p_gol_visitante
		LOOP
			v_flag := 0;
			LOOP
				FOR c_jogador IN
				(SELECT * FROM jogador WHERE cod_equipe = v_cod_visitante
				)
				LOOP
						SELECT dbms_random.value(1,10) INTO v_flag FROM DUAL;
					IF v_flag       > 5 THEN
						v_cod_jogador := c_jogador.cod_jogador;
						EXIT;
					END IF;
				END LOOP;
				EXIT
			WHEN v_flag > 5;
			END LOOP;
				INSERT
							INTO GOL
					(
						COD_JOGO,
						COD_JOGADOR
					)
					VALUES
					(
						v_cod_jogo,
						v_cod_jogador
					);
		END LOOP;
	END IF;
END ;
end PKG_JOGO;
/

