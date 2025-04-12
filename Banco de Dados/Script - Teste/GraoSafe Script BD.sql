CREATE TABLE graosafe;
USE graosafe;

CREATE TABLE Cliente(
idCliente INT PRIMARY KEY AUTO_INCREMENT,
nomeEmpresa VARCHAR(50) NOT NULL,
cnpj CHAR(14) NOT NULL,
dtCadastro DATETIME,
email VARCHAR(100) NOT NULL UNIQUE, 
CONSTRAINT checkEmail check(email LIKE '%@%'), -- Confirmando se o email possui @, mas sem verificar o domínio pois cada empresa pode ter seu próprio domínio
senha VARCHAR(100) NOT NULL,
telefone VARCHAR(14) UNIQUE NOT NULL
);

CREATE TABLE endereco (
idEndereco INT PRIMARY KEY AUTO_INCREMENT,
UF CHAR(2) NOT NULL,
rua VARCHAR(100) NOT NULL,
bairro VARCHAR(20) NOT NULL,
cidade VARCHAR(50) NOT NULL,
cep CHAR(8) NOT NULL,
fkCliente int NOT NULL,
constraint fkEndeCli FOREIGN KEY (fkCliente) REFERENCES cliente(idCliente)
);

CREATE TABLE silo (
idSilo INT PRIMARY KEY AUTO_INCREMENT,
tipo VARCHAR (50) NOT NULL,
CONSTRAINT chkTipo CHECK(tipo IN('Silo metálico', 'Silo de alvenaria', 'Silo de concreto', 'Silos bolsa', 'Armazém graneleiro')),
fkClienteSilo INT NOT NULL,
CONSTRAINT fkSiloCli FOREIGN KEY (fkClienteSilo) REFERENCES cliente(idCliente),
capacidadeTonelada DECIMAL (10,2) NOT NULL
);

CREATE TABLE sensorLM35 (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
dtInstalacao DATE NOT NULL,
statusSensor VARCHAR (50),
CONSTRAINT chkStatus CHECK (statusSensor IN ('Ativo', 'Inativo', 'Manutenção')),
fkSilo INT NOT NULL,
CONSTRAINT fkSiloSensor FOREIGN KEY (fkSilo) REFERENCES silo(idSilo)
);

CREATE TABLE dadoSensor (
idDado INT PRIMARY KEY AUTO_INCREMENT,
temperatura DECIMAL (5,2) NOT NULL,
dtHora DATETIME NOT NULL,
fkSensor INT NOT NULL,
CONSTRAINT fkSensorDado FOREIGN KEY (fkSensor) REFERENCES sensorLM35(idSensor)
);