declare
v_cod_min NUMBER;
v_cod_max NUMBER;
v_cod_sorteado NUMBER;

begin
  
  select min (cod_jogador) into v_cod_min from jogador;
  select max (cod_jogador) into v_cod_max from jogador;

  for i in 1..50
  loop
    select TRUNC(DBMS_RANDOM.VALUE(v_cod_min,v_cod_max)) into v_cod_sorteado from dual;
      SP_INSERE_CARTAO (v_cod_sorteado, 'amarelo');
    
  end loop;
  
  for i in 1..10
  loop
    select TRUNC(DBMS_RANDOM.VALUE(v_cod_min,v_cod_max)) into v_cod_sorteado from dual;
      SP_INSERE_CARTAO (v_cod_sorteado, 'vermelho');
    
  end loop;

end;