CREATE OR REPLACE PROCEDURE substitui_urna(
    p_urna_nserial NUMBER)
AS
  v_nro_zona NUMBER;
BEGIN
  SELECT nrozona INTO v_nro_zona FROM urna WHERE nserial = p_urna_nserial;
  UPDATE zona
  SET nrodeurnasreservas = nrodeurnasreservas-1
  WHERE nrozona          = v_nro_zona;
  SELECT nserial INT c_urna FROM urna WHERE estado = 'NAO FUNCIONAL';
  FOR EACH c_urna
  LOOP
    
  END LOOP;
END;