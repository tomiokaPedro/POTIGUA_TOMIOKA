-- exercicio 1

INSERT INTO L13_PLEITOCANDIDATURA
  (CODPLEITO, REGCAND
  )
  ( SELECT pleito.codpleito, 
       candidatura.reg 
        FROM   candidatura 
       inner join cargo 
               ON candidatura.codcargo = cargo.codcargo 
       inner join estado 
               ON cargo.siglaestado = estado.sigla 
       inner join pleito 
               ON estado.sigla = pleito.siglaestado
  );


  -- exercicio 2


INSERT INTO l14_computavotos 
            (nrosessao, 
             nrozona, 
             codpleito, 
             regcand, 
             total) 
(SELECT sessao.nrosessao, 
        sessao.nrozona, 
        pleitocandidatura.codpleito, 
        pleitocandidatura.regcand, 
        Trunc(dbms_random.Value(1, 1000)) 
 FROM   sessao 
        inner join zona 
                ON sessao.nrozona = zona.nrozona, 
        pleitocandidatura 
        inner join pleito 
                ON pleitocandidatura.codpleito = pleito.codpleito 
 WHERE  zona.siglaestado = pleito.siglaestado) 


 -- exercicio 3

--inserindo em pesquisa
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
  
--inserindo em l15_computaintencaovotos
  
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

SELECT * FROM COMPUTAINTENCAOVOTOS

japaviadao