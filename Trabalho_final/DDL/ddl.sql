/*==============================================================*/
/* Table: CARTAO                                                */
/*==============================================================*/
	CREATE TABLE CARTAO
		(
			COD_CARTAO       NUMBER NOT NULL ,
			CPF_JOGADOR     NUMBER NOT NULL,
			COD_EQUIPE      NUMBER NOT NULL,
			DESCRICAOCARTAO VARCHAR2(10) NOT NULL ,
			CHECK (COD_CARTAO = 1
		OR COD_CARTAO      = 2)
		);
ALTER TABLE CARTAO ADD PRIMARY KEY (COD_CARTAO);
/*==============================================================*/
/* Table: CIDADE                                                */
/*==============================================================*/
	CREATE TABLE CIDADE
		(
			COD_CIDADE   NUMBER NOT NULL ,
			COD_UF       NUMBER NOT NULL ,
			NOME_CIDADE VARCHAR2(20) NOT NULL
		);
ALTER TABLE CIDADE ADD PRIMARY KEY (COD_CIDADE);
/*==============================================================*/
/* Table: EQUIPE                                                */
/*==============================================================*/
	CREATE TABLE EQUIPE
		(
			COD_EQUIPE  NUMBER NOT NULL ,
			NOME_EQUIPE VARCHAR2(20) NOT NULL
		);
ALTER TABLE EQUIPE ADD PRIMARY KEY (COD_EQUIPE);
/*==============================================================*/
/* Table: EQUIPE_JOGO                                           */
/*==============================================================*/
	CREATE TABLE EQUIPE_JOGO
		(
			COD_JOGO         NUMBER NOT NULL,
			COD_EQUIPE      NUMBER NOT NULL,
			COD_EQUIPE_JOGO NUMBER NOT NULL ,
			COD_TIPO_EQUIPE NUMBER NOT NULL
		);
ALTER TABLE EQUIPE_JOGO ADD PRIMARY KEY (COD_EQUIPE_JOGO);
/*==============================================================*/
/* Table: ESTADIO                                               */
/*==============================================================*/
	CREATE TABLE ESTADIO
		(
			COD_ESTADIO   NUMBER NOT NULL ,
			COD_CIDADE    NUMBER NOT NULL,
			NOME_ESTADIO VARCHAR2(10) NOT NULL ,
			CAPACIDADE   NUMBER NOT NULL
		);
ALTER TABLE ESTADIO ADD PRIMARY KEY (COD_ESTADIO);
/*==============================================================*/
/* Table: GOL                                                   */
/*==============================================================*/
	CREATE TABLE GOL
		(
			COD_GOL         NUMBER NOT NULL ,
			CPF_JOGADOR     NUMBER NOT NULL,
			COD_EQUIPE_JOGO NUMBER NOT NULL,
			COD_TIPO_GOL    NUMBER NOT NULL,
			DESCRICAO_GOL   VARCHAR2(30) NOT NULL
		);
ALTER TABLE GOL ADD PRIMARY KEY (COD_GOL);
/*==============================================================*/
/* Table: JOGADOR                                               */
/*==============================================================*/
	CREATE TABLE JOGADOR
		(
			CPF_JOGADOR  NUMBER NOT NULL,
			COD_EQUIPE   NUMBER NOT NULL,
			NOME_JOGADOR VARCHAR2(30) NOT NULL
		);
ALTER TABLE JOGADOR ADD PRIMARY KEY (CPF_JOGADOR);
/*==============================================================*/
/* Table: JOGO                                                  */
/*==============================================================*/
	CREATE TABLE JOGO
		(
			COD_JOGO      NUMBER NOT NULL ,
			NUMERO_TURNO NUMBER NOT NULL,
			COD_ESTADIO   NUMBER NOT NULL,
			DATA         DATE NOT NULL ,
			RESULTADO    NUMBER NOT NULL
		);
ALTER TABLE JOGO ADD PRIMARY KEY (COD_JOGO);
/*==============================================================*/
/* Table: TIPO_EQUIPE                                           */
/*==============================================================*/
	CREATE TABLE TIPO_EQUIPE
		(
			COD_TIPO_EQUIPE       NUMBER NOT NULL,
			DESCRICAO_TIPO_EQUIPE VARCHAR2(30) NOT NULL,
			CHECK (COD_TIPO_EQUIPE = 1
		OR COD_TIPO_EQUIPE      = 2)
		);
ALTER TABLE TIPO_EQUIPE ADD PRIMARY KEY (COD_TIPO_EQUIPE);
/*==============================================================*/
/* Table: TIPO_GOL                                              */
/*==============================================================*/
	CREATE TABLE TIPO_GOL
		(
			COD_TIPO_GOL       NUMBER NOT NULL,
			DESCRICAO_TIPO_GOL VARCHAR2(30) ,
			CHECK (COD_TIPO_GOL = 1
		OR COD_TIPO_GOL      = 2)
		);
ALTER TABLE TIPO_GOL ADD PRIMARY KEY (COD_TIPO_GOL);
/*==============================================================*/
/* Table: TURNO                                                 */
/*==============================================================*/
	CREATE TABLE TURNO
		(
			NUMERO_TURNO    NUMBER NOT NULL ,
			DESCRICAO_TURNO VARCHAR2(30) NOT NULL ,
			CHECK (NUMERO_TURNO = 1
		OR NUMERO_TURNO      = 2)
		);
ALTER TABLE TURNO ADD PRIMARY KEY (NUMERO_TURNO);
/*==============================================================*/
/* Table: UF                                                    */
/*==============================================================*/
	CREATE TABLE UF
		(
			COD_UF   NUMBER NOT NULL ,
			SIGLAUF VARCHAR2(20) NOT NULL
		);
ALTER TABLE UF ADD PRIMARY KEY (COD_UF);
ALTER TABLE CARTAO ADD CONSTRAINT FK_JOGADOR_CARTAO FOREIGN KEY (CPF_JOGADOR) REFERENCES JOGADOR (CPF_JOGADOR) ON
	DELETE CASCADE ;
--alter table CARTAO add constraint FK_TIME_CARTAO foreign key (COD_EQUIPE)
--      references EQUIPE (COD_EQUIPE) on delete cascade ;
ALTER TABLE CIDADE ADD CONSTRAINT FK_UF_CIDADE FOREIGN KEY (COD_UF) REFERENCES UF (COD_UF) ON
	DELETE CASCADE ;
ALTER TABLE EQUIPE_JOGO ADD CONSTRAINT FK_EQUIPE_EQUIPE_JOGO FOREIGN KEY (COD_EQUIPE) REFERENCES EQUIPE (COD_EQUIPE) ON
	DELETE CASCADE ;
ALTER TABLE EQUIPE_JOGO ADD CONSTRAINT FK_JOGO_TIME_JOGO FOREIGN KEY (COD_JOGO) REFERENCES JOGO (COD_JOGO) ON
	DELETE CASCADE ;
ALTER TABLE EQUIPE_JOGO ADD CONSTRAINT FK_TIPO_TIME_TIME_JOGO FOREIGN KEY (COD_TIPO_EQUIPE) REFERENCES TIPO_EQUIPE (COD_TIPO_EQUIPE) ON
	DELETE CASCADE ;
ALTER TABLE ESTADIO ADD CONSTRAINT FK_CIDADE_ESTADIO FOREIGN KEY (COD_CIDADE) REFERENCES CIDADE (COD_CIDADE) ON
	DELETE CASCADE ;
ALTER TABLE GOL ADD CONSTRAINT FK_FK_TIPO_GOL_GOL FOREIGN KEY (COD_TIPO_GOL) REFERENCES TIPO_GOL (COD_TIPO_GOL) ON
	DELETE CASCADE ;
ALTER TABLE GOL ADD CONSTRAINT FK_JOGADOR_GOL FOREIGN KEY (CPF_JOGADOR) REFERENCES JOGADOR (CPF_JOGADOR) ON
	DELETE CASCADE ;
ALTER TABLE GOL ADD CONSTRAINT FK_TIME_JOGO_GOL FOREIGN KEY (COD_EQUIPE_JOGO) REFERENCES EQUIPE_JOGO (COD_EQUIPE_JOGO) ON
	DELETE CASCADE ;
ALTER TABLE JOGADOR ADD CONSTRAINT FK_EQUIPE_JOGADOR FOREIGN KEY (COD_EQUIPE) REFERENCES EQUIPE (COD_EQUIPE) ON
	DELETE CASCADE ;
ALTER TABLE JOGO ADD CONSTRAINT FK_ESTADIO_JOGO FOREIGN KEY (COD_ESTADIO) REFERENCES ESTADIO (COD_ESTADIO) ON
	DELETE CASCADE ;
ALTER TABLE JOGO ADD CONSTRAINT FK_TURNO_JOGO FOREIGN KEY (NUMERO_TURNO) REFERENCES TURNO (NUMERO_TURNO) ON
	DELETE CASCADE ;
