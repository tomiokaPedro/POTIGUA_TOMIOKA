CREATE SEQUENCE cod_gol_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 /

 
 CREATE SEQUENCE cod_cartao_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 /

 
 CREATE SEQUENCE cod_jogador_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 /

 
 CREATE SEQUENCE cod_equipe_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 /

 
 CREATE SEQUENCE cod_jogo_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 /

 
 CREATE SEQUENCE numero_turno_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 /

 
 CREATE SEQUENCE cod_estadio_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 /

 
 CREATE SEQUENCE cod_cidade_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 /

 
 CREATE SEQUENCE cod_estado_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 /

 
 CREATE OR REPLACE TRIGGER gol_seq_trigger
BEFORE INSERT ON Gol
FOR EACH ROW
BEGIN
	IF :new.cod_gol IS NULL THEN
		SELECT cod_gol_seq.nextval INTO :new.cod_gol FROM DUAL;
	END IF;
END;
/

 CREATE OR REPLACE TRIGGER cartao_seq_trigger
BEFORE INSERT ON Cartao
FOR EACH ROW
BEGIN
	IF :new.cod_cartao IS NULL THEN
		SELECT cod_cartao_seq.nextval INTO :new.cod_cartao FROM DUAL;
	END IF;
END;
/

 CREATE OR REPLACE TRIGGER jogador_seq_trigger
BEFORE INSERT ON Jogador
FOR EACH ROW
BEGIN
	IF :new.cod_jogador IS NULL THEN
		SELECT cod_jogador_seq.nextval INTO :new.cod_jogador FROM DUAL;
	END IF;
END;
/

 CREATE OR REPLACE TRIGGER equipe_seq_trigger
BEFORE INSERT ON Equipe
FOR EACH ROW
BEGIN
	IF :new.cod_equipe IS NULL THEN
		SELECT cod_equipe_seq.nextval INTO :new.cod_equipe FROM DUAL;
	END IF;
END;
/

 CREATE OR REPLACE TRIGGER jogo_seq_trigger
BEFORE INSERT ON Jogo
FOR EACH ROW
BEGIN
	IF :new.cod_jogo IS NULL THEN
		SELECT cod_jogo_seq.nextval INTO :new.cod_jogo FROM DUAL;
	END IF;
END;
/

 CREATE OR REPLACE TRIGGER turno_seq_trigger
BEFORE INSERT ON Turno
FOR EACH ROW
BEGIN
	IF :new.numero_turno IS NULL THEN
		SELECT numero_turno_seq.nextval INTO :new.numero_turno FROM DUAL;
	END IF;
END;
/

 CREATE OR REPLACE TRIGGER estadio_seq_trigger
BEFORE INSERT ON Estadio
FOR EACH ROW
BEGIN
	IF :new.cod_estadio IS NULL THEN
		SELECT cod_estadio_seq.nextval INTO :new.cod_estadio FROM DUAL;
	END IF;
END;
/

 CREATE OR REPLACE TRIGGER cidade_seq_trigger
BEFORE INSERT ON Cidade
FOR EACH ROW
BEGIN
	IF :new.cod_cidade IS NULL THEN
		SELECT cod_cidade_seq.nextval INTO :new.cod_cidade FROM DUAL;
	END IF;
END;
/

 CREATE OR REPLACE TRIGGER estado_seq_trigger
BEFORE INSERT ON Estado
FOR EACH ROW
BEGIN
	IF :new.cod_estado IS NULL THEN
		SELECT cod_estado_seq.nextval INTO :new.cod_estado FROM DUAL;
	END IF;
END;
/