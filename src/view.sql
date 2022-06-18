DROP VIEW IF EXISTS vendas;

CREATE VIEW Vendas(ean, cat, ano, trimestre, mes, dia_mes, dia_semana, distrito, concelho, unidades) AS
	SELECT
		ean,
		A.nome AS cat,
		EXTRACT(YEAR from instante) AS ano,
		EXTRACT(QUARTER from instante) AS trimestre,
		EXTRACT(MONTH from instante) AS mes,
		EXTRACT(DAY from instante) AS dia_mes,
		EXTRACT(DOW from instante) AS dia_semana,
		distrito,
		concelho,
		unidades
	FROM (evento_reposicao NATURAL JOIN instalada_em NATURAL JOIN prateleira) AS A
	JOIN ponto_de_retalho ON A.local = ponto_de_retalho.nome;
