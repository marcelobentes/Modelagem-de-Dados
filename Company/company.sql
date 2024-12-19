create schema if not exists company;
use company;
create table employee(
	Fname varchar(15) not null,
	Minit char,
	Lname varchar(15) not null,
	Ssn char(9) not null,
	Bdate DATE,
	Address varchar(30),
	Sex char,
	Salary decimal (10,2),
    Super_Ssn char(9),
    Dno int not null,
    primary key(Ssn)
);


create table departament(
	Dname varchar(15) not null,
    Dnumber int not null,
    Mgr_ssn char(9),
    Mgr_start_date date,
    primary key(Dnumber),
    foreign key(Mgr_ssn) references employee(Ssn),
    unique (Dname)
);

create table dept_locations(
	Dnumber int not null,
    Dlocation varchar(15) not null,
    primary key (Dnumber, Dlocation),
    foreign key (Dnumber) references departament(Dnumber)
);

create table project(
	Pname varchar(15) not null,
    Pnumber int not null,
    Plocation varchar(15),
    Dnum int not null,
    primary key(Pnumber),
    foreign key(Dnum) references departament(Dnumber),
    unique(Pname)
);

create table works_on(
	Essn char(9) not null,
    Pno int not null,
    Hours decimal(3,1) not null,
    primary key(Essn, Pno),
    foreign key(Essn) references employee(Ssn),
    foreign key(Pno) references project(Pnumber)
);

create table dependent(
	Essn char(9) not null,
    DependentName varchar(15) not null,
    Sex char, -- F ou M
    Bdate date,
    Relationship varchar(8),
    primary key(Essn, DependentName),
    foreign key(Essn) references employee(Ssn)
);

-- ALTER TABLES;

alter table employee
	add constraint fk_employee
    foreign key(Super_ssn) references employee(Ssn)
    on delete set null
    on update cascade;

show tables;

-- inserção de dados no BD Company;

use company;
select * from employee;
select * from dependent;
select * from departament;
select * from dept_locations;
select * from project;
select * from works_on;

insert into employee values ('John', 'B', 'Smith', 123456789,'1965-01-09','731-Fondren-Houston-TX','M',3000,null,5);

insert into employee values ('Roud', 'G', 'Fraid', 523456789,'1965-01-09','731-Fondren-Houston-TX','M',3000,null,5),
	('Marie', 'M', 'Said', 223456789,'1965-01-09','731-Fondren-Houston-TX','M',3000,null,5),
    ('Wagfor', 'D', 'Void', 323456789,'1965-01-09','731-Fondren-Houston-TX','M',3000,null,5);
    
insert into dependent values (323456789,'Alice','F','1986-04-05','Daughter');

insert into departament values('Research',5, 323456789,'1988-05-22');

insert into dept_locations values(5,'Houston'); 

insert into project values('ProductX',5,'Bellaire',5);

insert into works_on values(223456789,5,40.0);

-- recuperando dados

select Ssn, Fname, Dname from employee e, departament d where (e.Ssn = d.Mgr_ssn);
select Fname, DependentName, Relationship from employee, dependent where Essn = Ssn;
select Pname, Essn, Fname, Hours
	from project, works_on,employee
		where Pnumber = Pno and Essn = Ssn;
        

-- JOIN Statement
desc employee;
desc works_on;
desc departament;
select * from departament;

select * from employee JOIN works_on ON Ssn = Essn;
select Fname, Lname, Address, Dname
	from(employee JOIN departament on Dno=Dnumber)
    where Dname = 'Research';
    
-- JOIN com mais de 3 tabelas
select concat(Fname, ' ',Lname) as Name, Dno, Pname, Pno, Plocation from employee
		inner join works_on on Ssn = Essn
        inner join project on Pno = Pnumber
        inner join departament on Dno = Dnumber
        order by Pnumber;
        
        
        