create database if not exists manipulation;
use manipulation;

CREATE TABLE bankAccounts(
	Id_account INT auto_increment primary key,
    Ag_num INT NOT NULL,
    Ac_num INT NOT NULL,
    Saldo FLOAT,
    CONSTRAINT identification_account_constraint UNIQUE (Ag_num, Ac_num)
    
);

CREATE TABLE bankClient(
	Id_client INT auto_increment,
    ClientAccount INT,
    CPF CHAR (11) NOT NULL,
    RG CHAR (9) NOT NULL,
    Nome VARCHAR (50) NOT NULL,
    Endereco VARCHAR(100) NOT NULL,
    Renda_mensal FLOAT,
    PRIMARY KEY (Id_client, ClientAccount),
    CONSTRAINT fk_account_client FOREIGN KEY (ClientAccount) REFERENCES bankAccounts(Id_account)
    ON UPDATE CASCADE

);

CREATE TABLE bankTransactions(
	Id_transaction INT auto_increment PRIMARY KEY,
    Ocorrencia DATETIME,
    Status_transaction VARCHAR(20),
    Valor_transferido FLOAT,
    Source_account INT,
    Destination_account INT,
    CONSTRAINT fk_source_transaction FOREIGN KEY (Source_account) REFERENCES
    bankAccounts(Id_account),
    CONSTRAINT fk_destination_transaction FOREIGN KEY (Destination_account) REFERENCES
    bankAccounts(Id_account)
	
);