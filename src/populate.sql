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

INSERT INTO produto VALUES ('2161546484063', 'Frango');
INSERT INTO produto VALUES ('2748425344955', 'Agua');
INSERT INTO produto VALUES ('3298630330148', 'Pao');
INSERT INTO produto VALUES ('3765340111140', 'Croquete');
INSERT INTO produto VALUES ('4823304474287', 'Sangria');
INSERT INTO produto VALUES ('5555122201378', 'Caldo Verde');
INSERT INTO produto VALUES ('6498529522754', 'Oreo');
INSERT INTO produto VALUES ('6786407776628', 'Barra Proteina');
INSERT INTO produto VALUES ('8379292605586', 'Sumo de Laranja');

INSERT INTO retalhista VALUES ('1', 'Joao Barroso');
INSERT INTO retalhista VALUES ('2', 'Andre Martins');
INSERT INTO retalhista VALUES ('3', 'Carolina Ferreira');
INSERT INTO retalhista VALUES ('4', 'Manuel Lopes');
INSERT INTO retalhista VALUES ('5', 'Pedro Silva');
INSERT INTO retalhista VALUES ('6', 'Bernardo Soares');

INSERT INTO ivm VALUES ('27828348', 'Pingo Doce');
INSERT INTO ivm VALUES ('32956833', 'Continente');
INSERT INTO ivm VALUES ('74639833', 'Aldi');
INSERT INTO ivm VALUES ('76275876', 'CascaisShopping');
INSERT INTO ivm VALUES ('86998436', 'OeirasPark');
INSERT INTO ivm VALUES ('93999269', 'Lidl');

INSERT INTO prateleira VALUES ('1', '27828348', 'Pingo Doce', '10', 'Comidas');
INSERT INTO prateleira VALUES ('2', '27828348', 'Pingo Doce', '15', 'Sopas Take-Away');
INSERT INTO prateleira VALUES ('3', '27828348', 'Pingo Doce', '12', 'Refrigerantes');
INSERT INTO prateleira VALUES ('4', '27828348', 'Pingo Doce', '20', 'Bebidas');
INSERT INTO prateleira VALUES ('5', '27828348', 'Pingo Doce', '18', 'Bebidas Alcoolicas');
INSERT INTO prateleira VALUES ('1', '32956833', 'Continente', '17', 'Bolachas');
INSERT INTO prateleira VALUES ('2', '32956833', 'Continente', '12', 'Doces');
INSERT INTO prateleira VALUES ('3', '32956833', 'Continente', '10', 'Salgados');
INSERT INTO prateleira VALUES ('4', '32956833', 'Continente', '8', 'Carnes');
INSERT INTO prateleira VALUES ('5', '32956833', 'Continente', '4', 'Salgados');
INSERT INTO prateleira VALUES ('1', '74639833', 'Aldi', '10', 'Sopas Take-Away');
INSERT INTO prateleira VALUES ('2', '74639833', 'Aldi', '8', 'Salgados');
INSERT INTO prateleira VALUES ('3', '74639833', 'Aldi', '2', 'Doces');
INSERT INTO prateleira VALUES ('4', '74639833', 'Aldi', '12', 'Comidas');
INSERT INTO prateleira VALUES ('5', '74639833', 'Aldi', '11', 'Bolachas');
INSERT INTO prateleira VALUES ('1', '76275876', 'CascaisShopping', '8', 'Bebidas');
INSERT INTO prateleira VALUES ('2', '76275876', 'CascaisShopping', '7', 'Barras Energeticas');
INSERT INTO prateleira VALUES ('3', '76275876', 'CascaisShopping', '9', 'Doces');
INSERT INTO prateleira VALUES ('4', '76275876', 'CascaisShopping', '5', 'Comidas');
INSERT INTO prateleira VALUES ('5', '76275876', 'CascaisShopping', '12', 'Bebidas');
INSERT INTO prateleira VALUES ('1', '86998436', 'OeirasPark', '11', 'Bebidas');
INSERT INTO prateleira VALUES ('2', '86998436', 'OeirasPark', '2', 'Barras Energeticas');
INSERT INTO prateleira VALUES ('3', '86998436', 'OeirasPark', '13', 'Doces');
INSERT INTO prateleira VALUES ('4', '86998436', 'OeirasPark', '4', 'Comidas');
INSERT INTO prateleira VALUES ('5', '86998436', 'OeirasPark', '17', 'Carnes');
INSERT INTO prateleira VALUES ('1', '93999269', 'Lidl', '9', 'Bebidas');
INSERT INTO prateleira VALUES ('2', '93999269', 'Lidl', '8', 'Salgados');
INSERT INTO prateleira VALUES ('3', '93999269', 'Lidl', '17', 'Carnes');
INSERT INTO prateleira VALUES ('4', '93999269', 'Lidl', '7', 'Bolachas');
INSERT INTO prateleira VALUES ('5', '93999269', 'Lidl', '25', 'Salgados');

INSERT INTO ponto_de_retalho VALUES ('Aldi - Oeiras', 'Lisboa', 'Oeiras');
INSERT INTO ponto_de_retalho VALUES ('AlgarveShopping', 'Algarve', 'Portimão');
INSERT INTO ponto_de_retalho VALUES ('CascaisShopping', 'Lisboa', 'Cascais');
INSERT INTO ponto_de_retalho VALUES ('Continente - Tires', 'Lisboa', 'Cascais');
INSERT INTO ponto_de_retalho VALUES ('Galp - Oeiras', 'Lisboa', 'Oeiras');
INSERT INTO ponto_de_retalho VALUES ('OeirasPark', 'Lisboa', 'Oeiras');
INSERT INTO ponto_de_retalho VALUES ('Pingo Doce - Cascais', 'Lisboa', 'Cascais');

INSERT INTO planograma VALUES ('2161546484063', '1', '27828348', 'Pingo Doce', '2', '10', '5');
INSERT INTO planograma VALUES ('2161546484063', '4', '74639833', 'Aldi', '4', '20', '1');
INSERT INTO planograma VALUES ('2748425344955', '1', '76275876', 'CascaisShopping', '6', '15', '2');
INSERT INTO planograma VALUES ('2748425344955', '5', '76275876', 'CascaisShopping', '12', '25', '1');

INSERT INTO instalada_em VALUES ('27828348', 'Pingo Doce', 'Pingo Doce - Cascais');
INSERT INTO instalada_em VALUES ('32956833', 'Continente', 'Continente - Tires');
INSERT INTO instalada_em VALUES ('74639833', 'Aldi', 'Aldi - Oeiras');
INSERT INTO instalada_em VALUES ('76275876', 'CascaisShopping', 'CascaisShopping');
INSERT INTO instalada_em VALUES ('86998436', 'OeirasPark', 'OeirasPark');
INSERT INTO instalada_em VALUES ('93999269', 'Lidl', 'CascaisShopping');

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

INSERT INTO tem_outra VALUES ('Bebidas', 'Bebidas Alcoolicas');
INSERT INTO tem_outra VALUES ('Bebidas', 'Refrigerantes');
INSERT INTO tem_outra VALUES ('Comidas', 'Barras Energeticas');
INSERT INTO tem_outra VALUES ('Comidas', 'Bolachas');
INSERT INTO tem_outra VALUES ('Comidas', 'Carnes');
INSERT INTO tem_outra VALUES ('Comidas', 'Doces');
INSERT INTO tem_outra VALUES ('Comidas', 'Salgados');
INSERT INTO tem_outra VALUES ('Comidas', 'Sopas Take-Away');

INSERT INTO evento_reposicao VALUES ('2161546484063', '1', '27828348', 'Pingo Doce', '2020-12-01 12:43:01', '9', '3');
INSERT INTO evento_reposicao VALUES ('2161546484063', '4', '74639833', 'Aldi', '2020-12-02 21:14:02', '10', '2');
INSERT INTO evento_reposicao VALUES ('2748425344955', '1', '76275876', 'CascaisShopping', '2020-12-04 13:43:12', '10', '1');
INSERT INTO evento_reposicao VALUES ('2748425344955', '5', '76275876', 'CascaisShopping', '2020-12-03 12:17:30', '24', '4');

INSERT INTO responsavel_por VALUES ('Comidas', '1', '27828348', 'Pingo Doce');
INSERT INTO responsavel_por VALUES ('Sopas Take-Away', '2', '27828348', 'Pingo Doce');
INSERT INTO responsavel_por VALUES ('Refrigerantes', '3', '27828348', 'Pingo Doce');
INSERT INTO responsavel_por VALUES ('Bebidas', '4', '27828348', 'Pingo Doce');
INSERT INTO responsavel_por VALUES ('Bebidas Alcoolicas', '5', '27828348', 'Pingo Doce');
