show schemas;
create database first_example;
use first_example;
show tables;

##CRIANDO TABELA
CREATE TABLE person(
	person_id smallint unsigned,
	fname varchar(20),
	lname varchar(20),
	gender enum('M','F'),
	birth_date DATE,
	street varchar(30),
	city varchar(20),
	state varchar(20),
	country varchar(20),
	postal_code varchar(20),
    constraint pk_person primary key (person_id)
);
##DESCRIÇÃO DA TABELA
desc person;
#CRIANDO TABELA
CREATE TABLE favorite_food(
	person_id smallint unsigned,
	food varchar(20),
    constraint pk_favorite_food primary key (person_id, food),
    constraint fk_favorite_food_person_id foreign key (person_id)
    references person(person_id)
);
##DESCRIÇÃO DA TABELA
desc favorite_food

--INSERINDO DADOS NA TABELA
INSERT INTO person values ('3', 'Marcelo', 'Rocha', 'M', '1985-10-25','rua A', 'Cidade Z', 'ZP','Brasil', '26584-89'),
('1', 'Marcio', 'Rocha', 'M', '1985-10-25','rua A', 'Cidade Z', 'ZP','Brasil', '26584-89'),
('2', 'Mauro', 'Rocha', 'M', '1985-10-25','rua A', 'Cidade Z', 'ZP','Brasil', '26584-89');

INSERT INTO favorite_food values ('0','Carne Assada');

/*DELETANDO DADOS DA TABELA*/
delete from person where person_id = '3'

select * from person
select * from favorite_food

select now() from person





