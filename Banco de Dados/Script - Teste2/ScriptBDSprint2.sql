-- Criando o banco de dados
CREATE DATABASE GraoSafe;
USE GraoSafe;

-- Criandos Tabelas
CREATE TABLE Cliente(
idCliente INT PRIMARY KEY AUTO_INCREMENT,
nomeEmpresa VARCHAR(50) NOT NULL,
cnpj CHAR(14) NOT NULL,
dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
email VARCHAR(100) NOT NULL UNIQUE, 
CONSTRAINT checkEmail check(email LIKE '%@%'),
senha VARCHAR(100) NOT NULL,
telefone VARCHAR(14) UNIQUE NOT NULL
);

CREATE TABLE Endereço(
idEndereco INT PRIMARY KEY AUTO_INCREMENT,
UF CHAR(2) NOT NULL,
rua VARCHAR(100) NOT NULL,
bairro VARCHAR(20) NOT NULL,
cidade VARCHAR(50) NOT NULL,
CEP CHAR(8) NOT NULL,
fkCliente int NOT NULL,
constraint fkEndeCli FOREIGN KEY (fkCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Silo(
idSilo INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
tipo VARCHAR (50) NOT NULL,
CONSTRAINT chkTipo CHECK(tipo IN('Silo metálico', 'Silo de alvenaria', 'Silo de concreto', 'Silos bolsa', 'Armazém graneleiro')),
fkClienteSilo INT NOT NULL,
CONSTRAINT fkSiloCli FOREIGN KEY (fkClienteSilo) REFERENCES Cliente(idCliente),
capacidadeTonelada INT NOT NULL
);

CREATE TABLE SensorLM35(
idSensor INT PRIMARY KEY AUTO_INCREMENT,
dtInstalacao DATETIME,
dtManutencao DATETIME,
statusSensor VARCHAR (50),
CONSTRAINT chkStatus CHECK (statusSensor IN ('Ativo', 'Inativo', 'Manutenção')),
fkSilo INT NOT NULL,
CONSTRAINT fkSiloSensor FOREIGN KEY (fkSilo) REFERENCES Silo(idSilo)
);

CREATE TABLE dadoSensor (
idDado INT PRIMARY KEY AUTO_INCREMENT,
temperatura FLOAT NOT NULL,
dtHora DATETIME DEFAULT CURRENT_TIMESTAMP,
fkSensor INT NOT NULL,
CONSTRAINT fkSensorDado FOREIGN KEY (fkSensor) REFERENCES SensorLM35(idSensor)
);

-- Inserindo dados
INSERT INTO Cliente (nomeEmpresa, cnpj, dtCadastro, email, senha, telefone) VALUES
('Empresa ABC', 12345678000195,'2015-05-14 15:30:00','empresaabc@gmail.com', 'senha123', 5511987654321),
('Tech Solutions', 98765432000100,'2019-11-25 13:00:00','techsolutions@hotmail.com', 'senha456', 5511976543210),
('Logistica LTDA', 19283746500010,'2023-03-17 18:30:00','logistica.ltda@outlook.com', 'senha789', 5511965432109); 

INSERT INTO Endereço (UF, rua, bairro, cidade, CEP, fkCliente) VALUES
('SP', 'Rua A', 'Bairro X', 'São Paulo', 12345678, 1),
('RJ', 'Rua B', 'Bairro Y', 'Rio de Janeiro', 87654321, 2),
('MG', 'Rua C', 'Bairro Z', 'Belo Horizonte', 23456789, 3);

INSERT INTO Silo (nome, tipo, fkClienteSilo, capacidadeTonelada) VALUES
('Silo A', 'Silo de concreto',1, 124),
('Silo Central', 'Silo de concreto',2, 378),
('Silo Norte', 'Silo metálico',3, 92);

INSERT INTO SensorLM35 (dtInstalacao, dtManutencao, statusSensor,fkSilo)VALUES
('2025-03-05 14:30:00','2023-03-11 11:00:00','Ativo',1),
('2024-01-10 09:00:00', '2025-02-25 16:45:00', 'Inativo',2),
('2024-03-10 13:00:00', '2025-02-28 11:00:00', 'Inativo',3);

-- Selecionando dados
SELECT c.nomeEmpresa AS 'Nome do Cliente',
e.rua AS 'Rua',
e.bairro AS 'Bairro',
e.cidade AS 'Cidade',
s.nome AS 'Nome do Silo',
s.tipo AS 'Tipo de Silo',
capacidadeTonelada AS 'Capacidade em Toneladas',
l.statusSensor AS 'Status do Sensor'
FROM Cliente AS c JOIN Endereço AS e ON c.idCliente = e.fkCliente
JOIN Silo AS s ON e.idEndereco = s.fkClienteSilo
JOIN SensorLM35 AS l ON s.idSilo = l.fkSilo;

-- SELECT COM DADOS DO SENSOR E DA TEMPERATURA
SELECT c.nomeEmpresa AS 'Nome da empresa',
s.nome AS 'Nome do silo', s.tipo AS 'Tipo de silo', l.dtInstalacao AS 'Data de instalação do sensor',
l.dtManutencao AS 'Data de Manutenção', l. statusSensor AS 'Status do sensor' FROM
Cliente AS c JOIN Endereço AS e ON c.idCliente = e.fkCliente
JOIN Silo AS s ON e.idEndereco = s.fkClienteSilo
JOIN SensorLM35 AS l ON s.idSilo = l.fkSilo;

-- Atualizando e deletando dados 