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
*/

-- a integridade dos ciclos L02-L03-L04, L02-L05-L07, e L07-L11-L14 deve ser garantida com logica;
--1.L01Estado

CREATE TABLE L01_ESTADO (
  Sigla  CHAR(2)       NOT NULL,
  Nome   VARCHAR(100)  NOT NULL,

  CONSTRAINT PK_ESTADO PRIMARY KEY (Sigla),
  CONSTRAINT UN_NOMEESTADO UNIQUE (Nome)
);

--2.L02Cidade

CREATE TABLE L02_CIDADE (
  Nome         VARCHAR(100)  NOT NULL,
  SiglaEstado  CHAR(2)       NOT NULL,

  Populacao    NUMBER(9)     NOT NULL,

  CONSTRAINT PK_CIDADE PRIMARY KEY (Nome,SiglaEstado),
  CONSTRAINT FK_ESTADOCIDADE FOREIGN KEY (SiglaEstado)
     REFERENCES L01_ESTADO(Sigla) ON DELETE CASCADE,
  CONSTRAINT CK_POPULACAOCIDADE CHECK (Populacao >= 0)
);

--3.L03Zona
-- o total de urnas reservas de uma dada zona deve ser calculado de tempos em tempos via processamento, gerando um relatório que indicará a necessidade de compra de novas urnas.

CREATE TABLE L03_ZONA (
  NroZona             NUMBER(6)  NOT NULL,
  NroDeUrnasReservas  NUMBER(2)  NOT NULL,

  NomeCidade      VARCHAR(100),
  SiglaEstado     CHAR(2),

  CONSTRAINT PK_ZONA PRIMARY KEY (NroZona),
  CONSTRAINT FK_CIDADEZONA FOREIGN KEY (NomeCidade,SiglaEstado)
     REFERENCES L02_CIDADE(Nome,SiglaEstado)
);

--4.L04Bairro

CREATE TABLE L04_BAIRRO (
  Nome         VARCHAR(100)  NOT NULL,
  CEP          NUMBER(8),

  NomeCidade   VARCHAR(100)  NOT NULL,
  SiglaEstado  CHAR(2)       NOT NULL,
  NroZona      NUMBER(6)     NOT NULL,

  CONSTRAINT PK_BAIRRO PRIMARY KEY (Nome,NomeCidade,SiglaEstado),
  CONSTRAINT UN_CEPBAIRRO UNIQUE (CEP),
  CONSTRAINT FK_CIDADEBAIRRO FOREIGN KEY (NomeCidade,SiglaEstado)
     REFERENCES L02_CIDADE(Nome,SiglaEstado) ON DELETE CASCADE,
  CONSTRAINT FK_ZONABAIRRO FOREIGN KEY (NroZona)
     REFERENCES L03_ZONA(NroZona)
);





--5.L05URNA
-- uma dada urna pode estar vinculada a uma zona, a uma sessão, ou a nenhuma destas entidades, só não pode estar vinculado às duas ao mesmo tempo; em caso de falha de uma urna em uma sessão, ela passará a usar uma urna reserva de sua respectiva zona, situação quando seu vínculo será alterado;

CREATE TABLE L05_URNA (
  NSerial  NUMBER(9)  NOT NULL,
  Estado   VARCHAR(10),

  NroZona  NUMBER(6),

  CONSTRAINT PK_URNA PRIMARY KEY (NSerial),
  CONSTRAINT FK_ZONAURNA FOREIGN KEY (NroZona)
     REFERENCES L03_ZONA(NroZona),
  CONSTRAINT CK_ESTADO CHECK(Estado IN ('funcional','manutencao'))
);

--6.L06Sessao
CREATE TABLE L06_SESSAO (
  NroSessao     NUMBER(5)  NOT NULL,

  NroZona       NUMBER(6),
  NSerial       NUMBER(9) NOT NULL,

  CONSTRAINT PK_SESSAO PRIMARY KEY (NroSessao,NroZona),
  CONSTRAINT FK_ZONASESSAO FOREIGN KEY (NroZona)
     REFERENCES L03_ZONA(NroZona) ON DELETE CASCADE,
  CONSTRAINT FK_URNASESSAO FOREIGN KEY (NSerial)
     REFERENCES L05_URNA(NSerial)
);

--7.L07PLEITO
CREATE TABLE L07_PLEITO (
  CodPleito NUMBER(6) NOT NULL,

  Ano                NUMBER(4)  NOT NULL,
  NomeCidade   VARCHAR(100)  NOT NULL,
  SiglaEstado  CHAR(2)       NOT NULL,

  TotalDeCandidatos  NUMBER(9)  NOT NULL,

  CONSTRAINT PK_PLEITO PRIMARY KEY (CodPleito),
  CONSTRAINT UN_PLEITO UNIQUE (Ano,NomeCidade,SiglaEstado),
  CONSTRAINT FK_CIDADEPLEITO FOREIGN KEY (NomeCidade,SiglaEstado)
     REFERENCES L02_CIDADE(Nome,SiglaEstado) ON DELETE CASCADE,
  CONSTRAINT CK_ANOPLEITO CHECK (Ano BETWEEN 1985 AND 2100)
);

--8.L08Partido
CREATE TABLE L08_PARTIDO (
  Sigla  CHAR(5) NOT NULL,
  Nome   VARCHAR(100) NOT NULL,

  CONSTRAINT PK_PARTIDO PRIMARY KEY (Sigla),
  CONSTRAINT UN_NOMEPARTIDO UNIQUE (Nome)
);

--9.L09Candidato

CREATE TABLE L09_CANDIDATO (
  NroCand   NUMBER(9)  NOT NULL,
  Tipo  CHAR(8)    NOT NULL,

  CPF      NUMBER(11),
  Nome     VARCHAR(100) NOT NULL,
  Idade    NUMBER(3),
  Apelido  VARCHAR(100),

  SiglaPartido  CHAR(5),

  CONSTRAINT PK_CANDIDATO PRIMARY KEY (NroCand),
  CONSTRAINT UN_CPF UNIQUE (CPF),
  CONSTRAINT FK_PARTIDOCANDIDATO FOREIGN KEY (SiglaPartido)
     REFERENCES L08_PARTIDO(Sigla),
  CONSTRAINT CK_CANDIDATO CHECK (
     Tipo = 'politico' AND SiglaPartido IS NOT NULL AND CPF IS NOT NULL
     OR
     Tipo = 'especial' AND SiglaPartido IS NULL AND CPF IS NULL AND Idade IS NULL AND Apelido IS NULL)
);

--10.L10Cargo
-- a esfera federal não possui nem estado nem cidade, a estadual possui obrigatoriamente apenas estado, e a municipal possui obrigatoriamente estado e cidade;

CREATE TABLE L10_CARGO (
  CodCargo        NUMBER(9)     NOT NULL,

  PossuiVice      NUMBER(1)     NOT NULL,
  AnoBase         NUMBER(4)     NOT NULL,
  AnosMandato     NUMBER(1)     DEFAULT 4 NOT NULL,
  NomeDescritivo  VARCHAR(100)  NOT NULL,
  NroDeCadeiras     NUMBER(3)     NOT NULL,

  Esfera          VARCHAR(9)    NOT NULL,
  NomeCidade      VARCHAR(100),
  SiglaEstado     CHAR(2),

  CONSTRAINT PK_CARGO PRIMARY KEY (CodCargo),
  CONSTRAINT UN_NOMECARGO UNIQUE (NomeDescritivo, NomeCidade, SiglaEstado),
  CONSTRAINT CK_CADEIRASCARGO CHECK (NroDeCadeiras > 0),
  CONSTRAINT CK_ANOSMANDATOCARGO CHECK (AnosMandato > 0),
  CONSTRAINT CK_ANOBASECARGO CHECK (AnoBase BETWEEN 1985 AND 2100),
  CONSTRAINT CK_POSSUI_VICE CHECK (PossuiVice IN (0,1)),
  CONSTRAINT CK_ESFERACARGO CHECK (Esfera IN ('federal','estadual','municipal')),
  CONSTRAINT CK_ATRIBUTOSESFERACARGO CHECK (
     (Esfera = 'federal'
        AND NomeCidade  IS NULL
        AND SiglaEstado IS NULL)
     OR
     (Esfera = 'estadual'
        AND NomeCidade  IS NULL
        AND SiglaEstado IS NOT NULL)
     OR
     (Esfera = 'municipal'
        AND NomeCidade  IS NOT NULL
        AND SiglaEstado IS NOT NULL)
  ),
  CONSTRAINT FK_ESTADOCARGO FOREIGN KEY (SiglaEstado)
     REFERENCES L01_ESTADO(Sigla),
  CONSTRAINT FK_CIDADECARGO FOREIGN KEY (NomeCidade,SiglaEstado)
     REFERENCES L02_CIDADE(Nome,SiglaEstado)
);

--11.L11Candidatura
-- h� dois candidatos especiais - branco e nulo que se candidatam a todos os cargos, em todos os anos de eleicoes;
-- um candidato pode concorrer a um unico cargo por ano;
-- os cargos que possuem vice precisam ter um vice-candidato vinculado a� candidatura; um candidato nao pode ser titular e vice no mesmo ano, e nao pode ser vice de mais do que uma candidatura no mesmo ano;

CREATE TABLE L11_CANDIDATURA (
  Reg           NUMBER(3)  NOT NULL,

  CodCargo      NUMBER(9)  NOT NULL,
  Ano           NUMBER(4)  NOT NULL,
  NroCand  NUMBER(11) NOT NULL,

  NroVice       NUMBER(11),

  CONSTRAINT PK_REGCANDIDATURA PRIMARY KEY (Reg),
  CONSTRAINT UN_CANDIDATURA UNIQUE (Ano, NroCand, CodCargo),
  CONSTRAINT FK_CANDIDATOCANDIDATURA FOREIGN KEY (NroCand)
     REFERENCES L09_CANDIDATO(NroCand),
  CONSTRAINT FK_VICECANDIDATO FOREIGN KEY (NroVice)
     REFERENCES L09_CANDIDATO(NroCand),
  CONSTRAINT FK_CARGOCANDIDATURA FOREIGN KEY (CodCargo)
     REFERENCES L10_CARGO(CodCargo),
  CONSTRAINT CK_ANOCANDIDATURA CHECK (Ano BETWEEN 1985 AND 2100)
);

--12.L12Pesquisa

CREATE TABLE L12_PESQUISA (
  RegPesquisa    NUMBER(9)     NOT NULL,
  PeriodoInicio  DATE          NOT NULL,
  PeriodoFim     DATE          NOT NULL,
  OrgaoPesquisa  VARCHAR(100) DEFAULT 'IBOPE',

  CONSTRAINT PK_PESQUISA PRIMARY KEY (RegPesquisa),
  CONSTRAINT CK_PERIODOPESQUISA CHECK (PeriodoFim > PeriodoInicio)
);

--13.L13PleitoCandidatura

CREATE TABLE L13_PLEITOCANDIDATURA (
  CodPleito NUMBER(6) NOT NULL,

  RegCand   NUMBER(3)  NOT NULL,

  CONSTRAINT PK_PLEITOCANDIDATURA PRIMARY KEY(CodPleito, RegCand),
  CONSTRAINT FK_CANDIDATURAPLEITO FOREIGN KEY(RegCand) REFERENCES L11_CANDIDATURA(Reg),
  CONSTRAINT FK_PLEITOCANDIDATURA FOREIGN KEY(CodPleito) REFERENCES L07_PLEITO(CodPleito)
);

--14.L14ComputaVotos

CREATE TABLE L14_COMPUTAVOTOS (
  NroSessao NUMBER(5)     NOT NULL,
  NroZona   NUMBER(6)     NOT NULL,
  CodPleito NUMBER(6) NOT NULL,
  RegCand   NUMBER(3)  NOT NULL,

  Total     NUMBER(9)     DEFAULT 0  NOT NULL,

  CONSTRAINT PK_COMPUTAVOTOS PRIMARY KEY(NroSessao,NroZona,CodPleito,RegCand),
  CONSTRAINT FK_SESSAOCANDIDATURA FOREIGN KEY (NroSessao,NroZona)
     REFERENCES L06_SESSAO(NroSessao,NroZona),
  CONSTRAINT FK_VOTOSPLEITOCANDIDATURA FOREIGN KEY (CodPleito)
     REFERENCES L07_PLEITO(CodPleito),
  CONSTRAINT FK_CANDIDATURASESSAO FOREIGN KEY (RegCand)
     REFERENCES L11_CANDIDATURA(Reg)
);

--15.L15ComputaIntencaoVotos

CREATE TABLE L15_COMPUTAINTENCAOVOTOS (
  RegPesquisa  NUMBER(9)  NOT NULL,
  RegCandid    NUMBER(3)  NOT NULL,
  
  Total     NUMBER(9)     DEFAULT 0  NOT NULL,  
  
  CONSTRAINT PK_COMPINTENC PRIMARY KEY(RegPesquisa,RegCandid),
  CONSTRAINT FK_PESQUISACANDIDATURA FOREIGN KEY (RegPesquisa)
     REFERENCES L12_PESQUISA(RegPesquisa),
  CONSTRAINT FK_CANDIDATURAPESQUISA FOREIGN KEY (RegCandid)
     REFERENCES L11_CANDIDATURA(Reg)
);

CREATE SYNONYM L15 FOR L15_COMPUTAINTENCAOVOTOS;
CREATE SYNONYM L14 FOR L14_COMPUTAVOTOS;
CREATE SYNONYM L13 FOR L13_PLEITOCANDIDATURA;
CREATE SYNONYM L12 FOR L12_PESQUISA;
CREATE SYNONYM L11 FOR L11_CANDIDATURA;
CREATE SYNONYM L10 FOR L10_CARGO; 
CREATE SYNONYM L09 FOR L09_CANDIDATO;
CREATE SYNONYM L08 FOR L08_PARTIDO;
CREATE SYNONYM L07 FOR L07_PLEITO;
CREATE SYNONYM L06 FOR L06_SESSAO;
CREATE SYNONYM L05 FOR L05_URNA;
CREATE SYNONYM L04 FOR L04_BAIRRO;
CREATE SYNONYM L03 FOR L03_ZONA;
CREATE SYNONYM L02 FOR L02_CIDADE;
CREATE SYNONYM L01 FOR L01_ESTADO;

CREATE SYNONYM COMPUTAINTENCAOVOTOS FOR L15_COMPUTAINTENCAOVOTOS;
CREATE SYNONYM COMPUTAVOTOS FOR L14_COMPUTAVOTOS;
CREATE SYNONYM PLEITOCANDIDATURA FOR L13_PLEITOCANDIDATURA;
CREATE SYNONYM PESQUISA FOR L12_PESQUISA;
CREATE SYNONYM CANDIDATURA FOR L11_CANDIDATURA;
CREATE SYNONYM CARGO FOR L10_CARGO; 
CREATE SYNONYM CANDIDATO FOR L09_CANDIDATO;
CREATE SYNONYM PARTIDO FOR L08_PARTIDO;
CREATE SYNONYM PLEITO FOR L07_PLEITO;
CREATE SYNONYM SESSAO FOR L06_SESSAO;
CREATE SYNONYM URNA FOR L05_URNA;
CREATE SYNONYM BAIRRO FOR L04_BAIRRO;
CREATE SYNONYM ZONA FOR L03_ZONA;
CREATE SYNONYM CIDADE FOR L02_CIDADE;
CREATE SYNONYM ESTADO FOR L01_ESTADO;