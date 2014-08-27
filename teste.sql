
DECLARE 
    v_data DATE; 
BEGIN 
    v_data := To_date('01/02/2012', 'dd/mm/yyyy'); 

    FOR i IN 1..5 LOOP 
        INSERT INTO l12_pesquisa 
                    (regpesquisa, 
                     periodoinicio, 
                     periodofim, 
                     orgaopesquisa) 
        VALUES      ( i, 
                     v_data + i, 
                     v_data + 2 * i, 
                     'Potigua e Tomioka Pesquisas SA' ); 
    END LOOP; 
END; 
  --
  
  SELECT * FROM l12_pesquisa;
  
  --
BEGIN 
    FOR i IN 1..30 LOOP 
        INSERT INTO l15_computaintencaovotos 
                    (regpesquisa, 
                     regcandid, 
                     total) 
        VALUES      ( Trunc(dbms_random.Value(1, 5)), 
                     i+1, 
                     Trunc(dbms_random.Value(1, 1000)) ); 
    END LOOP; 
END; 

SELECT * FROM COMPUTAINTENCAOVOTOS;

-- Exercicio 2.1

SELECT distinct esfera, sum(NROdecadeiras) over (partition by esfera) as "Total de Cadeiras"  FROM CARGO 

--


