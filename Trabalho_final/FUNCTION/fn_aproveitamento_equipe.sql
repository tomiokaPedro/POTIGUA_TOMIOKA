
create or replace FUNCTION fn_aproveitamento_equipe ( 
  p_cod_equipe NUMBER, p_data_atual DATE) RETURN NUMBER AS
  
  v_pontuacao_equipe NUMBER;
  v_jogos_equipe NUMBER;
  v_aproveitamento NUMBER;

BEGIN
    
	select fn_pontuacao_equipe (p_cod_equipe, p_data_atual) into v_pontuacao_equipe from dual;
	select fn_qtd_jogos_equipe (p_cod_equipe, p_data_atual) into v_jogos_equipe from dual;
	
	v_aproveitamento := (v_pontuacao_equipe / (v_jogos_equipe* 3))* 100;
	select ROUND (v_aproveitamento, 1) into v_aproveitamento from dual;
	
   return v_aproveitamento;
     
END fn_aproveitamento_equipe;