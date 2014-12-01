DECLARE
  v_cod_min      NUMBER;
  v_cod_max      NUMBER;
  v_cod_sorteado NUMBER;
BEGIN
    SELECT MIN (cod_jogador) INTO v_cod_min FROM jogador;
    SELECT MAX (cod_jogador) INTO v_cod_max FROM jogador;
  FOR i IN 1..50
  LOOP
      SELECT  TRUNC(DBMS_RANDOM.VALUE(v_cod_min,v_cod_max))
            INTO v_cod_sorteado
            FROM dual;
    SP_INSERE_CARTAO (v_cod_sorteado, 'amarelo');
  END LOOP;
  FOR i IN 1..10
  LOOP
      SELECT  TRUNC(DBMS_RANDOM.VALUE(v_cod_min,v_cod_max))
            INTO v_cod_sorteado
            FROM dual;
    SP_INSERE_CARTAO (v_cod_sorteado, 'vermelho');
  END LOOP;
END;