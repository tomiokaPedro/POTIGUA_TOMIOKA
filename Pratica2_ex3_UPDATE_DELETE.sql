UPDATE L01_ESTADO
SET NOME    = 'São Paulo'
WHERE sigla =
  (SELECT sigla FROM L01_estado WHERE L01_estado.SIGLA = 'SP'
  );
  
UPDATE L01_ESTADO
SET NOME    = 'Rio de Janeiro'
WHERE sigla =
  (SELECT sigla FROM L01_estado WHERE L01_estado.SIGLA = 'RJ'
  );
  
DELETE FROM L13_PLEITOCANDIDATURA WHERE CODPLEITO = 2; 
