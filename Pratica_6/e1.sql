CREATE OR REPLACE PROCEDURE SP_INSERE_VALORES(
    P_TABELA               IN VARCHAR2,
    P_NOME_ATRIBUTO        IN VARCHAR2,
    P_VALOR_ATRIBUTO_NOVO  IN VARCHAR2,
    P_VALOR_ATRIBUTO_CHAVE IN VARCHAR2)
AS
  v_pk                NUMBER;
  v_flag              NUMBER DEFAULT 0;
  E_PK_NAO_SIMPLES    EXCEPTION;
  E_TABELA_NAO_EXISTE EXCEPTION;
  sql_stmt            varchar2(2000);
BEGIN
  SELECT COUNT(1)
  INTO v_flag
  FROM USER_IND_COLUMNS
  WHERE TABLE_NAME = upper(P_TABELA);
  
  IF v_flag        = 0 THEN
    RAISE E_TABELA_NAO_EXISTE;
  END IF;
  
  SELECT COUNT(1)
  INTO v_flag
  FROM USER_CONSTRAINTS US
  WHERE CONSTRAINT_TYPE = 'U' AND US.TABLE_NAME = upper(P_TABELA);
  
  sql_stmt := 'update '|| p_tabela || ' set ' || p_nome_atributo || '='|| P_VALOR_ATRIBUTO_NOVO ;
  
  IF v_flag = 0 THEN
    RAISE E_PK_NAO_SIMPLES;
  ELSE
    UPDATE p_tabela
    SET p_nome_atributo = P_VALOR_ATRIBUTO_NOVO;
  END IF;
  
  
  
  
EXCEPTION
WHEN E_PK_NAO_SIMPLES THEN
  dbms_output.put_line('E_PK_NAO_SIMPLES');
WHEN E_TABELA_NAO_EXISTE THEN
  dbms_output.put_line('E_TABELA_NAO_EXISTE');
WHEN OTHERS THEN
  dbms_output.put_line(SQLERRM || ' ERRO grave');
END;
