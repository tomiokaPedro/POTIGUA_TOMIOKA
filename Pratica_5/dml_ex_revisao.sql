-- Insert em Medico
INSERT
INTO MEDICO
  (
    CRM, NOME, EMAIL, TELEFONE, ENDERECO
  )
  VALUES
  (
    12345, 'Pedro Tomioka', 'pedro.tomioka@gmail.com', '061-99651122',
    'SQS 110 Bl A ap 103'
  );
INSERT
INTO MEDICO
  (
    CRM, NOME, EMAIL, TELEFONE, ENDERECO
  )
  VALUES
  (
    123456, 'Pedro Potiguara', 'pedro.harry.potter@gmail.com', '',
    'SQS 110 Bl A ap 103'
  );
-- Insert em Receita
INSERT
INTO RECEITA
  (
    MEDICO_CRM, DATA_RECEITA, TIPO, CONTROLE
  )
  VALUES
  (
    12345, to_date('30/01/1990', 'dd/mm/yyyy'), 'tipo 1', 'sim'
  );
INSERT
INTO RECEITA
  (
    MEDICO_CRM, DATA_RECEITA, TIPO, CONTROLE
  )
  VALUES
  (
    123456, to_date('30/01/1994', 'dd/mm/yyyy'), 'tipo 2', 'nao'
  );
-- insert em Remedio
INSERT
INTO REMEDIO
  (
    CODIGO, NOME, FABRICANTE, PRECO, OBS
  )
  VALUES
  (
    1, 'Calcitran', 'Calciao', 150, 'bom para os ossos'
  );
INSERT
INTO REMEDIO
  (
    CODIGO, NOME, FABRICANTE, PRECO, OBS
  )
  VALUES
  (
    2, 'Simancol', 'Zueira SA', 10000, 'Nao tem limite de uso'
  );
-- insert em Receita_has_remedio
INSERT
INTO RECEITA_HAS_REMEDIO
  (
    RECEITA_NUMERO, REMEDIO_CODIGO, PRAZO, DOSAGEM
  )
  VALUES
  (
    1, 1, 30, 'Uma vez ao dia'
  );
INSERT
INTO RECEITA_HAS_REMEDIO
  (
    RECEITA_NUMERO, REMEDIO_CODIGO, PRAZO, DOSAGEM
  )
  VALUES
  (
    2, 2, 45, 'Uma vez a cada 15 dias'
  );
-- Insert end/
-- Views
CREATE OR REPLACE VIEW VW_MEDICO_TOTAL_RECEITAS
  (
    CRM, NOME, EMAIL, TELEFONE, N_RECEITAS
  )
AS
  SELECT MEDICO.CRM, MEDICO.NOME, MEDICO.EMAIL, MEDICO.TELEFONE, COUNT(
    RECEITA.NUMERO) over (partition BY medico.crm) AS N_RECEITAS
  FROM MEDICO
  INNER JOIN RECEITA
  ON RECEITA.MEDICO_CRM = MEDICO.CRM;
CREATE OR REPLACE VIEW vw_remedios_receita (NUMERO, MEDICO_CRM, DATA_RECEITA,
  TIPO, CONTROLE, NOME, PRAZO, DOSAGEM)
AS
  SELECT receita.NUMERO, receita.MEDICO_CRM, receita.DATA_RECEITA, receita.TIPO
    , receita.CONTROLE, remedio.NOME, receita_has_remedio.PRAZO,
    receita_has_remedio.DOSAGEM
  FROM receita
  INNER JOIN receita_has_remedio
  ON receita_has_remedio.RECEITA_NUMERO = receita.NUMERO
  INNER JOIN remedio
  ON receita_has_remedio.REMEDIO_CODIGO = remedio.CODIGO;
  -- end view
  -- bloco pl/sql com delete e procedure
CREATE OR REPLACE PROCEDURE SP_DELETA_RECEITA_MEDICO(
    v_crm_medico IN NUMBER )
AS
BEGIN
  DELETE
  FROM receita_has_remedio
  WHERE receita_numero IN
    (
      SELECT numero
      FROM receita
      WHERE medico_crm = v_crm_medico
    );
  DELETE
  FROM receita
  WHERE medico_crm = v_crm_medico;
END SP_DELETA_RECEITA_MEDICO;
-- update
UPDATE MEDICO
SET email = 'pedro.tomioka@walla.com'
WHERE CRM = 12345
  -- fim update