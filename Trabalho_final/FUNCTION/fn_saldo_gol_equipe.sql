
create or replace FUNCTION fn_saldo_gol_equipe ( 
  p_cod_equipe NUMBER, p_data_atual DATE) RETURN NUMBER AS
  
  saldo_gols_total NUMBER;
  saldo_gols NUMBER;
  j_cod_equipe NUMBER;

BEGIN
    saldo_gols_total :=0;
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

          saldo_gols_total := saldo_gols_total + saldo_gols;     
    end loop;
      
   return saldo_gols_total;
     
END fn_saldo_gol_equipe;