a) ALTER table L01_ESTADO ADD (GENTILICO VARCHAR2 (30));
ALTER TABLE L01_ESTADO ADD CONSTRAINT cons_gentilico CHECK (length (GENTILICO) > 2) ;
ALTER TABLE L01_ESTADO MODIFY GENTILICO DEFAULT 'Nao consta';

--Nos dados já inseridos na tabela o novo atributo recebe valor nulo, pois não foi definido nas inserções anteriores.

---------------

b) ALTER TABLE L09_CANDIDATO ADD (NOME_CIDADE VARCHAR2 (30));
ALTER TABLE L09_CANDIDATO ADD CONSTRAINT NOME_CIDADE_FK FOREIGN KEY(NOME_CIDADE) references L02_CIDADE(NOME);

---------------

c) 


----------------

d) ALTER TABLE L09_CANDIDATO
DISABLE CONSTRAINT CONS_TIPO_CANDIDATO;

INSERT
INTO L09_CANDIDATO
  (
    SGLPARTIDO,
    TIPO,
    CPF,
    NOME,
    IDADE,
    APELIDO,
    FOTO,
    IMPRESSAODIGITAL,
    NOME_CIDADE
  )
  VALUES
  (
    'PT',
    'NENHUM',
    '14235626',
    'JOAO',
    '25',
    'JO',
    EMPTY_BLOB(),
    EMPTY_BLOB(),
    NULL
  );
  
  ALTER TABLE L09_CANDIDATO
  ENABLE CONSTRAINT CONS_TIPO_CANDIDATO;
  
  Não foi possível habilitar a constraint novamente, pois o sistema acusa o erro no banco de dados.