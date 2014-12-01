
create or replace FUNCTION fn_vitoria_equipe ( 
  p_cod_equipe NUMBER, p_data_atual DATE) RETURN NUMBER AS
  
  v_vitorias NUMBER;
  saldo_gols NUMBER;
  j_cod_equipe NUMBER;

BEGIN
    v_vitorias :=0;
    for c_jogos in (
      select * from jogo where (cod_equipe_mandante = p_cod_equipe or cod_equipe_visitante = p_cod_equipe) AND DATA <= p_data_atual
    )
    loop
      saldo_gols := 0;
      for c_gols in(
        select * from gol where cod_jogo = c_jogos.cod_jogo
      )
      loop
        select cod_equipe into j_cod_equipe from jogador where c_gols.cod_jogador = cod_jogador;
        if j_cod_equipe = p_cod_equipe AND (c_gols.se_gol_contra = 'n' OR c_gols.se_gol_contra is null)
          then 
            saldo_gols := saldo_gols + 1;
            
        else 
            saldo_gols := saldo_gols - 1;
        end if;
       end loop;
        if saldo_gols > 0
        then
          v_vitorias := v_vitorias + 1;
          
        end if;
      
    end loop;
      
   return v_vitorias;
     
END fn_vitoria_equipe;