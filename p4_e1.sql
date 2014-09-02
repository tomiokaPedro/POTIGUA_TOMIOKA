create or replace view vw_candidato (nome, cpf, apelido, total_candidaturas) as SELECT
DISTINCT
  candidato.nome,
  candidato.cpf,
  candidato.apelido,
  COUNT(apelido) OVER (PARTITION BY nome) AS total_candidaturas
FROM candidato
INNER JOIN candidatura
  ON candidato.nrocand = candidatura.nrocand
WHERE (SELECT
  COUNT(1)
FROM candidatura can
WHERE can.reg <> candidatura.reg
AND can.nrocand = candidato.nrocand)
> 0
;

select * from vw_candidato;
