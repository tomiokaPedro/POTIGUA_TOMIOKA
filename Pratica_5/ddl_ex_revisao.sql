/*

DROP TABLE Receita_has_Remedio;

DROP TABLE Receita;

DROP TABLE Medico;

DROP TABLE Remedio;

*/

CREATE TABLE Remedio (
  codigo NUMBER   NOT NULL ,
  nome VARCHAR2(50)    ,
  fabricante VARCHAR2(50)    ,
  preco NUMBER    ,
  obs VARCHAR2(1000)      ,
PRIMARY KEY(codigo));




CREATE TABLE Medico (
  crm NUMBER   NOT NULL ,
  nome VARCHAR2(80)    ,
  email VARCHAR2(50)    ,
  telefone VARCHAR2(25)    ,
  endereco VARCHAR2(50)      ,
PRIMARY KEY(crm));




CREATE TABLE Receita (
  numero NUMBER   NOT NULL ,
  Medico_crm NUMBER   NOT NULL ,
  data_receita DATE    ,
  tipo varchar2(30)    ,
  controle varchar2(3)     ,
PRIMARY KEY(numero),
  FOREIGN KEY(Medico_crm)
    REFERENCES Medico(crm));


CREATE INDEX IFK_medico_Receita ON Receita (Medico_crm);


CREATE TABLE Receita_has_Remedio (
  Receita_numero NUMBER   NOT NULL ,
  Remedio_codigo NUMBER   NOT NULL ,
  prazo NUMBER    ,
  dosagem VARCHAR2(50)      ,
PRIMARY KEY(Receita_numero, Remedio_codigo),
  FOREIGN KEY(Receita_numero)
    REFERENCES Receita(numero),
  FOREIGN KEY(Remedio_codigo)
    REFERENCES Remedio(codigo));


CREATE INDEX IFK_Rel_04 ON Receita_has_Remedio (Receita_numero);
CREATE INDEX IFK_Rel_05 ON Receita_has_Remedio (Remedio_codigo);


alter table RECEITA add constraint ck_tipo check(controle in ('sim', 'nao')) ENABLE

CREATE SEQUENCE SQ_NUMERO_RECEITA START WITH 1 NOCACHE ORDER ;

CREATE  TRIGGER BI_NUMERO_RECEITA BEFORE
  INSERT ON receita FOR EACH ROW WHEN (NEW.numero IS NULL) BEGIN :NEW.numero := SQ_NUMERO_RECEITA.nextval;
END;
/
