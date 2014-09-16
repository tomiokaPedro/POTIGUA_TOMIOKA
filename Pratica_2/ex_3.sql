SELECT candidato.*,
  candidatura.*
FROM candidato
INNER JOIN candidatura
ON candidato.nrocand = candidatura.nrocand
INNER JOIN cargo
ON candidatura.codcargo = cargo.codcargo
WHERE possuivice        = 1;
----------------------------
SELECT candidato.*
FROM candidato,
  candidatura
WHERE EXISTS
  (SELECT *
  FROM cargo
  WHERE candidatura.CODCARGO = cargo.CODCARGO
  AND cargo.possuivice       = 1
  )
AND candidato.NROCAND = candidatura.nrocand;
------------------------------
SELECT candidato.*
FROM candidato,
  candidatura
WHERE candidato.NROCAND IN
  (SELECT candidatura.NROCAND
  FROM cargo
  WHERE candidatura.CODCARGO = cargo.CODCARGO
  AND cargo.possuivice       = 1
  )
AND candidato.NROCAND = candidatura.nrocand;
