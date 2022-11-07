
CREATE TABLE public.regioes (
                id_regiao INTEGER NOT NULL,
                nome_regiao VARCHAR(25) NOT NULL,
                CONSTRAINT id_regiao PRIMARY KEY (id_regiao)
);


CREATE UNIQUE INDEX nome_regiao
 ON public.regioes
 ( nome_regiao );

CREATE TABLE public.paises (
                id_pais CHAR(2) NOT NULL,
                id_regiao INTEGER,
                nome_pais VARCHAR(30) NOT NULL,
                CONSTRAINT id_paises PRIMARY KEY (id_pais)
);


CREATE UNIQUE INDEX nome_pais_ak
 ON public.paises
 ( nome_pais );

CREATE TABLE public.localizacoes (
                id_localizacao INTEGER NOT NULL,
                id_regiao INTEGER NOT NULL,
                id_pais CHAR(2),
                endereco VARCHAR(45),
                CEP VARCHAR(8),
                uf VARCHAR(25),
                cidade VARCHAR(40),
                CONSTRAINT id_localizacao PRIMARY KEY (id_localizacao)
);
COMMENT ON COLUMN public.localizacoes.id_pais IS 'FK';


CREATE TABLE public.cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_maximo NUMERIC(8,2),
                salario_minimo NUMERIC(8,2) NOT NULL,
                CONSTRAINT id_cargos PRIMARY KEY (id_cargo)
);


CREATE UNIQUE INDEX cargos_ak
 ON public.cargos
 ( cargo );

CREATE TABLE public.departamentos (
                id_departamento INTEGER NOT NULL,
                id_localizacao INTEGER,
                nome_departamento VARCHAR(20) NOT NULL,
                id_gerente VARCHAR(10) DEFAULT 1 NOT NULL,
                CONSTRAINT id_departamento PRIMARY KEY (id_departamento)
);


CREATE UNIQUE INDEX nome_departamento_ak
 ON public.departamentos
 ( nome_departamento );

CREATE TABLE public.empregados (
                id_empregado INTEGER NOT NULL,
                CPF VARCHAR(11) NOT NULL,
                nome_empregado VARCHAR(75) NOT NULL,
                email VARCHAR(40) NOT NULL,
                telefone VARCHAR(20) NOT NULL,
                data_contratacao DATE NOT NULL,
                id_departamento INTEGER,
                id_cargo VARCHAR(10),
                salario NUMERIC(8,2) NOT NULL,
                comissao NUMERIC(4,2),
                id_supervisor VARCHAR(10),
                CONSTRAINT id_empregado PRIMARY KEY (id_empregado)
);


CREATE UNIQUE INDEX cpf_ak
 ON public.empregados
 ( CPF );

CREATE TABLE public.historico_cargos (
                data_contratacao DATE NOT NULL,
                id_empregado INTEGER NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INTEGER NOT NULL,
                data_final DATE,
                CONSTRAINT data_inicial PRIMARY KEY (data_contratacao)
);


ALTER TABLE public.paises ADD CONSTRAINT regioes_paises_fk
FOREIGN KEY (id_regiao)
REFERENCES public.regioes (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.localizacoes ADD CONSTRAINT regioes_localizacoes_fk
FOREIGN KEY (id_regiao)
REFERENCES public.regioes (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.localizacoes ADD CONSTRAINT paises_localizacoes_fk
FOREIGN KEY (id_pais)
REFERENCES public.paises (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.departamentos ADD CONSTRAINT localizacoes_departamentos_fk
FOREIGN KEY (id_localizacao)
REFERENCES public.localizacoes (id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES public.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.historico_cargos ADD CONSTRAINT cargos_historico_cargos_fk
FOREIGN KEY (id_cargo)
REFERENCES public.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.departamentos ADD CONSTRAINT cargos_departamentos_fk
FOREIGN KEY (id_gerente)
REFERENCES public.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.empregados ADD CONSTRAINT cargos_empregados_fk1
FOREIGN KEY (id_supervisor)
REFERENCES public.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.empregados ADD CONSTRAINT departamentos_empregados_fk
FOREIGN KEY (id_departamento)
REFERENCES public.departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.historico_cargos ADD CONSTRAINT departamentos_historico_cargos_fk
FOREIGN KEY (id_departamento)
REFERENCES public.departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.historico_cargos ADD CONSTRAINT empregados_historico_cargos_fk
FOREIGN KEY (id_empregado)
REFERENCES public.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.empregados ADD CONSTRAINT historico_cargos_empregados_fk
FOREIGN KEY (data_contratacao)
REFERENCES public.historico_cargos (data_contratacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
