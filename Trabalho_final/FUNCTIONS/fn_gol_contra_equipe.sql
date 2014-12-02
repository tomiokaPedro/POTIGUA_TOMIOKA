create or replace FUNCTION fn_gol_contra_equipe ( 
  p_cod_equipe NUMBER, p_data_atual DATE) RETURN NUMBER AS
  
  gol_contra_total NUMBER;
  gol_contra_parcial NUMBER;
  j_cod_equipe NUMBER;

BEGIN
    gol_contra_total :=0;
    for c_jogos in (
      select * from jogo where (cod_equipe_mandante = p_cod_equipe or cod_equipe_visitante = p_cod_equipe) AND DATA <= p_data_atual
    )
    loop
      gol_contra_parcial := 0;
      for c_gols in(
        select * from gol where cod_jogo = c_jogos.cod_jogo
      )
      loop
        select cod_equipe into j_cod_equipe from jogador where c_gols.cod_jogador = cod_jogador;
        if (j_cod_equipe <> p_cod_equipe AND (c_gols.se_gol_contra = 'n' OR c_gols.se_gol_contra is null)) OR (j_cod_equipe = p_cod_equipe AND c_gols.se_gol_contra = 's') 
          then 
            gol_contra_parcial := gol_contra_parcial + 1;
		end if;
       end loop;       
	   
	   gol_contra_total := gol_contra_total + gol_contra_parcial;     
      
    end loop;
      
   return gol_contra_total;
     
END fn_gol_contra_equipe;