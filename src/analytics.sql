SELECT dia_semana, concelho, SUM(unidades) AS artigos_vendidos FROM vendas
WHERE ano BETWEEN 1980 AND 2021 AND
	mes BETWEEN 10 AND 12 AND
	dia_mes BETWEEN 2 AND 3
GROUP BY
	GROUPING SETS((dia_semana), (concelho), ());


SELECT concelho, cat, dia_semana, SUM(unidades) AS artigos_vendidos FROM vendas
WHERE distrito = 'Lisboa'
GROUP BY
	GROUPING SETS((concelho, cat, dia_semana), ());
