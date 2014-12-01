CREATE OR REPLACE PROCEDURE sp_insere_cartao ( 
  v_cod_jogador Jogador.cod_jogador%TYPE, 
  v_descricao_cartao Cartao.descricao_cartao%TYPE) AS

BEGIN
  
     insert into cartao (cod_jogador, descricao_cartao) values (v_cod_jogador, v_descricao_cartao);
     
END sp_insere_cartao;