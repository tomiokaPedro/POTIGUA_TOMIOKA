DECLARE
  v_total           NUMBER;
  v_numero_sorteado NUMBER;
  v_count           NUMBER;
  v_flag            NUMBER DEFAULT 0;
  c_ano_atual       NUMBER;
BEGIN
  v_count := 0;
   SELECT to_number(to_char(sysdate, 'yyyy'))
   INTO c_ano_atual FROM dual;
   SELECT COUNT (*) INTO v_total FROM candidato WHERE tipo = 'politico';
   SELECT
      TRUNC(DBMS_RANDOM.VALUE(1,v_total),0)
       INTO
      v_numero_sorteado
       FROM
      DUAL;
  DBMS_OUTPUT.PUT_LINE('Ano Atual: ' || c_ano_atual);
  DBMS_OUTPUT.PUT_LINE('Numero de candidatos: ' || v_total);
  DBMS_OUTPUT.PUT_LINE('Numero sorteado: ' || v_numero_sorteado);
  FOR c_candidatos IN
  (
     SELECT * FROM l09_candidato WHERE tipo = 'politico' ORDER BY cpf
  )
  LOOP
    IF v_count = v_numero_sorteado THEN
       SELECT
          COUNT(1)
           INTO
          v_flag
           FROM
          l11_candidatura candidatura
        INNER JOIN l09_candidato candidato
             ON
          candidatura.nrocand = candidato.nrocand
          WHERE
          candidato.tipo        = 'politico'
          AND candidatura.ano   < c_ano_atual
          AND candidato.NROCAND = v_numero_sorteado;
      IF v_flag                 > 0 THEN
        dbms_output.put_line('Candidato: CPF ' || ' - ' || c_candidatos.CPF || ' ' || c_candidatos.NOME || ', ' || c_candidatos.IDADE || ' ' || c_candidatos.APELIDO || ' ' || c_candidatos.SIGLAPARTIDO );
      ELSE
        dbms_output.put_line('Candidato: CPF ' || ' - ' || c_candidatos.CPF || ' ' || c_candidatos.NOME || ' nao participou de eleicoes ja concluidas, realize uma novo sorteio.');
      END IF;
      EXIT;
    END IF;
    v_count := v_count + 1;
  END LOOP;
END;