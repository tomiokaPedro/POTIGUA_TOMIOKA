create or replace FUNCTION fn_gol_pro_equipe ( 
  p_cod_equipe NUMBER, p_data_atual DATE) RETURN NUMBER AS
  
  gol_pro_total NUMBER;
  gol_pro_total_parcial NUMBER;
  j_cod_equipe NUMBER;

BEGIN
    gol_pro_total :=0;
    for c_jogos in (
      select * from jogo where (cod_equipe_mandante = p_cod_equipe or cod_equipe_visitante = p_cod_equipe) AND DATA <= p_data_atual
    )
    loop
      gol_pro_total_parcial := 0;
      for c_gols in(
        select * from gol where cod_jogo = c_jogos.cod_jogo
      )
      loop
        select cod_equipe into j_cod_equipe from jogador where c_gols.cod_jogador = cod_jogador;
        if j_cod_equipe = p_cod_equipe AND (c_gols.se_gol_contra = 'n' OR c_gols.se_gol_contra is null)
          then 
            gol_pro_total_parcial := gol_pro_total_parcial + 1;
		end if;
       end loop;       
	   
	   gol_pro_total := gol_pro_total + gol_pro_total_parcial;     
      
    end loop;
      
   return gol_pro_total;
     
END fn_gol_pro_equipe;