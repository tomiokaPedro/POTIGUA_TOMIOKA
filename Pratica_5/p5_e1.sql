DECLARE
  v_total           NUMBER;
  v_numero_sorteado NUMBER;
  v_count           NUMBER;
  c_ano_atual       NUMBER;
BEGIN
v_count := 0;
  SELECT to_number(TO_CHAR(sysdate, 'YYYY')) INTO c_ano_atual FROM dual;
  SELECT COUNT (*)
  INTO v_total
  FROM l11_candidatura candidatura
  INNER JOIN l09_candidato candidato
  ON candidatura.nrocandidato = candidato.nro
  WHERE candidato.tipo   = 'politico'
  AND candidatura.ano    < c_ano_atual;
  SELECT DBMS_RANDOM.VALUE(1,v_total)
  INTO v_numero_sorteado
  FROM DUAL;
  FOR c_candidatos IN
  (SELECT * FROM l09_candidato WHERE tipo = 'politico' ORDER BY cpf
  )
  LOOP
  dbms_output.put_line (v_count);
    IF v_count = v_numero_sorteado THEN
      dbms_output.put_line(c_candidatos.NRO|| ' ' || c_candidatos.TIPO || ' ' || c_candidatos.CPF || ' ' || c_candidatos.NOME || ' ' || c_candidatos.IDADE || ' ' || c_candidatos.APELIDO || ' ' || c_candidatos.SGLPARTIDO );
    END IF;
    v_count := v_count + 1;
  END LOOP;
   
END;