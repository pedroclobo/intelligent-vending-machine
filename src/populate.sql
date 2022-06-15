DROP TABLE IF EXISTS responsavel_por;
DROP TABLE IF EXISTS evento_reposicao;
DROP TABLE IF EXISTS tem_outra;
DROP TABLE IF EXISTS tem_categoria;
DROP TABLE IF EXISTS instalada_em;
DROP TABLE IF EXISTS planograma;
DROP TABLE IF EXISTS ponto_de_retalho;
DROP TABLE IF EXISTS prateleira;
DROP TABLE IF EXISTS ivm;
DROP TABLE IF EXISTS retalhista;
DROP TABLE IF EXISTS produto;
DROP TABLE IF EXISTS categoria_simples;
DROP TABLE IF EXISTS super_categoria;
DROP TABLE IF EXISTS categoria;

CREATE TABLE categoria (
	nome VARCHAR(255) NOT NULL,
	PRIMARY KEY(nome)
);

CREATE TABLE categoria_simples (
	nome VARCHAR(255) NOT NULL,
	FOREIGN KEY(nome) REFERENCES categoria(nome) ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY(nome)
);

CREATE TABLE super_categoria (
	nome VARCHAR(255) NOT NULL,
	FOREIGN KEY(nome) REFERENCES categoria(nome) ON DELETE CASCADE,
	PRIMARY KEY(nome)
);

CREATE TABLE tem_outra (
	nome_super_categoria VARCHAR(255) NOT NULL,
	nome_categoria VARCHAR(255) NOT NULL,
	FOREIGN KEY(nome_super_categoria) REFERENCES super_categoria(nome) ON DELETE CASCADE,
	FOREIGN KEY(nome_categoria) REFERENCES categoria(nome) ON DELETE CASCADE,
	CHECK(nome_super_categoria <> nome_categoria),
	PRIMARY KEY(nome_categoria)
);

CREATE TABLE produto (
	ean INT NOT NULL,
	descr TEXT NOT NULL,
	CHECK (ean BETWEEN 1000000000000 and 9999999999999),
	PRIMARY KEY(ean)
);

CREATE TABLE tem_categoria (
	ean INT NOT NULL,
	nome VARCHAR(255) NOT NULL,
	FOREIGN KEY(ean) REFERENCES produto(ean) ON DELETE CASCADE,
	FOREIGN KEY(nome) REFERENCES categoria(nome) ON DELETE CASCADE,
	PRIMARY KEY(ean, nome)
);

CREATE TABLE ivm (
	num_serie VARCHAR(255) NOT NULL,
	fabricante VARCHAR(255) NOT NULL,
	PRIMARY KEY(num_serie, fabricante)
);

CREATE TABLE ponto_de_retalho (
	nome VARCHAR(255) NOT NULL,
	distrito VARCHAR(255) NOT NULL,
	concelho VARCHAR(255) NOT NULL,
	PRIMARY KEY(nome)
);

CREATE TABLE instalada_em (
	num_serie VARCHAR(255) NOT NULL,
	fabricante VARCHAR(255) NOT NULL,
	local VARCHAR(255) NOT NULL,
	FOREIGN KEY(num_serie, fabricante) REFERENCES ivm(num_serie, fabricante) ON DELETE CASCADE,
	FOREIGN KEY(local) REFERENCES ponto_de_retalho(nome) ON DELETE CASCADE,
	PRIMARY KEY(num_serie, fabricante)
);

CREATE TABLE prateleira (
	nro INT NOT NULL,
	num_serie VARCHAR(255) NOT NULL,
	fabricante VARCHAR(255) NOT NULL,
	altura INT NOT NULL,
	nome VARCHAR(255) NOT NULL,
	FOREIGN KEY(num_serie, fabricante) REFERENCES ivm(num_serie, fabricante) ON DELETE CASCADE,
	FOREIGN KEY(nome) REFERENCES categoria(nome) ON DELETE CASCADE,
	PRIMARY KEY (nro, num_serie, fabricante)
);

CREATE TABLE planograma (
	ean INT NOT NULL,
	nro INT NOT NULL,
	num_serie VARCHAR(255) NOT NULL,
	fabricante VARCHAR(255) NOT NULL,
	faces INT NOT NULL,
	unidades INT NOT NULL,
	loc INT NOT NULL,
	FOREIGN KEY(ean) REFERENCES produto(ean) ON DELETE CASCADE,
	FOREIGN KEY(nro, num_serie, fabricante) REFERENCES prateleira(nro, num_serie, fabricante) ON DELETE CASCADE,
	PRIMARY KEY(ean, nro, num_serie, fabricante)
);

CREATE TABLE retalhista (
	tin INT NOT NULL,
	name VARCHAR(255) NOT NULL,
	UNIQUE(name),
	PRIMARY KEY(tin)
);

CREATE TABLE responsavel_por (
	nome_cat VARCHAR(255) NOT NULL,
	tin INT NOT NULL,
	num_serie VARCHAR(255) NOT NULL,
	fabricante VARCHAR(255) NOT NULL,
	FOREIGN KEY(num_serie, fabricante) REFERENCES ivm(num_serie, fabricante) ON DELETE CASCADE,
	FOREIGN KEY(tin) REFERENCES retalhista(tin) ON DELETE CASCADE,
	FOREIGN KEY(nome_cat) REFERENCES categoria(nome) ON DELETE CASCADE,
	PRIMARY KEY(num_serie, fabricante)
);

CREATE TABLE evento_reposicao (
	ean INT NOT NULL,
	nro INT NOT NULL,
	num_serie VARCHAR(255) NOT NULL,
	fabricante VARCHAR(255) NOT NULL,
	instante TIMESTAMP NOT NULL,
	unidades INT NOT NULL,
	tin INT NOT NULL,
	FOREIGN KEY(ean, nro, num_serie, fabricante) REFERENCES planograma(ean, nro, num_serie, fabricante) ON DELETE CASCADE,
	FOREIGN KEY(tin) REFERENCES retalhista(tin) ON DELETE CASCADE,
	PRIMARY KEY(ean, nro, num_serie, fabricante, instante)
);