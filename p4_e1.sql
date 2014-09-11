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
    
  SELECT * FROM vw_candidato;