--Criando as tabelas e adicionando as fk

create table jogadores(
	id_jogador SERIAL,
	nome varchar(30),
	id_time int not null,
	idade int,
	primary key (id_jogador)
);

ALTER TABLE jogadores alter column id_time set NOT NULL
ALTER TABLE jogadores
ADD CONSTRAINT fk_id_time FOREIGN KEY (id_time) REFERENCES times(id_time);



create table times(
	id_time serial,
	nome varchar(30),
	id_cidade int,
	primary key (id_time)
);

ALTER TABLE times
ADD CONSTRAINT fk_id_cidade FOREIGN KEY (id_cidade) REFERENCES cidades(id_cidade);

-- A príncipio pensei em um ENUM, porém percebi que criar a coluna fk_id_time_vencedor seria mais eficaz.
create type final as enum('C', 'V', 'E');
create table jogos(
	id_jogo SERIAL,
	id_time_casa int not null,
	id_time_visitante int not null,
	data timestamp,
	gols_time_casa int,
	gols_time_fora int,
	resultado final,
	primary key (id_jogo)
);



COMMENT ON column jogos.resultado is 'C = Vitória time da casa, V = Vitória do visitante, E = Empate';
ALTER TABLE jogos
ADD CONSTRAINT fk_id_time_casa FOREIGN KEY (id_time_casa) REFERENCES times(id_time);
ALTER TABLE jogos
ADD CONSTRAINT fk_id_time_visitante FOREIGN KEY (id_time_visitante) REFERENCES times(id_time);
alter table jogos add column id_time_vencedor
ALTER TABLE jogos
ADD CONSTRAINT fk_id_time_vencedor FOREIGN KEY (id_time_vencedor) REFERENCES times(id_time);



create table cidades(
	id_cidade serial,
	nome varchar(50),
	id_estado int not null,
	primary key(id_cidade)
);

ALTER TABLE cidades
ADD CONSTRAINT fk_id_estado FOREIGN KEY (id_estado) REFERENCES estados(id_estado);



create table estados(
	id_estado serial,
	nome varchar(30),
	uf char(2),
	primary key(id_estado)
)


create table classificacao(
id_time int,
gols_pro int,
gols_contra int,
pontos int
)
ALTER TABLE classificacao
ADD CONSTRAINT fk_id_time FOREIGN KEY (id_time) REFERENCES times(id_time);


-- Inserindo dados na tabela estado
INSERT INTO estados (nome, uf) 
VALUES
('Acre', 'AC'),
('Alagoas', 'AL'),
('Amazonas', 'AM'),
('Amapá', 'AP'),
('Bahia', 'BA'),
('Ceará', 'CE'),
('Distrito Federal', 'DF'),
('Espírito Santo', 'ES'),
('Goiás', 'GO'),
('Maranhão', 'MA'),
('Minas Gerais', 'MG'),
('Mato Grosso do Sul', 'MS'),
('Mato Grosso', 'MT'),
('Pará', 'PA'),
('Paraíba', 'PB'),
('Pernambuco', 'PE'),
('Piauí', 'PI'),
('Paraná', 'PR'),
('Rio de Janeiro', 'RJ'),
('Rio Grande do Norte', 'RN'),
('Rondônia', 'RO'),
('Roraima', 'RR'),
('Rio Grande do Sul', 'RS'),
('Santa Catarina', 'SC'),
('Sergipe', 'SE'),
('São Paulo', 'SP'),
('Tocantins', 'TO')


-- Inserindo dados na tabela cidades

INSERT INTO cidades (nome, id_estado) 
VALUES
('Rio Branco', 1),
('Maceió', 2),
('Mansus', 3),
('Macapá', 4),
('Salvador', 5),
('Fortaleza', 6),
('Brasilia', 7),
('Vitória', 8),
('Goiânia', 9),
('São Luiz', 10),
('Belo Horizonte', 11),
('Campo Grande', 12),
('Cuiabá', 13),
('Belém', 14),
('João Pessoa', 15),
('Recife', 16),
('Teresina', 17),
('Curitiba', 18),
('Rio de Janeiro', 19),
('Natal', 20),
('Porto Velho', 21),
('Boa Vista', 22),
('Porto Alegre', 23),
('Florianópolis', 24),
('Aracaju', 25),
('São Paulo', 26),
('Palmas', 27)

-- Inserindo dados na tabela times


insert INTO times (nome, id_cidade) 
VALUES
('Asa de Arapiraca', 2),
('Tuna Luso Brasileira', 14),
('Votuporanguense', 26) ,
('Apucarana', 18)


-- Inserindo dados na tabela jogadores


INSERT INTO JOGADORES (nome,id_time,idade)
VALUES
('Flávio Caça Rato', 1, 29),
('Baraka', 1, 33),
('Alejo', 1, 40),
('André Castolo', 2, 35),
('Seu Jura', 2, 44),
('Azul', 2, 38),
('Joaquim Texeira', 3, 50),
('Brad Pitt', 3, 49),
('Alemão', 3, 16),
('Pablo', 4, 31),
('Igor Gomes', 4, 23),
('Paraíba', 4, 55)

-- Inserindo dados na tabela jogos


INSERT INTO jogos (id_time_casa, id_time_visitante, data, gols_time_casa, gols_time_fora, resultado, id_time_vencedor)
VALUES
(1,2, '2023-01-10 22:00:00.00', 15,4,'C', 1),
(3,4, '2023-01-10 22:00:00.00', 7,6, 'C', 3),
(1,3, '2023-01-12 22:00:00.00', 18,10, 'C',1),
(2,4, '2023-01-12 22:00:00.00', 6,6, 'E',NULL),
(1,4, '2023-01-14 22:00:00.00', 8,1 ,'C',1),
(2,3, '2023-01-14 22:00:00.00', 23,9, 'C',2),
(4,1, '2023-01-16 22:00:00.00', 13,22, 'V',1),
(3,2, '2023-01-16 22:00:00.00', 7,7, 'E',NULL),
(4,2, '2023-01-18 22:00:00.00', 4,9, 'V',2),
(3,1, '2023-01-18 22:00:00.00', 10,14 ,'V',1),
(4,3, '2023-01-20 22:00:00.00', 5,19 ,'V',3),
(2,1, '2023-01-20 22:00:00.00', 7,17, 'V',1)

-- Inserindo dados na tabela classificação


insert into classificacao (id_time, gols_pro, gols_contra, pontos)
values
(1,(select SUM(gols_time_casa) from jogos where id_time_casa = 1) + (select SUM(gols_time_fora) from jogos where id_time_visitante = 1),
(select SUM(gols_time_casa) from jogos where id_time_visitante = 1) + (select SUM(gols_time_fora) from jogos where id_time_casa = 1), 18)

(2,(select SUM(gols_time_casa) from jogos where id_time_casa = 2) + (select SUM(gols_time_fora) from jogos where id_time_visitante = 2),
(select SUM(gols_time_casa) from jogos where id_time_visitante = 2) + (select SUM(gols_time_fora) from jogos where id_time_casa = 2), 8),

(3,(select SUM(gols_time_casa) from jogos where id_time_casa = 3) + (select SUM(gols_time_fora) from jogos where id_time_visitante = 3),
(select SUM(gols_time_casa) from jogos where id_time_visitante =3 ) + (select SUM(gols_time_fora) from jogos where id_time_casa = 3), 7),

(4,(select SUM(gols_time_casa) from jogos where id_time_casa = 4) + (select SUM(gols_time_fora) from jogos where id_time_visitante = 4),
(select SUM(gols_time_casa) from jogos where id_time_visitante = 4) + (select SUM(gols_time_fora) from jogos where id_time_casa = 4), 1)


--PERGUNTAS


-- Quantos jogos cada jogador jogou?
select jg.nome, t.nome, count(jgs.id_time_casa) + count(jgs.id_time_visitante) as total_de_jogos
from jogos jgs 
join times t
on jgs.id_time_casa  = t.id_time
join times t2
on t2.id_time = jgs.id_time_visitante
join jogadores jg
on t.id_time = jg.id_time
group by 1,2

--Qual time mais venceu partidas?
select  t.nome, count(id_time_vencedor) vitorias from jogos jgs
join times t on jgs.id_time_vencedor = t.id_time
group by 1
order by count(id_time_vencedor) desc
limit 1

--Qual time é o lanterna?
select t.nome, c.* from classificacao c
join times t on c.id_time = t.id_time
order by pontos limit 1

-- Qual time teve a melhor defesa?
select t.nome, c.* from classificacao c
join times t on c.id_time = t.id_time
order by gols_contra limit 1 

--Qual dado você achou relevante ? O que você descobriu?
--Adicionar uma tabela de classificação facilta a resposta para diversas perguntas


