Begin


/*

Estado

*/


insert into estado(nome) values ('Amazonas');
insert into estado(nome) values ('Bahia');
insert into estado(nome) values ('Distrito Federal');
insert into estado(nome) values ('Goiás');
insert into estado(nome) values ('Maranhão');
insert into estado(nome) values ('Mato Grosso');
insert into estado(nome) values ('Minas Gerais');
insert into estado(nome) values ('Paraná');
insert into estado(nome) values ('Pernambuco');
insert into estado(nome) values ('Rio de Janeiro');
insert into estado(nome) values ('Rio Grande do Sul');
insert into estado(nome) values ('Santa Catarina');
insert into estado(nome) values ('São Paulo');

/*

Cidade

*/
BEGIN

insert into cidade(nome_cidade,cod_estado)  select 'Araraquara', cod_estado from estado where nome = 'São Paulo';
insert into cidade(nome_cidade,cod_estado)  select 'Barueri', cod_estado from estado where nome = 'São Paulo';
insert into cidade(nome_cidade,cod_estado)  select 'Belém', cod_estado from estado where nome = 'São Paulo';
insert into cidade(nome_cidade,cod_estado)  select 'Belo Horizonte', cod_estado from estado where nome = 'Minas Gerais';
insert into cidade(nome_cidade,cod_estado)  select 'Brasília', cod_estado from estado where nome = 'Distrito Federal';
insert into cidade(nome_cidade,cod_estado)  select 'Caxias do Sul', cod_estado from estado where nome = 'Rio Grande do Sul';
insert into cidade(nome_cidade,cod_estado)  select 'Chapecó', cod_estado from estado where nome = 'Santa Catarina';
insert into cidade(nome_cidade,cod_estado)  select 'Criciúma', cod_estado from estado where nome = 'Santa Catarina';
insert into cidade(nome_cidade,cod_estado)  select 'Cuiabá', cod_estado from estado where nome = 'Mato Grosso';
insert into cidade(nome_cidade,cod_estado)  select 'Curitiba', cod_estado from estado where nome = 'Paraná';
insert into cidade(nome_cidade,cod_estado)  select 'Feira de Santana', cod_estado from estado where nome = 'Bahia';
insert into cidade(nome_cidade,cod_estado)  select 'Florianópolis', cod_estado from estado where nome = 'Santa Catarina';
insert into cidade(nome_cidade,cod_estado)  select 'Goiânia', cod_estado from estado where nome = 'Goiás';
insert into cidade(nome_cidade,cod_estado)  select 'Ipatinga', cod_estado from estado where nome = 'Minas Gerais';
insert into cidade(nome_cidade,cod_estado)  select 'Itumbiara', cod_estado from estado where nome = 'Goiás';
insert into cidade(nome_cidade,cod_estado)  select 'Juiz de Fora', cod_estado from estado where nome = 'Minas Gerais';
insert into cidade(nome_cidade,cod_estado)  select 'Londrina', cod_estado from estado where nome = 'Paraná';
insert into cidade(nome_cidade,cod_estado)  select 'Macaé', cod_estado from estado where nome = 'Rio de Janeiro';
insert into cidade(nome_cidade,cod_estado)  select 'Manaus', cod_estado from estado where nome = 'Amazonas';
insert into cidade(nome_cidade,cod_estado)  select 'Maringá', cod_estado from estado where nome = 'Paraná';
insert into cidade(nome_cidade,cod_estado)  select 'Porto Alegre', cod_estado from estado where nome = 'Rio Grande do Sul';
insert into cidade(nome_cidade,cod_estado)  select 'Presidente Prudente', cod_estado from estado where nome = 'São Paulo';
insert into cidade(nome_cidade,cod_estado)  select 'Recife', cod_estado from estado where nome = 'Pernambuco';
insert into cidade(nome_cidade,cod_estado)  select 'Rio de Janeiro', cod_estado from estado where nome = 'Rio de Janeiro';
insert into cidade(nome_cidade,cod_estado)  select 'S. Lourenço da Mata', cod_estado from estado where nome = 'Pernambuco';
insert into cidade(nome_cidade,cod_estado)  select 'Salvador', cod_estado from estado where nome = 'Bahia';
insert into cidade(nome_cidade,cod_estado)  select 'Santos', cod_estado from estado where nome = 'São Paulo';
insert into cidade(nome_cidade,cod_estado)  select 'São Bernardo', cod_estado from estado where nome = 'São Paulo';
insert into cidade(nome_cidade,cod_estado)  select 'São Luis', cod_estado from estado where nome = 'Maranhão';
insert into cidade(nome_cidade,cod_estado)  select 'São Paulo', cod_estado from estado where nome = 'São Paulo';
insert into cidade(nome_cidade,cod_estado)  select 'Uberlândia', cod_estado from estado where nome = 'São Paulo';
insert into cidade(nome_cidade,cod_estado)  select 'Volta Redonda', cod_estado from estado where nome = 'Rio de Janeiro';

COMMIT;

EXCEPTION
WHEN OTHERS THEN
  BEGIN 
    dbms_output.put_line ('O Estado não foi encontrado');
    ROLLBACK;
    END;
END;

/*

Equipe

*/

insert into equipe(nome_equipe) values ('Atlético Mineiro');
insert into equipe(nome_equipe) values ('Atlético Paranaense');
insert into equipe(nome_equipe) values ('Bahia');
insert into equipe(nome_equipe) values ('Botafogo');
insert into equipe(nome_equipe) values ('Chapecoense');
insert into equipe(nome_equipe) values ('Corinthians');
insert into equipe(nome_equipe) values ('Coritiba');
insert into equipe(nome_equipe) values ('Criciúma');
insert into equipe(nome_equipe) values ('Cruzeiro');
insert into equipe(nome_equipe) values ('Figueirense');
insert into equipe(nome_equipe) values ('Flamengo');
insert into equipe(nome_equipe) values ('Fluminense');
insert into equipe(nome_equipe) values ('Goiás');
insert into equipe(nome_equipe) values ('Grêmio');
insert into equipe(nome_equipe) values ('Internacional');
insert into equipe(nome_equipe) values ('Palmeiras');
insert into equipe(nome_equipe) values ('Santos');
insert into equipe(nome_equipe) values ('São Paulo');
insert into equipe(nome_equipe) values ('Sport');
insert into equipe(nome_equipe) values ('Vitória');

	/*

Estádio

*/
BEGIN

insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, '1º de Maio', 10000 from cidade where nome_cidade = 'São Bernardo';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Alfredo Jaconi', 10000 from cidade where nome_cidade = 'Caxias do Sul';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Allianz Parque', 10000 from cidade where nome_cidade = 'São Paulo';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Arena Barueri', 10000 from cidade where nome_cidade = 'Barueri';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Arena Condá', 10000 from cidade where nome_cidade = 'Chapecó';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Arena Corinthians', 10000 from cidade where nome_cidade = 'São Paulo';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Arena da Amazônia', 10000 from cidade where nome_cidade = 'Manaus';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Arena da Baixada', 10000 from cidade where nome_cidade = 'Curitiba';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Arena do Grêmio', 10000 from cidade where nome_cidade = 'Porto Alegre';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Arena Pantanal', 10000 from cidade where nome_cidade = 'Cuiabá';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Arena Pernambuco', 10000 from cidade where nome_cidade = 'S. Lourenço da Mata';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Barradão', 10000 from cidade where nome_cidade = 'Salvador';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Beira Rio', 10000 from cidade where nome_cidade = 'Porto Alegre';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Canindé', 10000 from cidade where nome_cidade = 'São Paulo';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Castelão/MA', 10000 from cidade where nome_cidade = 'São Luis';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Centenário', 10000 from cidade where nome_cidade = 'Caxias do Sul';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Couto Pereira', 10000 from cidade where nome_cidade = 'Curitiba';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Durival Britto', 10000 from cidade where nome_cidade = 'Curitiba';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Estádio do Café', 10000 from cidade where nome_cidade = 'Londrina';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Fonte Luminosa', 10000 from cidade where nome_cidade = 'Araraquara';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Fonte Nova', 10000 from cidade where nome_cidade = 'Salvador';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Heriberto Hülse', 10000 from cidade where nome_cidade = 'Criciúma';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Ilha do Retiro', 10000 from cidade where nome_cidade = 'Recife';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Independência', 10000 from cidade where nome_cidade = 'Belo Horizonte';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'João Havelange', 10000 from cidade where nome_cidade = 'Uberlândia';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'João Lamego', 10000 from cidade where nome_cidade = 'Ipatinga';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Jóia da Princesa', 10000 from cidade where nome_cidade = 'Feira de Santana';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Juscelino Kubitschek', 10000 from cidade where nome_cidade = 'Itumbiara';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Mané Garrincha', 10000 from cidade where nome_cidade = 'Brasília';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Mangueirão', 10000 from cidade where nome_cidade = 'Belém';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Maracanã', 10000 from cidade where nome_cidade = 'Rio de Janeiro';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Mário Helênio', 10000 from cidade where nome_cidade = 'Juiz de Fora';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Mineirão', 10000 from cidade where nome_cidade = 'Belo Horizonte';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Moacyrzão', 10000 from cidade where nome_cidade = 'Macaé';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Morumbi', 10000 from cidade where nome_cidade = 'São Paulo';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Orlando Scarpelli', 10000 from cidade where nome_cidade = 'Florianópolis';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Pacaembu', 10000 from cidade where nome_cidade = 'São Paulo';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Paulo Constantino', 10000 from cidade where nome_cidade = 'Presidente Prudente';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Pituaçu', 10000 from cidade where nome_cidade = 'Salvador';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Raulino de Oliveira', 10000 from cidade where nome_cidade = 'Volta Redonda';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'São Januário', 10000 from cidade where nome_cidade = 'Rio de Janeiro';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Serra Dourada', 10000 from cidade where nome_cidade = 'Goiânia';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Vila Belmiro', 10000 from cidade where nome_cidade = 'Santos';
insert into estadio(cod_cidade, nome_estadio, capacidade) select cod_cidade, 'Willie Davids', 10000 from cidade where nome_cidade = 'Maringá';

COMMIT;

EXCEPTION
WHEN OTHERS THEN
  BEGIN 
    dbms_output.put_line ('COD_cidade não encontrado');
    ROLLBACK;
    END;
END;

/*

Turno

*/


insert into turno(descricao_turno) values ('turno');
insert into turno(descricao_turno) values ('returno');

EXCEPTION
WHEN OTHERS THEN
  BEGIN 
    dbms_output.put_line ('Erro Geral '|| SQLERRM);
ROLLBACK;
end;
