
CREATE TABLE regioes (
                id_regiao INT NOT NULL,
                nome_regiao VARCHAR(25) NOT NULL,
                PRIMARY KEY (id_regiao)
);


CREATE UNIQUE INDEX nome_regiao
 ON regioes
 ( nome_regiao );

CREATE TABLE paises (
                id_pais CHAR(2) NOT NULL,
                id_regiao INT,
                nome_pais VARCHAR(30) NOT NULL,
                PRIMARY KEY (id_pais)
);


CREATE UNIQUE INDEX nome_pais_ak
 ON paises
 ( nome_pais );

CREATE TABLE localizacoes (
                id_localizacao INT NOT NULL,
                id_regiao INT NOT NULL,
                id_pais CHAR(2),
                endereco VARCHAR(45),
                CEP VARCHAR(8),
                uf VARCHAR(25),
                cidade VARCHAR(40),
                PRIMARY KEY (id_localizacao)
);

ALTER TABLE localizacoes MODIFY COLUMN id_pais CHAR(2) COMMENT 'FK';


CREATE TABLE cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_maximo DECIMAL(8,2),
                salario_minimo DECIMAL(8,2) NOT NULL,
                PRIMARY KEY (id_cargo)
);


CREATE UNIQUE INDEX cargos_ak
 ON cargos
 ( cargo );

CREATE TABLE departamentos (
                id_departamento INT NOT NULL,
                id_localizacao INT,
                nome_departamento VARCHAR(20) NOT NULL,
                id_gerente VARCHAR(10) DEFAULT 1 NOT NULL,
                PRIMARY KEY (id_departamento)
);


CREATE UNIQUE INDEX nome_departamento_ak
 ON departamentos
 ( nome_departamento );

CREATE TABLE empregados (
                id_empregado INT NOT NULL,
                CPF VARCHAR(11) NOT NULL,
                nome_empregado VARCHAR(75) NOT NULL,
                email VARCHAR(40) NOT NULL,
                telefone VARCHAR(20) NOT NULL,
                data_contratacao DATE NOT NULL,
                id_departamento INT,
                id_cargo VARCHAR(10),
                salario DECIMAL(8,2) NOT NULL,
                comissao DECIMAL(4,2),
                id_supervisor VARCHAR(10),
                PRIMARY KEY (id_empregado)
);


CREATE UNIQUE INDEX cpf_ak
 ON empregados
 ( CPF );

CREATE TABLE historico_cargos (
                data_contratacao DATE NOT NULL,
                id_empregado INT NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INT NOT NULL,
                data_final DATE,
                PRIMARY KEY (data_contratacao)
);


ALTER TABLE paises ADD CONSTRAINT regioes_paises_fk
FOREIGN KEY (id_regiao)
REFERENCES regioes (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE localizacoes ADD CONSTRAINT regioes_localizacoes_fk
FOREIGN KEY (id_regiao)
REFERENCES regioes (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE localizacoes ADD CONSTRAINT paises_localizacoes_fk
FOREIGN KEY (id_pais)
REFERENCES paises (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE departamentos ADD CONSTRAINT localizacoes_departamentos_fk
FOREIGN KEY (id_localizacao)
REFERENCES localizacoes (id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico_cargos ADD CONSTRAINT cargos_historico_cargos_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE departamentos ADD CONSTRAINT cargos_departamentos_fk
FOREIGN KEY (id_gerente)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT cargos_empregados_fk1
FOREIGN KEY (id_supervisor)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT departamentos_empregados_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico_cargos ADD CONSTRAINT departamentos_historico_cargos_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico_cargos ADD CONSTRAINT empregados_historico_cargos_fk
FOREIGN KEY (id_empregado)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT historico_cargos_empregados_fk
FOREIGN KEY (data_contratacao)
REFERENCES historico_cargos (data_contratacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
