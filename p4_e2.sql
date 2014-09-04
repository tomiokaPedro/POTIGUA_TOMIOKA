CREATE MATERIALIZED VIEW vw_sessoes
(SESSAONRO, NROZONA, NSERIAL, NOMECIDADE, ESTADO, NOME) 
REFRESH FAST 
as select
sessao.SESSAONRO, zona.NROZONA, sessao.NSERIAL as urna, bairro.NOMECIDADE, urna.ESTADO, bairro.NOME
from l06_sessao sessao inner join l03_zona zona on sessao.nrozona = zona.nrozona
inner join l04_bairro bairro on bairro.nrozona = zona.nrozona
inner join l05_urna urna on urna.nrozona = zona.nrozona;