-- criação do banco de dados para o cenário de E-commerce
create database ecommerce;
use ecommerce;

-- criandos as tabelas;

-- tabelas clientes;
create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(255),
    DataNascimento date,
    constraint unique_cpf_client unique (CPF)   

);
desc clients;
alter table clients auto_increment =1;

-- tabelas produtos;
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(50),
    Classification_kids bool default false,
    Category enum('Eletronico','Vestimenta','Brinquedos','Alimentos') not null,
    Avaliation float default 0,
    Size varchar(10)

);


-- tabelas payments;
create table payments(
	idPayClient int,
    idPayment int auto_increment primary key,
    typePayment enum('Boleto', 'Cartão', 'Dois cartões'),
    limitAvailiable float,
	constraint fk_payments_client foreign key (idPayClient) references clients(idClient)
    
);
drop table payments;

-- tabelas pedidos;
create table orders(
	IdOrder int auto_increment primary key,
    IdOrderClient int,
    OrderStatus enum('Cancelado','Confirmado','Em processamento') default "Em processamento",
    OrderDescription varchar(255),
    SendValue float default 10,
    Idpayment int, 
    paymentCash bool default false,
    constraint fk_orders_client foreign key (IdOrderClient) references clients(idClient)
);
desc orders;

-- tabelas estoque;
create table productStorage(
	IdProdStorage int primary key,
    StorageLocation varchar(255),
    Quantity int default 0,
    constraint fk_productStorage foreign key (IdProdStorage) references product(idProduct)
);
drop table productStorage;

-- tabelas fornecedor;
create table supplier(
	Idsupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    Contact varchar(11) not null,
    constraint unique_supplier unique (CNPJ)
);

-- tabelas vendedor;
create table seller(
	IdSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbsName varchar (255),
    CNPJ char(15),
    CPF char(9),
    location varchar (255),
    Contact varchar(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);

-- tabelas produto/vendedor;
create table productSeller(
	IdPseller int,
    IdPproduct int,
    ProdQuantity int default 1,
    primary key (idPseller,IdPproduct),
    constraint fk_product_seller foreign key (IdPseller) references seller(IdSeller),
    constraint fk_product_product foreign key (IdPproduct) references product(idProduct)	
);
desc productSeller;

-- tabelas produto/pedido;
create table productOrder(
	IdPOproduct int,
    IdPOorder int,
    PoQuantity int default 1,
    PoStatus enum ('Disponivel', 'Sem estoque') default 'Disponivel',
    primary key (IdPOproduct, IdPOorder),
    constraint fk_productorder_product foreign key (IdPOproduct) references product(idProduct),
    constraint fk_productorder_order foreign key (IdPOorder) references orders(IdOrder)
);

-- tabelas estoque/local;
create table storageLocation(
	IdLproduct int,
    IdLstorage int,
    location varchar (255) not null,
    primary key(IdLproduct, IdLstorage),
    constraint fk_storage_location_product foreign key (IdLproduct) references product(idProduct),
	constraint fk_storage_location_storage foreign key (IdLstorage) references productStorage(IdProdStorage)
);
drop table storageLocation;
-- tabelas produto/estoque;
create table product_Supplier(
	IdPsSupplier int,
    IdPsProduct int,
    Quantity int not null,
    primary key(IdPsSupplier, IdPsProduct),
    constraint fk_product_supplier_supplier foreign key (IdPsSupplier) references supplier(Idsupplier),
	constraint fk_product_supplier_product foreign key (IdPsProduct) references product(idProduct)
);

-- tabelas estrega;
create table entrega(
	IdEntrega int auto_increment  primary key,
    IdEntProduct int,
    Quantity int not null,
    CodRastreio int,
    StatusEntrega enum('Entregue','Em transito','Pendente'), 
    constraint fk_entrega_poduct foreign key (IdEntProduct) references product(Idproduct)
	
);
drop table entrega;
-- inserindo dados;
insert into Clients(Fname, Minit, Lname, CPF, Address)
	values ('Maria','M','Silva',123456789,'rua prata 29, Caramgola'),
    ('Matheus','O','Pimentel',987654321,'rua gold 854, Centro'),
    ('Ricardo','F','Silva',856497231,'rua  da silva 654, Centro'),
    ('Julia','S','França',6598732154,'rua merenge 346, Centro'),
    ('Roberta','M','Assis',852164793,'rua silver 17, Centro'),
    ('Isabella','M','Cruz',753216985,'rua fulá 291, Caramgola');
    
insert into product(Pname, classification_kids, category, Avaliation, size)
		values('Fone',false,'ELetrônico','4',null),
        ('Barbie',true,'Brinquedos','3',null),
        ('Carters',true,'Vestimenta','5',null),
        ('Microfone',false,'ELetrônico','4',null),
        ('Coxa',false,'Vestimenta','3','3x57x80'),
        ('arroz',false,'Alimentos','2',null),
        ('FireStick',false,'ELetrônico','3',null);
 
insert into orders (IdOrderClient,OrderStatus,OrderDescription,SendValue,paymentCash)
	values(1, default,'compra via aplicativo',null,1),
    (2, default,'compra via aplicativo',50,0),
    (3, 'Confirmado',null,null,1),
    (4, default,'compra via web site',150,0);

delete from orders where IdOrderClient in (1,2,3,4);
select * from orders;

insert into productOrder (IdPOproduct,  IdPOorder, PoQuantity, PoStatus)
	value(15,14,12,null),
    (16,15,5,null),
    (17,16,10,null);
    
insert into productStorage (IdProdStorage,StorageLocation, Quantity)
	values (16,'Rio de Janeiro', 1000), 
	(17,'Rio de Janeiro', 500), 
	(18,'São Paulo', 10), 
	(19,'São Paulo', 100), 
	(20,'São Paulo', 10),
	(21,'Brasília', 60); 

insert into StorageLocation(IdLproduct, IdLstorage, Location)
	values (15,2,'RJ'),
    (16,6,'GO');

insert into supplier(SocialName, CNPJ, Contact)
	values('Almeida e Filhos', 125632458715236,'25643187'),
    ('Eletrônicos Silva', 851236201564789,'856971235'),
    ('Eletrônicos Valma', 0231546987451203,'75362489');

insert into product_Supplier (IdPsSupplier, IdPsProduct, Quantity)
	values(1,18,500),
    (1,19,400),
	(2,20,633),
    (3,15,5),
    (2,21,10);

insert into seller(SocialName, AbsName, CNPJ, CPF, Location, Contact)
	values('Tech Eletronics', null, 125346829715326, null, 'Rio de Janeiro', 2654823164),
    ('Botique Durgas', null, null, 12563214, 'Rio de Janeiro', 8524823164),
    ('Kids World', null, 521346829715326, null, 'São Paulo', 2654823461);

insert into productSeller (IdPseller, IdPproduct, ProdQuantity)
	values(1,18,80),
    (1,19,10);   
 
insert into payments (idPayClient, typePayment, limitAvailiable)
	values(1, 'Boleto',null),
    (2, 'Dois cartões',null),
    (3, 'Cartão',500),
    (4, 'Boleto',100),
    (2, 'Boleto',300),
    (5, 'Cartão',null),
    (1, 'Cartão',null),
    (3, 'Cartão',800);
 
 insert into entrega (IdEntProduct, Quantity, CodRastreio, StatusEntrega)
	values(15,2,224,'Em transito'),
    (16,1,225,'Entregue'),
    (17,1,226,'Pendente');
    
    
-- consultas SQL;

-- Quantos pedidos foram feitos por cada cliente?;
   
select c.idClient, Fname, count(*) as NumberOrders from clients c inner join orders o ON c.idClient = o.IdOrderClient
		inner join productOrder p ON p.IdPOorder = o.IdOrder
        group by c.idClient;
        
        
-- Relação de produtos fornecedores e estoques;    
  
    
show tables;
select * from Clients;
select * from product;
select * from supplier;
select * from seller;
select * from payments;
select * from productOrder;
select * from entrega;
select * from orders;
select * from productStorage;
select * from productStorage;