-- A)

CREATE OR REPLACE VIEW vw_candidato (nome, cpf, apelido, total_candidaturas)
AS
  SELECT DISTINCT candidato.nome,
    candidato.cpf,
    candidato.apelido,
    COUNT(1) OVER (PARTITION BY nome) AS total_candidaturas
  FROM candidato
  INNER JOIN candidatura
  ON candidato.nrocand = candidatura.nrocand
  WHERE (SELECT COUNT(1)
    FROM candidatura can
    WHERE can.reg  <> candidatura.reg
    AND can.nrocand = candidato.nrocand) > 0 ;
    
  
-- B)

CREATE OR REPLACE FORCE VIEW "TOMIOKA_P2_NEW"."VW_CANDTR_CAND_CARGO" ("REG", "ANO", "CODCARGO", "NROCAND1", "ESFERA", "NOMEDESCRITIVO", "NOMECIDADE", "SIGLAESTADO", "NOME", "APELIDO", "SIGLAPARTIDO") AS 
  SELECT candidatura.REG,
  candidatura.ANO,
  candidatura.CODCARGO,
  candidatura.NROCAND AS NROCAND1,
  cargo.ESFERA,
  cargo.NOMEDESCRITIVO,
  cargo.NOMECIDADE,
  cargo.SIGLAESTADO,
  candidato.NOME,
  candidato.APELIDO,
  candidato.SIGLAPARTIDO  
FROM candidato
INNER JOIN candidatura
ON candidato.NROCAND = candidatura.NROCAND
INNER JOIN cargo
ON candidatura.CODCARGO = cargo.CODCARGO;


select * from   VW_CANDTR_CAND_CARGO;

--Resultado do select:
REG, ANO, CODCARGO, NROCAND1, ESFERA, NOMEDESCRITIVO, NOMECIDADE, SIGLAESTADO, NOME, APELIDO, SIGLAPARTIDO 
22, 2004, 8, 3, municipal, Prefeito Municipal, Sao Carlos, SP, Adao, Adaozinho, PT    
2, 2000, 1, 3, federal, Presidente da Republica, , , Adao, Adaozinho, PT    
23, 2004, 8, 5, municipal, Prefeito Municipal, Sao Carlos, SP, Marco, Marquinho, PS    
3, 2000, 1, 5, federal, Presidente da Republica, , , Marco, Marquinho, PS    
24, 2004, 8, 7, municipal, Prefeito Municipal, Sao Carlos, SP, Ana, Aninha, PL    
4, 2000, 2, 7, federal, Senador da Republica, , , Ana, Aninha, PL    
25, 2004, 9, 8, municipal, Vereador, Sao Carlos, SP, Flavia, Flavinha, PL    
5, 2000, 2, 8, federal, Senador da Republica, , , Flavia, Flavinha, PL    
26, 2004, 9, 9, municipal, Vereador, Sao Carlos, SP, Carla, Carlinha, PC    
6, 2000, 2, 9, federal, Senador da Republica, , , Carla, Carlinha, PC    
27, 2004, 9, 10, municipal, Vereador, Sao Carlos, SP, Joana, Joaninha, PC    
7, 2000, 3, 10, federal, Deputado Federal, , , Joana, Joaninha, PC    
28, 2004, 10, 11, municipal, Prefeito Municipal, Jau, SP, Jose, Ze, PT    
8, 2000, 3, 11, federal, Deputado Federal, , , Jose, Ze, PT    
9, 2000, 3, 12, federal, Deputado Federal, , , Dirceu, Dirceuzinho, PT    
29, 2004, 10, 13, municipal, Prefeito Municipal, Jau, SP, Valerio, Valerioduto, PT    
10, 2000, 4, 13, estadual, Governador, , SP, Valerio, Valerioduto, PT    
11, 2000, 4, 14, estadual, Governador, , SP, Genuino, Falsario, PT    
30, 2004, 10, 15, municipal, Prefeito Municipal, Jau, SP, Alceu, Alceuzinho, PS    
12, 2000, 4, 15, estadual, Governador, , SP, Alceu, Alceuzinho, PS    
13, 2000, 5, 16, estadual, Deputado Estadual, , SP, Fabio, Fabinho, PS    
31, 2004, 11, 17, municipal, Vereador, Jau, SP, Fernando, Fernandinho, PS    
14, 2000, 5, 17, estadual, Deputado Estadual, , SP, Fernando, Fernandinho, PS    
32, 2004, 11, 18, municipal, Vereador, Jau, SP, Guido, Mantega, PS    
15, 2000, 5, 18, estadual, Deputado Estadual, , SP, Guido, Mantega, PS    
33, 2004, 11, 19, municipal, Vereador, Jau, SP, Bispo, Aleluia, PC    
16, 2000, 6, 19, estadual, Governador, , MG, Bispo, Aleluia, PC    
34, 2004, 12, 20, municipal, Prefeito Municipal, Varzinha, MG, Antonio, Toninho, PC    
17, 2000, 6, 20, estadual, Governador, , MG, Antonio, Toninho, PC    
18, 2000, 6, 21, estadual, Governador, , MG, Laura, Laurinha, PC    
35, 2004, 12, 22, municipal, Prefeito Municipal, Varzinha, MG, Jana, Janinha, PC    
19, 2000, 7, 22, estadual, Deputado Estadual, , MG, Jana, Janinha, PC    
20, 2000, 7, 23, estadual, Deputado Estadual, , MG, Tarzan, Rei da Selva, PC    
36, 2004, 12, 24, municipal, Prefeito Municipal, Varzinha, MG, King, Kong, PC    
21, 2000, 7, 24, estadual, Deputado Estadual, , MG, King, Kong, PC    
37, 2004, 13, 26, municipal, Vereador, Varzinha, MG, Peron, Peroca, PL    
38, 2004, 13, 27, municipal, Vereador, Varzinha, MG, Shreck, I am an ogre!, PL    
39, 2004, 13, 28, municipal, Vereador, Varzinha, MG, Burro, Povo, PL       

-- Inserindo valor na view
INSERT
INTO VW_CANDTR_CAND_CARGO
  (
    REG,
    ANO,
    CODCARGO,
    NROCAND1
  )
  VALUES
  (
    100,
    2014,
    2,
    3
  );

  
-- select * from   VW_CANDTR_CAND_CARGO where reg = 100;
-- 100 2014  2 3 federal Senador da Republica      Adao  Adaozinho PT   


-- Atualizando a view
UPDATE VW_CANDTR_CAND_CARGO SET ANO = 2014 WHERE REG = 150;

-- select * from   VW_CANDTR_CAND_CARGO where reg = 100;
-- 100 2018  2 3 federal Senador da Republica      Adao  Adaozinho PT   

-- Excluindo na view
DELETE FROM VW_CANDTR_CAND_CARGO WHERE REG = 100;

-- select * from   VW_CANDTR_CAND_CARGO where reg = 100;
-- Retorna nulo

