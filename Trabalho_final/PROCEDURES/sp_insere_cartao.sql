CREATE OR REPLACE PROCEDURE sp_insere_cartao ( 
  v_cod_jogador Jogador.cod_jogador%TYPE, 
  v_descricao_cartao Cartao.descricao_cartao%TYPE) AS

BEGIN
  
    INSERT INTO cartao (cod_jogador, descricao_cartao) VALUES (v_cod_jogador, v_descricao_cartao);
	COMMIT;

EXCEPTION
WHEN OTHERS THEN
  BEGIN 
    dbms_output.put_line ('COD_JOGADOR não encontrado');
    ROLLBACK;
    END;
END sp_insere_cartao;