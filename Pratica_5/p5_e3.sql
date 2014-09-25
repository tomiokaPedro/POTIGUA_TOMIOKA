DECLARE
  v_data DATE;
  v_aux  DATE;
BEGIN
  FOR c_pesquisa IN
  (SELECT * FROM l12_pesquisa ORDER BY regpesquisa
  )
  LOOP
    IF c_pesquisa.regpesquisa = 1 THEN
      v_data                 := c_pesquisa.periodoinicio;
    ELSE
      v_aux := c_pesquisa.periodoinicio;
      UPDATE l12_pesquisa
      SET periodoinicio = v_data
      WHERE regpesquisa = c_pesquisa.regpesquisa;
      v_data           := v_aux;
    END IF;
  END LOOP;
  
    UPDATE l12_PESQUISA
    SET periodoinicio = v_data
    WHERE regpesquisa = 1;
END;
