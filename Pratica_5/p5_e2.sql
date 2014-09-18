DECLARE
  v_ano_atual NUMBER;
BEGIN
  --v_ano_atual := to_number(to_char(sysdate,'yyyy'));
  v_ano_atual := 2004;
  FOR c_cargo IN
  (SELECT DISTINCT L10_CARGO.CODCARGO,
    L10_CARGO.NOMEDESCRITIVO,
    L10_CARGO.ANOSMANDATO,
    L10_CARGO.NRODECADEIRAS,
    L10_CARGO.POSSUIVICE,
    COUNT (L09_CANDIDATO.NROCAND) OVER (PARTITION BY L11_CANDIDATURA.REG) AS qtd
  FROM L10_CARGO
  INNER JOIN L11_CANDIDATURA
  ON L10_CARGO.CODCARGO = L11_CANDIDATURA.CODCARGO
  INNER JOIN L09_CANDIDATO
  ON L11_CANDIDATURA.NROCAND = L09_CANDIDATO.NROCAND
  WHERE L10_CARGO.anobase    = v_ano_atual
  ORDER BY L10_CARGO.CODCARGO,
    L10_CARGO.NOMEDESCRITIVO
  )
  LOOP
    dbms_output.put ('Cargo ' || c_cargo.codcargo || ', ' || c_cargo.nomedescritivo ||', ' || c_cargo.anosmandato || ' anos de mandato, ' || c_cargo.nrodecadeiras || ' cadeira.');
    IF c_cargo.possuivice = 1 THEN
      dbms_output.put_line (' Possui vice: Vice-' || c_cargo.nomedescritivo || '. Em '|| v_ano_atual ||', ' || c_cargo.qtd || ' candidatos concorrendo ao cargo.');
    ELSE
      dbms_output.put_line ('Nao possui vice.'|| 'Em '|| v_ano_atual ||', ' || c_cargo.qtd || ' candidatos concorrendo ao cargo.');
    END IF;
  END LOOP;
END;
