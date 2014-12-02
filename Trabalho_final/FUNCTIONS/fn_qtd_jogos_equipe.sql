
create or replace FUNCTION fn_qtd_jogos_equipe ( 
  p_cod_equipe NUMBER, p_data_atual DATE) RETURN NUMBER AS
  
  qtd_jogos NUMBER;

BEGIN
   
   select count (*) into qtd_jogos from jogo where (cod_equipe_mandante = p_cod_equipe or cod_equipe_visitante = p_cod_equipe) AND DATA <= p_data_atual;
      
   return qtd_jogos;
     
END fn_qtd_jogos_equipe;