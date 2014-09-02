/*

DROP TABLE L15_COMPUTAINTENCAOVOTOS;
DROP TABLE L14_COMPUTAVOTOS;
DROP TABLE L13_PLEITOCANDIDATURA;
DROP TABLE L12_PESQUISA;
DROP TABLE L11_CANDIDATURA;
DROP TABLE L10_CARGO; 
DROP TABLE L09_CANDIDATO;
DROP TABLE L08_PARTIDO;
DROP TABLE L07_PLEITO;
DROP TABLE L06_SESSAO;
DROP TABLE L05_URNA;
DROP TABLE L04_BAIRRO;
DROP TABLE L03_ZONA;
DROP TABLE L02_CIDADE;
DROP TABLE L01_ESTADO;

drop index CIDADE_FKINDEX1;
drop index L03_ZONA_FKINDEX1;
drop index L05_URNA_FKINDEX1;
drop index L06_SESSAO_FKINDEX1;
drop index L06_SESSAO_FKINDEX2;
drop index L07_PLEITO_FKINDEX1;
drop index L09_CANDIDATO_FKINDEX1;
drop index L11_CANDIDATURA_FKINDEX1;
drop index L11_CANDIDATURA_FKINDEX2;
drop index IFK_REL_18;
drop index IFK_REL_19;

drop sequence SQ_NROZONA;
 drop sequence SQ_SESSAONRO;
 drop sequence SQ_CODPLEITO;
 drop sequence SQ_NRO;
 drop sequence SQ_COD;
 drop sequence SQ_REG;
 drop sequence SQ_REGPESQUISA;


drop trigger BI_NROZONA ;
drop trigger BI_SESSAONRO ;
drop trigger BI_CODPLEITO ;
drop trigger BI_NRO ;
drop trigger BI_COD ;
drop trigger BI_REG ;
drop trigger BI_REGPESQUISA ;

*/



CREATE TABLE L01_ESTADO
  (
    SIGLA VARCHAR2 (2 BYTE) NOT NULL ,
    NOME  VARCHAR2 (30 BYTE)
  )
  ;
ALTER TABLE L01_ESTADO ADD CONSTRAINT L01_ESTADO_PK PRIMARY KEY ( SIGLA ) ;

CREATE TABLE L02_CIDADE
  (
    NOME      VARCHAR2 (30 byte) NOT NULL ,
    SGLESTADO VARCHAR2 (2 BYTE) NOT NULL ,
    POPULACAO NUMBER
  )
  ;
CREATE INDEX CIDADE_FKINDEX1 ON L02_CIDADE
  (
    SGLESTADO ASC
  )
  ;
ALTER TABLE L02_CIDADE ADD CONSTRAINT L02_CIDADE_PK PRIMARY KEY ( NOME ) ;

CREATE TABLE L03_ZONA
  (
    NROZONA          NUMBER NOT NULL ,
    NOMECIDADE       VARCHAR2(30 byte) NOT NULL ,
    NROURNASRESERVAS NUMBER DEFAULT 0
  )
  ;
CREATE INDEX L03_ZONA_FKINDEX1 ON L03_ZONA
  (
    NOMECIDADE ASC
  )
  ;
ALTER TABLE L03_ZONA ADD CONSTRAINT L03_ZONA_PK PRIMARY KEY ( NROZONA ) ;

CREATE TABLE L04_BAIRRO
  (
    CEP        NUMBER NOT NULL ,
    NROZONA    NUMBER NOT NULL ,
    NOMECIDADE VARCHAR2 (30 byte) NOT NULL ,
    NOME       VARCHAR2 (50 BYTE)
  )
  ;
ALTER TABLE L04_BAIRRO ADD CONSTRAINT L04_BAIRRO_PK PRIMARY KEY ( CEP ) ;

CREATE TABLE L05_URNA
  (
    NSERIAL NUMBER NOT NULL ,
    NROZONA NUMBER NOT NULL ,
    ESTADO  VARCHAR2 (30 BYTE)
  )
  ;
CREATE INDEX L05_URNA_FKINDEX1 ON L05_URNA
  (
    NROZONA ASC
  )
  ;
ALTER TABLE L05_URNA ADD CONSTRAINT L05_URNA_PK PRIMARY KEY ( NSERIAL ) ;

CREATE TABLE L06_SESSAO
  (
    SESSAONRO NUMBER NOT NULL ,
    NSERIAL   NUMBER NOT NULL ,
    NROZONA   NUMBER NOT NULL
  )
  ;
CREATE INDEX L06_SESSAO_FKINDEX1 ON L06_SESSAO
  (
    NROZONA ASC
  )
  ;
CREATE INDEX L06_SESSAO_FKINDEX2 ON L06_SESSAO
  (
    NSERIAL ASC
  )
  ;
ALTER TABLE L06_SESSAO ADD CONSTRAINT L06_SESSAO_PK PRIMARY KEY ( SESSAONRO ) ;

CREATE TABLE L07_PLEITO
  (
    CODPLEITO         NUMBER NOT NULL ,
    L02_CIDADE_NOME   VARCHAR2(30) NOT NULL ,
    ANO               NUMBER ,
    TOTALDECANDIDATOS NUMBER DEFAULT 0
  )
  ;
CREATE INDEX L07_PLEITO_FKINDEX1 ON L07_PLEITO
  (
    L02_CIDADE_NOME ASC
  )
  ;
ALTER TABLE L07_PLEITO ADD CONSTRAINT L07_PLEITO_PK PRIMARY KEY ( CODPLEITO ) ;

CREATE TABLE L08_PARTIDO
  (
    SIGLA VARCHAR2 (2 BYTE) NOT NULL ,
    NOME  VARCHAR2 (40 BYTE)
  )
  ;
ALTER TABLE L08_PARTIDO ADD CONSTRAINT L08_PARTIDO_PK PRIMARY KEY ( SIGLA ) ;

CREATE TABLE L09_CANDIDATO
  (
    NRO        NUMBER NOT NULL ,
    SGLPARTIDO VARCHAR2 (2 BYTE) NOT NULL ,
    TIPO       VARCHAR2 (30 BYTE) ,
    CPF        VARCHAR2 (30 BYTE) ,
    NOME       VARCHAR2 (30 BYTE) ,
    IDADE      NUMBER ,
    APELIDO    VARCHAR2 (30 BYTE) ,
    FOTO BLOB ,
    IMPRESSAODIGITAL BLOB
  )
  ;
ALTER TABLE L09_CANDIDATO ADD CONSTRAINT CONS_TIPO_CANDIDATO CHECK ( TIPO IN ('Especial', 'Politico')) ;
CREATE INDEX L09_CANDIDATO_FKINDEX1 ON L09_CANDIDATO
  (
    SGLPARTIDO ASC
  )
  ;
ALTER TABLE L09_CANDIDATO ADD CONSTRAINT L09_CANDIDATO_PK PRIMARY KEY ( NRO ) ;

CREATE TABLE L10_CARGO
  (
    COD            NUMBER NOT NULL ,
    POSSUIVICE     NUMBER ,
    ANOBASE        NUMBER ,
    ANOSMANDATO    NUMBER ,
    NOMEDESCRITIVO VARCHAR2 (30 BYTE) ,
    NROCADEIRAS    NUMBER ,
    ESFERA         VARCHAR2 (30 BYTE)
  )
  ;
ALTER TABLE L10_CARGO ADD CONSTRAINT CONS_POSSUI_VICE_BOL CHECK ( POSSUIVICE BETWEEN 0 AND 1) ;
ALTER TABLE L10_CARGO ADD CONSTRAINT CONS_ESFERA CHECK ( ESFERA IN ('Estadual', 'Federal', 'Municipal')) ;
ALTER TABLE L10_CARGO ADD CONSTRAINT L10_CARGO_PK PRIMARY KEY ( COD ) ;

CREATE TABLE L11_CANDIDATURA
  (
    REG          NUMBER NOT NULL ,
    ANO          NUMBER ,
    CODCARGO     NUMBER NOT NULL ,
    NROCANDIDATO NUMBER NOT NULL
  )
  ;
CREATE INDEX L11_CANDIDATURA_FKINDEX1 ON L11_CANDIDATURA
  (
    NROCANDIDATO ASC
  )
  ;
CREATE INDEX L11_CANDIDATURA_FKINDEX2 ON L11_CANDIDATURA
  (
    CODCARGO ASC
  )
  ;
ALTER TABLE L11_CANDIDATURA ADD CONSTRAINT L11_CANDIDATURA_PK PRIMARY KEY ( REG ) ;

CREATE TABLE L12_PESQUISA
  (
    REGPESQUISA   NUMBER NOT NULL ,
    PERIODOINICIO DATE ,
    PERIODOFIM    DATE ,
    ORGAOPESQUISA VARCHAR2 (30 BYTE)
  )
  ;
ALTER TABLE L12_PESQUISA ADD CONSTRAINT L12_PESQUISA_PK PRIMARY KEY ( REGPESQUISA ) ;

CREATE TABLE L13_PLEITOCANDIDATURA
  (
    CODPLEITO    NUMBER NOT NULL ,
    REGCANDIDATO NUMBER NOT NULL
  )
  ;

CREATE TABLE L14_COMPUTAVOTOS
  (
    CODPLEITO      NUMBER NOT NULL ,
    SESSAONRO      NUMBER NOT NULL ,
    REGCANDIDATURA NUMBER NOT NULL ,
    TOTAL          NUMBER DEFAULT 0
  )
  ;

CREATE TABLE L15_COMPUTAINTENCAOVOTOS
  (
    REGCANDIDATURA NUMBER NOT NULL ,
    REGPESQUISA    NUMBER NOT NULL ,
    TOTAL          NUMBER DEFAULT 0 NOT NULL
  )
  ;
CREATE INDEX IFK_REL_18 ON L15_COMPUTAINTENCAOVOTOS
  (
    REGPESQUISA ASC
  )
  ;
CREATE INDEX IFK_REL_19 ON L15_COMPUTAINTENCAOVOTOS
  (
    REGCANDIDATURA ASC
  )
  ;

ALTER TABLE L15_COMPUTAINTENCAOVOTOS ADD CONSTRAINT L15_COMPTNTVOTOS_L11_CAND_FK FOREIGN KEY ( REGCANDIDATURA ) REFERENCES L11_CANDIDATURA ( REG ) ON DELETE CASCADE;
ALTER TABLE L09_CANDIDATO ADD CONSTRAINT SYS_C007715 FOREIGN KEY ( SGLPARTIDO ) REFERENCES L08_PARTIDO ( SIGLA ) ON DELETE CASCADE;
ALTER TABLE L02_CIDADE ADD CONSTRAINT SYS_C007719 FOREIGN KEY ( SGLESTADO ) REFERENCES L01_ESTADO ( SIGLA ) ON DELETE CASCADE;
ALTER TABLE L07_PLEITO ADD CONSTRAINT SYS_C007723 FOREIGN KEY ( L02_CIDADE_NOME ) REFERENCES L02_CIDADE ( NOME ) ON DELETE CASCADE;
ALTER TABLE L11_CANDIDATURA ADD CONSTRAINT SYS_C007728 FOREIGN KEY ( NROCANDIDATO ) REFERENCES L09_CANDIDATO ( NRO ) ON DELETE CASCADE;
ALTER TABLE L11_CANDIDATURA ADD CONSTRAINT SYS_C007729 FOREIGN KEY ( CODCARGO ) REFERENCES L10_CARGO ( COD ) ON DELETE CASCADE;
ALTER TABLE L03_ZONA ADD CONSTRAINT SYS_C007733 FOREIGN KEY ( NOMECIDADE ) REFERENCES L02_CIDADE ( NOME ) ON DELETE CASCADE;
ALTER TABLE L05_URNA ADD CONSTRAINT SYS_C007737 FOREIGN KEY ( NROZONA ) REFERENCES L03_ZONA ( NROZONA ) ON DELETE CASCADE;
ALTER TABLE L15_COMPUTAINTENCAOVOTOS ADD CONSTRAINT SYS_C007745 FOREIGN KEY ( REGPESQUISA ) REFERENCES L12_PESQUISA ( REGPESQUISA ) ON DELETE CASCADE;
ALTER TABLE L06_SESSAO ADD CONSTRAINT SYS_C007757 FOREIGN KEY ( NROZONA ) REFERENCES L03_ZONA ( NROZONA ) ON DELETE CASCADE;
ALTER TABLE L06_SESSAO ADD CONSTRAINT SYS_C007758 FOREIGN KEY ( NSERIAL ) REFERENCES L05_URNA ( NSERIAL ) ON DELETE CASCADE;
ALTER TABLE L13_PLEITOCANDIDATURA ADD CONSTRAINT SYS_C007783 FOREIGN KEY ( CODPLEITO ) REFERENCES L07_PLEITO ( CODPLEITO ) ON DELETE CASCADE;
ALTER TABLE L13_PLEITOCANDIDATURA ADD CONSTRAINT SYS_C007784 FOREIGN KEY ( REGCANDIDATO ) REFERENCES L11_CANDIDATURA ( REG ) ON DELETE CASCADE;
ALTER TABLE L04_BAIRRO ADD CONSTRAINT SYS_C007789 FOREIGN KEY ( NOMECIDADE ) REFERENCES L02_CIDADE ( NOME ) ON DELETE CASCADE;
ALTER TABLE L04_BAIRRO ADD CONSTRAINT SYS_C007790 FOREIGN KEY ( NROZONA ) REFERENCES L03_ZONA ( NROZONA ) ON DELETE CASCADE;
ALTER TABLE L14_COMPUTAVOTOS ADD CONSTRAINT SYS_C007794 FOREIGN KEY ( SESSAONRO ) REFERENCES L06_SESSAO ( SESSAONRO ) ON DELETE CASCADE;
ALTER TABLE L14_COMPUTAVOTOS ADD CONSTRAINT SYS_C007795 FOREIGN KEY ( REGCANDIDATURA ) REFERENCES L11_CANDIDATURA ( REG ) ON DELETE CASCADE;
ALTER TABLE L14_COMPUTAVOTOS ADD CONSTRAINT SYS_C007796 FOREIGN KEY ( CODPLEITO ) REFERENCES L07_PLEITO ( CODPLEITO ) ON DELETE CASCADE;


CREATE SEQUENCE SQ_NROZONA START WITH 1 NOCACHE ORDER ;
CREATE TRIGGER BI_NROZONA BEFORE
  INSERT ON L03_ZONA FOR EACH ROW WHEN (NEW.NROZONA IS NULL) BEGIN :NEW.NROZONA := SQ_NROZONA.NEXTVAL;
END;
/

CREATE SEQUENCE SQ_SESSAONRO START WITH 1 NOCACHE ORDER ;
CREATE TRIGGER BI_SESSAONRO BEFORE
  INSERT ON L06_SESSAO FOR EACH ROW WHEN (NEW.SESSAONRO IS NULL) BEGIN :NEW.SESSAONRO := SQ_SESSAONRO.NEXTVAL;
END;
/

CREATE SEQUENCE SQ_CODPLEITO START WITH 1 NOCACHE ORDER ;
CREATE TRIGGER BI_CODPLEITO BEFORE
  INSERT ON L07_PLEITO FOR EACH ROW WHEN (NEW.CODPLEITO IS NULL) BEGIN :NEW.CODPLEITO := SQ_CODPLEITO.NEXTVAL;
END;
/

CREATE SEQUENCE SQ_NRO START WITH 1 NOCACHE ORDER ;
CREATE TRIGGER BI_NRO BEFORE
  INSERT ON L09_CANDIDATO FOR EACH ROW WHEN (NEW.NRO IS NULL) BEGIN :NEW.NRO := SQ_NRO.NEXTVAL;
END;
/

CREATE SEQUENCE SQ_COD START WITH 1 NOCACHE ORDER ;
CREATE TRIGGER BI_COD BEFORE
  INSERT ON L10_CARGO FOR EACH ROW WHEN (NEW.COD IS NULL) BEGIN :NEW.COD := SQ_COD.NEXTVAL;
END;
/

CREATE SEQUENCE SQ_REG START WITH 1 NOCACHE ORDER ;
CREATE TRIGGER BI_REG BEFORE
  INSERT ON L11_CANDIDATURA FOR EACH ROW WHEN (NEW.REG IS NULL) BEGIN :NEW.REG := SQ_REG.NEXTVAL;
END;
/

CREATE SEQUENCE SQ_REGPESQUISA START WITH 1 NOCACHE ORDER ;
CREATE TRIGGER BI_REGPESQUISA BEFORE
  INSERT ON L12_PESQUISA FOR EACH ROW WHEN (NEW.REGPESQUISA IS NULL) BEGIN :NEW.REGPESQUISA := SQ_REGPESQUISA.NEXTVAL;
END;
/
