-- exercicio 1

BEGIN

  INSERT INTO L13_PLEITOCANDIDATURA (CODPLEITO, REGCAND)
    (SELECT
      pleito.codpleito,
      candidatura.reg
    FROM candidatura
    INNER JOIN cargo
      ON candidatura.codcargo = cargo.codcargo
    INNER JOIN estado
      ON cargo.siglaestado = estado.sigla
    INNER JOIN cidade
      ON cargo.nomecidade = cidade.nome
    INNER JOIN pleito
      ON estado.sigla = pleito.siglaestado
      AND cidade.nome = pleito.nomecidade);

  INSERT INTO L13_PLEITOCANDIDATURA (CODPLEITO, REGCAND)
    (SELECT
      pleito.codpleito,
      candidatura.reg
    FROM pleito,
         candidatura
         INNER JOIN cargo
           ON cargo.codcargo = candidatura.codcargo
    WHERE cargo.nomecidade IS NULL
    AND cargo.siglaestado IS NULL);

  INSERT INTO L13_PLEITOCANDIDATURA (CODPLEITO, REGCAND)
    (SELECT
      pleito.codpleito,
      candidatura.reg
    FROM pleito,
         candidatura
         INNER JOIN cargo
           ON cargo.codcargo = candidatura.codcargo
    WHERE cargo.nomecidade IS NULL
    AND cargo.siglaestado IS NOT NULL
    AND pleito.siglaestado = cargo.siglaestado);


END;

  -- exercicio 2


INSERT INTO l14_computavotos 
            (nrosessao, 
             nrozona, 
             codpleito, 
             regcand, 
             total) 
(SELECT distinct sessao.nrosessao, 
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
 WHERE  zona.siglaestado = pleito.siglaestado) ;


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

-- Exercicio 2.1

SELECT distinct esfera, sum(NROdecadeiras) over (partition by esfera) as "Total de Cadeiras"  FROM CARGO 

-- Ex 2.2

SELECT  s.NROSESSAO, s.NROZONA, s.NSERIAL
FROM   sessao s 
       inner join zona z 
               ON z.nrozona = s.nrozona 
       inner join cidade 
               ON nome = nomecidade 
WHERE  populacao > 100000 

-- Ex 2.3


SELECT DISTINCT partido.*
FROM   partido 
        join candidato 
              ON partido.sigla = candidato.siglapartido 
        join candidatura 
              ON candidato.nrocand = candidatura.nrocand 
        join cargo 
              ON candidatura.codcargo = cargo.codcargo 
WHERE  Upper(cargo.esfera) = Upper('ESTADUAL'); 


-- Ex 2.D

SELECT DISTINCT cargo.nomedescritivo                   AS "Cargo", 
                cidade.NOME                       AS "Cidade", 
                estado.nome                            AS "Estado", 
                candidato.nome                         AS "Nome Candidato", 
                candidato.nrocand                      AS "Nro Candidato", 
                vice.nome                              AS "Nome Vice", 
                vice.nrocand                           AS "Nro Vice", 
                SUM(computavotos.total) 
                  over ( 
                    PARTITION BY computavotos.regcand) AS "Total de Votos" 
FROM   candidatura
       left outer join  candidato 
         ON candidatura.nrocand = candidato.nrocand
       inner join computavotos 
         ON computavotos.regcand = candidatura.reg 
       left outer join cargo 
         ON candidatura.codcargo = cargo.codcargo 
      left join cidade on
      cargo.NOMECIDADE = cidade.NOME
       left join estado 
         ON cargo.siglaestado = estado.sigla 
       left join candidato vice 
         ON vice.nrocand = candidatura.nrovice 
WHERE  candidatura.ano = 2004 

ORDER  BY cargo.nomedescritivo, 
          "Total de Votos" DESC; 
          
-- 2.E

SELECT pesquisa.*, (PERIODOFIM - PERIODOINICIO) as "Duração (dias)" FROM pesquisa where (PERIODOFIM - PERIODOINICIO) > 30

-- 2.F

SELECT DISTINCT cargo.nomedescritivo                   AS "Cargo", 
                cargo.nomecidade                       AS "Cidade", 
                estado.nome                            AS "Estado", 
                candidato.nome                         AS "Nome Candidato", 
                candidato.nrocand                      AS "Nro Candidato", 
                vice.nome                              AS "Nome Vice", 
                vice.nrocand                           AS "Nro Vice", 
                nvl(Avg(computavotos.total) 
                  over ( 
                    PARTITION BY computavotos.regcand),0) AS "total de votos" 
FROM   candidato 
        join candidatura 
         ON candidato.nrocand = candidatura.nrocand
       full outer join computavotos 
                    ON computavotos.regcand = candidatura.reg 
       full outer join cargo 
                    ON candidatura.codcargo = cargo.codcargo 
       full outer join estado 
                    ON cargo.siglaestado = estado.sigla 
       full outer join candidato vice 
                    ON vice.nrocand = candidatura.nrovice 
WHERE  cargo.nomedescritivo IS NOT NULL
ORDER  BY cargo.nomedescritivo, 
          "total de votos" DESC; 
          
          --
          
          
          
SELECT DISTINCT cargo.nomedescritivo                   AS "Cargo", 
                cargo.nomecidade                       AS "Cidade", 
                estado.nome                            AS "Estado", 
                candidato.nome                         AS "Nome Candidato", 
                candidato.nrocand                      AS "Nro Candidato", 
                vice.nome                              AS "Nome Vice", 
                vice.nrocand                           AS "Nro Vice", 
                Avg(computavotos.total) 
                  over ( 
                    PARTITION BY computavotos.regcand) AS "total de votos" 
FROM   candidato, 
       candidatura, 
       computavotos, 
       cargo, 
       estado, 
       candidato vice 
WHERE  candidato.nrocand = candidatura.nrocand 
       AND computavotos.regcand = candidatura.reg 
       AND candidatura.codcargo = cargo.codcargo 
       AND nvl(cargo.siglaestado, 'SP') = estado.sigla
       AND vice.nrocand = nvl(candidatura.nrovice ,0)
ORDER  BY cargo.nomedescritivo, 
          "total de votos" DESC; 
