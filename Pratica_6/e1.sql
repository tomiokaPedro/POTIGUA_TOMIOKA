create or replace PROCEDURE SP_INSERE_VALORES(
    P_TABELA               IN VARCHAR2,
    P_NOME_ATRIBUTO        IN VARCHAR2,
    P_VALOR_ATRIBUTO_NOVO  IN VARCHAR2,
    P_VALOR_ATRIBUTO_CHAVE IN VARCHAR2)
AS
  v_pk_column_id      VARCHAR2(35);
  v_flag              NUMBER DEFAULT 0;
  E_PK_NAO_SIMPLES    EXCEPTION;
  E_TABELA_NAO_EXISTE EXCEPTION;
  sql_stmt            VARCHAR2(2000);
BEGIN
--Verifica a existencia da tabela
  SELECT COUNT(1)
  INTO v_flag
  FROM USER_IND_COLUMNS
  WHERE upper(TABLE_NAME) = upper(P_TABELA);
  
  IF v_flag        = 0 THEN
    RAISE E_TABELA_NAO_EXISTE;
  END IF;
  
-- Verifica se a chave da tabela nao eh uma unique
  SELECT COUNT(1)
  INTO v_flag
  FROM USER_CONSTRAINTS US
  WHERE CONSTRAINT_TYPE = 'U' AND US.TABLE_NAME = upper(P_TABELA);
  
  IF v_flag <> 0 THEN
    RAISE E_PK_NAO_SIMPLES;
  end if;
  
  SELECT column_name
  INTO v_pk_column_id
  FROM USER_IND_COLUMNS
  WHERE table_name = P_TABELA AND column_position = 1;

  sql_stmt := 'update '|| p_tabela || ' set ' || p_nome_atributo ||
  ' = '''|| P_VALOR_ATRIBUTO_NOVO ||''' where ' || p_tabela || '.' 
  || v_pk_column_id|| ' = ' || P_VALOR_ATRIBUTO_CHAVE;
    
  --Executa o comando SQL 
  EXECUTE immediate SQL_STMT;
    

    dbms_output.put_line('Stmt: ' || SQL_STMT);

EXCEPTION
WHEN E_PK_NAO_SIMPLES THEN
  dbms_output.put_line('E_PK_NAO_SIMPLES');
WHEN E_TABELA_NAO_EXISTE THEN
  dbms_output.put_line('E_TABELA_NAO_EXISTE');
WHEN OTHERS THEN
  dbms_output.put_line(SQLERRM || ' ERRO grave ' || SQL_STMT );
END;