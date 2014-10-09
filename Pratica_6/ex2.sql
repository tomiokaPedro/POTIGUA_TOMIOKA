/* 
--Criando sequence para urna 
CREATE SEQUENCE SQ_NSERIAL START WITH 37 NOCACHE ORDER ; 
CREATE TRIGGER BI_NSERIAL BEFORE 
INSERT ON URNA FOR EACH ROW WHEN (NEW.NSERIAL IS NULL) BEGIN :NEW.NSERIAL := SQ_NSERIAL.NEXTVAL;
END; 
/ 
*/ 



CREATE OR replace PROCEDURE Substitui_urna(p_urna_nserial NUMBER) 
AS 
  v_nrozona NUMBER; 
  v_nserial NUMBER; 
  v_flag    NUMBER DEFAULT 0; 
  e_nao_possui_urna_reserva EXCEPTION; 
BEGIN 
    SELECT nrozona 
    INTO   v_nrozona 
    FROM   urna 
    WHERE  nserial = p_urna_nserial; 

    SELECT nrodeurnasreservas 
    INTO   v_flag 
    FROM   zona 
    WHERE  v_nrozona = nrozona; 

    -- checa se tem urna reserva 
    IF v_flag = 0 THEN 
      RAISE e_nao_possui_urna_reserva; 
    END IF; 

    UPDATE zona 
    SET    nrodeurnasreservas = nrodeurnasreservas - 1 
    WHERE  nrozona = v_nrozona; 

    INSERT INTO l05_urna 
                (estado, 
                 nrozona) 
    VALUES      ( 'funcional', 
                 v_nrozona ); 

    UPDATE urna 
    SET    estado = 'manutencao' 
    WHERE  nserial = v_nserial; 

    dbms_output.Put_line('Urna trocada com sucesso'); 
EXCEPTION 
  WHEN e_nao_possui_urna_reserva THEN 
             dbms_output.Put_line('Nao possui urna reserva nessa sessão'); WHEN 
OTHERS THEN 
             dbms_output.Put_line('Erro ' 
                                  || SQLERRM); 
END; 