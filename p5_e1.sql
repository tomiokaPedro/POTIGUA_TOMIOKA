create or replace procedure "SP_AUDITORIA_CONTAS"
is
v_total number;
v_numero_sorteado number;
v_count   number;
c_ano_atual number;
begin
    select to_number(to_char(sysdate, 'YYYY')) into c_ano_atual from dual;

    select count(1) into v_total from candidatura inner join  candidato  on candidatura.nrocand = candidato.nrocand  where
    candidato.tipo = 'politico'  and candidatura.ano < c_ano_atual;

    SELECT DBMS_RANDOM.VALUE(1,v_total) INTO v_numero_sorteado FROM DUAL;

    for c_candidatos in (select * from candidato where tipo = 'politico'  order by cpf)
    LOOP
        IF v_count = v_total
        THEN
            exit;
        END IF;



        v_count := v_count + 1;
    END LOOP;

end;
/   
​
