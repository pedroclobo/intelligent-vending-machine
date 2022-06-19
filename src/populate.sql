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
	FOREIGN KEY(nome) REFERENCES categoria(nome) ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY(nome)
);

CREATE TABLE tem_outra (
	nome_super_categoria VARCHAR(255) NOT NULL,
	nome_categoria VARCHAR(255) NOT NULL,
	FOREIGN KEY(nome_super_categoria) REFERENCES super_categoria(nome) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(nome_categoria) REFERENCES categoria(nome) ON DELETE CASCADE ON UPDATE CASCADE,
	CHECK(nome_super_categoria <> nome_categoria),
	PRIMARY KEY(nome_categoria)
);

CREATE TABLE produto (
	ean CHAR(13) NOT NULL,
	cat VARCHAR(255) NOT NULL,
	descr TEXT NOT NULL,
	FOREIGN KEY(cat) REFERENCES categoria(nome) ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY(ean)
);

CREATE TABLE tem_categoria (
	ean CHAR(13) NOT NULL,
	nome VARCHAR(255) NOT NULL,
	FOREIGN KEY(ean) REFERENCES produto(ean) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(nome) REFERENCES categoria(nome) ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY(ean, nome)
);

CREATE TABLE ivm (
	num_serie SERIAL NOT NULL,
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
	num_serie SERIAL NOT NULL,
	fabricante VARCHAR(255) NOT NULL,
	local VARCHAR(255) NOT NULL,
	FOREIGN KEY(num_serie, fabricante) REFERENCES ivm(num_serie, fabricante) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(local) REFERENCES ponto_de_retalho(nome) ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY(num_serie, fabricante)
);

CREATE TABLE prateleira (
	nro INT NOT NULL,
	num_serie SERIAL NOT NULL,
	fabricante VARCHAR(255) NOT NULL,
	altura INT NOT NULL,
	nome VARCHAR(255) NOT NULL,
	FOREIGN KEY(num_serie, fabricante) REFERENCES ivm(num_serie, fabricante) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(nome) REFERENCES categoria(nome) ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY(nro, num_serie, fabricante)
);

CREATE TABLE planograma (
	ean CHAR(13) NOT NULL,
	nro INT NOT NULL,
	num_serie SERIAL NOT NULL,
	fabricante VARCHAR(255) NOT NULL,
	faces INT NOT NULL,
	unidades INT NOT NULL,
	loc INT NOT NULL,
	FOREIGN KEY(ean) REFERENCES produto(ean) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(nro, num_serie, fabricante) REFERENCES prateleira(nro, num_serie, fabricante) ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY(ean, nro, num_serie, fabricante)
);

CREATE TABLE retalhista (
	tin SERIAL NOT NULL,
	name VARCHAR(255) NOT NULL UNIQUE,
	PRIMARY KEY(tin)
);

CREATE TABLE responsavel_por (
	nome_cat VARCHAR(255) NOT NULL,
	tin SERIAL NOT NULL,
	num_serie SERIAL NOT NULL,
	fabricante VARCHAR(255) NOT NULL,
	FOREIGN KEY(num_serie, fabricante) REFERENCES ivm(num_serie, fabricante) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(tin) REFERENCES retalhista(tin) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(nome_cat) REFERENCES categoria(nome) ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY(num_serie, fabricante)
);

CREATE TABLE evento_reposicao (
	ean CHAR(13) NOT NULL,
	nro INT NOT NULL,
	num_serie SERIAL NOT NULL,
	fabricante VARCHAR(255) NOT NULL,
	instante TIMESTAMP NOT NULL,
	unidades INT NOT NULL,
	tin SERIAL NOT NULL,
	FOREIGN KEY(ean, nro, num_serie, fabricante) REFERENCES planograma(ean, nro, num_serie, fabricante) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(tin) REFERENCES retalhista(tin) ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY(ean, nro, num_serie, fabricante, instante)
);

INSERT INTO categoria VALUES ('Alimentação');
INSERT INTO categoria VALUES ('Barras Energeticas');
INSERT INTO categoria VALUES ('Bebidas');
INSERT INTO categoria VALUES ('Bebidas Alcoolicas');
INSERT INTO categoria VALUES ('Bolachas');
INSERT INTO categoria VALUES ('Carnes');
INSERT INTO categoria VALUES ('Comidas');
INSERT INTO categoria VALUES ('Doces');
INSERT INTO categoria VALUES ('Refrigerantes');
INSERT INTO categoria VALUES ('Salgados');
INSERT INTO categoria VALUES ('Sopas Take-Away');

INSERT INTO super_categoria VALUES ('Alimentação');
INSERT INTO super_categoria VALUES ('Bebidas');
INSERT INTO super_categoria VALUES ('Comidas');

INSERT INTO categoria_simples VALUES ('Barras Energeticas');
INSERT INTO categoria_simples VALUES ('Bebidas Alcoolicas');
INSERT INTO categoria_simples VALUES ('Bolachas');
INSERT INTO categoria_simples VALUES ('Carnes');
INSERT INTO categoria_simples VALUES ('Doces');
INSERT INTO categoria_simples VALUES ('Refrigerantes');
INSERT INTO categoria_simples VALUES ('Salgados');
INSERT INTO categoria_simples VALUES ('Sopas Take-Away');

INSERT INTO produto VALUES ('2161546484063', 'Carnes', 'Frango');
INSERT INTO produto VALUES ('2748425344955', 'Bebidas', 'Agua');
INSERT INTO produto VALUES ('3298630330148', 'Comidas', 'Pao');
INSERT INTO produto VALUES ('3765340111140', 'Salgados', 'Croquete');
INSERT INTO produto VALUES ('4823304474287', 'Bebidas Alcoolicas', 'Sangria');
INSERT INTO produto VALUES ('5555122201378', 'Sopas Take-Away', 'Caldo Verde');
INSERT INTO produto VALUES ('6498529522754', 'Bolachas', 'Oreo');
INSERT INTO produto VALUES ('6786407776628', 'Barras Energeticas', 'Barra Proteina');
INSERT INTO produto VALUES ('8379292605586', 'Refrigerantes', 'Sumo de Laranja');

INSERT INTO retalhista (name) VALUES ('Joao Barroso');
INSERT INTO retalhista (name) VALUES ('Andre Martins');
INSERT INTO retalhista (name) VALUES ('Carolina Ferreira');
INSERT INTO retalhista (name) VALUES ('Manuel Lopes');

INSERT INTO ivm (fabricante) VALUES ('Pingo Doce');
INSERT INTO ivm (fabricante) VALUES ('Continente');
INSERT INTO ivm (fabricante) VALUES ('Aldi');
INSERT INTO ivm (fabricante) VALUES ('CascaisShopping');
INSERT INTO ivm (fabricante) VALUES ('OeirasPark');
INSERT INTO ivm (fabricante) VALUES ('Lidl');
INSERT INTO ivm (fabricante) VALUES ('AlgarveShopping');
INSERT INTO ivm (fabricante) VALUES ('Talho da Maria');
INSERT INTO ivm (fabricante) VALUES ('Colombo');
INSERT INTO ivm (fabricante) VALUES ('Amoreiras');

INSERT INTO prateleira VALUES ('1', '1', 'Pingo Doce', '10', 'Comidas');
INSERT INTO prateleira VALUES ('2', '1', 'Pingo Doce', '15', 'Sopas Take-Away');
INSERT INTO prateleira VALUES ('3', '1', 'Pingo Doce', '12', 'Refrigerantes');
INSERT INTO prateleira VALUES ('4', '1', 'Pingo Doce', '20', 'Bebidas');
INSERT INTO prateleira VALUES ('5', '1', 'Pingo Doce', '18', 'Bebidas Alcoolicas');
INSERT INTO prateleira VALUES ('1', '2', 'Continente', '17', 'Bolachas');
INSERT INTO prateleira VALUES ('2', '2', 'Continente', '12', 'Doces');
INSERT INTO prateleira VALUES ('3', '2', 'Continente', '10', 'Salgados');
INSERT INTO prateleira VALUES ('4', '2', 'Continente', '8', 'Carnes');
INSERT INTO prateleira VALUES ('5', '2', 'Continente', '4', 'Salgados');
INSERT INTO prateleira VALUES ('1', '3', 'Aldi', '10', 'Sopas Take-Away');
INSERT INTO prateleira VALUES ('2', '3', 'Aldi', '8', 'Salgados');
INSERT INTO prateleira VALUES ('3', '3', 'Aldi', '2', 'Doces');
INSERT INTO prateleira VALUES ('4', '3', 'Aldi', '12', 'Comidas');
INSERT INTO prateleira VALUES ('5', '3', 'Aldi', '11', 'Bolachas');
INSERT INTO prateleira VALUES ('1', '4', 'CascaisShopping', '8', 'Bebidas');
INSERT INTO prateleira VALUES ('2', '4', 'CascaisShopping', '7', 'Barras Energeticas');
INSERT INTO prateleira VALUES ('3', '4', 'CascaisShopping', '9', 'Doces');
INSERT INTO prateleira VALUES ('4', '4', 'CascaisShopping', '5', 'Comidas');
INSERT INTO prateleira VALUES ('5', '4', 'CascaisShopping', '12', 'Bebidas');
INSERT INTO prateleira VALUES ('1', '5', 'OeirasPark', '11', 'Bebidas');
INSERT INTO prateleira VALUES ('2', '5', 'OeirasPark', '2', 'Barras Energeticas');
INSERT INTO prateleira VALUES ('3', '5', 'OeirasPark', '13', 'Doces');
INSERT INTO prateleira VALUES ('4', '5', 'OeirasPark', '4', 'Comidas');
INSERT INTO prateleira VALUES ('5', '5', 'OeirasPark', '17', 'Carnes');
INSERT INTO prateleira VALUES ('1', '6', 'Lidl', '9', 'Bebidas');
INSERT INTO prateleira VALUES ('2', '6', 'Lidl', '8', 'Salgados');
INSERT INTO prateleira VALUES ('3', '6', 'Lidl', '17', 'Carnes');
INSERT INTO prateleira VALUES ('4', '6', 'Lidl', '7', 'Bolachas');
INSERT INTO prateleira VALUES ('5', '6', 'Lidl', '25', 'Salgados');
INSERT INTO prateleira VALUES ('1', '7', 'AlgarveShopping', '10', 'Barras Energeticas');
INSERT INTO prateleira VALUES ('2', '7', 'AlgarveShopping', '8', 'Salgados');
INSERT INTO prateleira VALUES ('3', '7', 'AlgarveShopping', '19', 'Carnes');
INSERT INTO prateleira VALUES ('4', '7', 'AlgarveShopping', '18', 'Bolachas');
INSERT INTO prateleira VALUES ('5', '7', 'AlgarveShopping', '25', 'Salgados');
INSERT INTO prateleira VALUES ('1', '8', 'Talho da Maria', '10', 'Carnes');
INSERT INTO prateleira VALUES ('1', '9', 'Colombo', '18', 'Carnes');
INSERT INTO prateleira VALUES ('2', '9', 'Colombo', '9', 'Refrigerantes');
INSERT INTO prateleira VALUES ('3', '9', 'Colombo', '12', 'Carnes');
INSERT INTO prateleira VALUES ('4', '9', 'Colombo', '3', 'Bolachas');
INSERT INTO prateleira VALUES ('5', '9', 'Colombo', '12', 'Sopas Take-Away');
INSERT INTO prateleira VALUES ('1', '10', 'Amoreiras', '12', 'Refrigerantes');
INSERT INTO prateleira VALUES ('2', '10', 'Amoreiras', '20', 'Bolachas');
INSERT INTO prateleira VALUES ('3', '10', 'Amoreiras', '10', 'Carnes');
INSERT INTO prateleira VALUES ('4', '10', 'Amoreiras', '19', 'Bolachas');
INSERT INTO prateleira VALUES ('5', '10', 'Amoreiras', '12', 'Sopas Take-Away');

INSERT INTO ponto_de_retalho VALUES ('Aldi - Oeiras', 'Lisboa', 'Oeiras');
INSERT INTO ponto_de_retalho VALUES ('AlgarveShopping', 'Algarve', 'Portimão');
INSERT INTO ponto_de_retalho VALUES ('CascaisShopping', 'Lisboa', 'Cascais');
INSERT INTO ponto_de_retalho VALUES ('Continente - Tires', 'Lisboa', 'Cascais');
INSERT INTO ponto_de_retalho VALUES ('Galp - Oeiras', 'Lisboa', 'Oeiras');
INSERT INTO ponto_de_retalho VALUES ('OeirasPark', 'Lisboa', 'Oeiras');
INSERT INTO ponto_de_retalho VALUES ('Pingo Doce - Cascais', 'Lisboa', 'Cascais');

INSERT INTO planograma VALUES ('2161546484063', '1', '1', 'Pingo Doce', '2', '10', '5');
INSERT INTO planograma VALUES ('5555122201378', '2', '1', 'Pingo Doce', '3', '20', '1');
INSERT INTO planograma VALUES ('8379292605586', '3', '1', 'Pingo Doce', '1', '15', '2');
INSERT INTO planograma VALUES ('3765340111140', '3', '2', 'Continente', '10', '20', '1');
INSERT INTO planograma VALUES ('6498529522754', '1', '2', 'Continente', '10', '50', '3');
INSERT INTO planograma VALUES ('2161546484063', '4', '2', 'Continente', '1', '20', '1');
INSERT INTO planograma VALUES ('2161546484063', '4', '3', 'Aldi', '4', '20', '1');
INSERT INTO planograma VALUES ('2161546484063', '4', '5', 'OeirasPark', '2', '15', '3');
INSERT INTO planograma VALUES ('2748425344955', '1', '4', 'CascaisShopping', '6', '15', '2');
INSERT INTO planograma VALUES ('2748425344955', '5', '4', 'CascaisShopping', '12', '25', '1');
INSERT INTO planograma VALUES ('6786407776628', '2', '5', 'OeirasPark', '12', '100', '2');
INSERT INTO planograma VALUES ('6498529522754', '4', '6', 'Lidl', '7', '60', '1');
INSERT INTO planograma VALUES ('3765340111140', '5', '7', 'AlgarveShopping', '25', '12', '3');
INSERT INTO planograma VALUES ('6786407776628', '1', '7', 'AlgarveShopping', '10', '15', '1');
INSERT INTO planograma VALUES ('2161546484063', '1', '8', 'Talho da Maria', '100', '200', '4');
INSERT INTO planograma VALUES ('6498529522754', '4', '9', 'Colombo', '10', '25', '1');
INSERT INTO planograma VALUES ('5555122201378', '5', '9', 'Colombo', '12', '12', '2');
INSERT INTO planograma VALUES ('8379292605586', '1', '10', 'Amoreiras', '12', '20', '1');

INSERT INTO instalada_em VALUES ('1', 'Pingo Doce', 'Pingo Doce - Cascais');
INSERT INTO instalada_em VALUES ('2', 'Continente', 'Continente - Tires');
INSERT INTO instalada_em VALUES ('3', 'Aldi', 'Aldi - Oeiras');
INSERT INTO instalada_em VALUES ('4', 'CascaisShopping', 'CascaisShopping');
INSERT INTO instalada_em VALUES ('5', 'OeirasPark', 'OeirasPark');
INSERT INTO instalada_em VALUES ('6', 'Lidl', 'CascaisShopping');

INSERT INTO tem_categoria VALUES ('2161546484063', 'Comidas');
INSERT INTO tem_categoria VALUES ('2161546484063', 'Carnes');
INSERT INTO tem_categoria VALUES ('2748425344955', 'Bebidas');
INSERT INTO tem_categoria VALUES ('3298630330148', 'Comidas');
INSERT INTO tem_categoria VALUES ('3765340111140', 'Comidas');
INSERT INTO tem_categoria VALUES ('3765340111140', 'Salgados');
INSERT INTO tem_categoria VALUES ('4823304474287', 'Bebidas Alcoolicas');
INSERT INTO tem_categoria VALUES ('4823304474287', 'Bebidas');
INSERT INTO tem_categoria VALUES ('5555122201378', 'Comidas');
INSERT INTO tem_categoria VALUES ('5555122201378', 'Sopas Take-Away');
INSERT INTO tem_categoria VALUES ('6498529522754', 'Comidas');
INSERT INTO tem_categoria VALUES ('6498529522754', 'Bolachas');
INSERT INTO tem_categoria VALUES ('6786407776628', 'Comidas');
INSERT INTO tem_categoria VALUES ('6786407776628', 'Barras Energeticas');
INSERT INTO tem_categoria VALUES ('8379292605586', 'Bebidas');
INSERT INTO tem_categoria VALUES ('8379292605586', 'Refrigerantes');

INSERT INTO tem_outra VALUES ('Alimentação', 'Bebidas');
INSERT INTO tem_outra VALUES ('Alimentação', 'Comidas');
INSERT INTO tem_outra VALUES ('Bebidas', 'Bebidas Alcoolicas');
INSERT INTO tem_outra VALUES ('Bebidas', 'Refrigerantes');
INSERT INTO tem_outra VALUES ('Comidas', 'Barras Energeticas');
INSERT INTO tem_outra VALUES ('Comidas', 'Bolachas');
INSERT INTO tem_outra VALUES ('Comidas', 'Carnes');
INSERT INTO tem_outra VALUES ('Comidas', 'Doces');
INSERT INTO tem_outra VALUES ('Comidas', 'Salgados');
INSERT INTO tem_outra VALUES ('Comidas', 'Sopas Take-Away');

INSERT INTO evento_reposicao VALUES ('2161546484063', '1', '1', 'Pingo Doce', '2020-01-12 13:40:21', '9', '3');
INSERT INTO evento_reposicao VALUES ('2161546484063', '1', '1', 'Pingo Doce', '2020-01-13 18:31:20', '10', '3');
INSERT INTO evento_reposicao VALUES ('5555122201378', '2', '1', 'Pingo Doce', '2021-04-13 21:17:12', '15', '1');
INSERT INTO evento_reposicao VALUES ('8379292605586', '3', '1', 'Pingo Doce', '2020-08-29 17:35:15', '12', '1');
INSERT INTO evento_reposicao VALUES ('3765340111140', '3', '2', 'Continente', '2020-06-23 16:54:12', '17', '2');
INSERT INTO evento_reposicao VALUES ('6498529522754', '1', '2', 'Continente', '2020-08-12 14:32:12', '32', '4');
INSERT INTO evento_reposicao VALUES ('2161546484063', '4', '2', 'Continente', '2020-09-01 16:41:41', '15', '3');
INSERT INTO evento_reposicao VALUES ('2161546484063', '4', '3', 'Aldi', '2020-12-02 21:14:02', '10', '2');
INSERT INTO evento_reposicao VALUES ('2748425344955', '5', '4', 'CascaisShopping', '2020-12-03 12:17:30', '24', '4');
INSERT INTO evento_reposicao VALUES ('6786407776628', '2', '5', 'OeirasPark', '2021-02-04 14:32:24', '97', '4');
INSERT INTO evento_reposicao VALUES ('6498529522754', '4', '6', 'Lidl', '2021-03-14 14:03:15', '60', '1');
INSERT INTO evento_reposicao VALUES ('3765340111140', '5', '7', 'AlgarveShopping', '2021-04-01 15:02:12', '11', '2');
INSERT INTO evento_reposicao VALUES ('6786407776628', '1', '7', 'AlgarveShopping', '2021-04-13 18:12:32', '10', '2');
INSERT INTO evento_reposicao VALUES ('2161546484063', '1', '8', 'Talho da Maria', '2021-06-21 16:31:14', '150', '4');
INSERT INTO evento_reposicao VALUES ('6498529522754', '4', '9', 'Colombo', '2021-06-12 12:15:15', '21', '2');
INSERT INTO evento_reposicao VALUES ('5555122201378', '5', '9', 'Colombo', '2021-06-12 13:12:14', '11', '4');
INSERT INTO evento_reposicao VALUES ('8379292605586', '1', '10', 'Amoreiras', '2021-07-12 15:21:23', '18', '2');

INSERT INTO responsavel_por VALUES ('Barras Energeticas', '3', '5', 'OeirasPark');
INSERT INTO responsavel_por VALUES ('Bebidas Alcoolicas', '3', '1', 'Pingo Doce');
INSERT INTO responsavel_por VALUES ('Bolachas', '1', '2', 'Continente');
INSERT INTO responsavel_por VALUES ('Bolachas', '3', '6', 'Lidl');
INSERT INTO responsavel_por VALUES ('Comidas', '2', '3', 'Aldi');
INSERT INTO responsavel_por VALUES ('Carnes', '3', '8', 'Talho da Maria');
INSERT INTO responsavel_por VALUES ('Doces', '3', '4', 'CascaisShopping');
INSERT INTO responsavel_por VALUES ('Refrigerantes', '3', '7', 'AlgarveShopping');
INSERT INTO responsavel_por VALUES ('Salgados', '3', '9', 'Colombo');
INSERT INTO responsavel_por VALUES ('Sopas Take-Away', '3', '10', 'Amoreiras');
