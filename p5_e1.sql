create or replace procedure "SP_AUDITORIA_CONTAS"
is
v_total number;
v_numero_sorteado number;
v_count :=0  number;
begin
	select count(1) into v_total from candidatura inner join  candidato  on candidatura.nrocand = candidato.nrocand  where
	candidato.tipo = 'politico'  and candidatura.ano < to_number(to_char(sysdate, 'YYYY'));

	SELECT DBMS_RANDOM.VALUE(1,v_total) INTO v_numero_sorteado FROM DUAL;

	for c_candidatos in (select candidato.* from candidatura inner join  candidato  on candidatura.nrocand = candidato.nrocand  where
	candidato.tipo = 'politico'  and candidatura.ano < to_number(to_char(sysdate, 'YYYY')) order by candidato.cpf)
	LOOP
		v_count = v_count + 1;
	END LOOP;

end;
/   
