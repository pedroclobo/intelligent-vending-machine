SELECT dia_semana, concelho, SUM(unidades) AS artigos_vendidos FROM vendas
WHERE make_date(CAST (ano AS INT), CAST (mes AS INT), CAST(dia_mes AS INT)) BETWEEN '2020-05-01 00:00:00' AND '2021-05-01 00:00:00'
GROUP BY
	GROUPING SETS((dia_semana), (concelho), ())
ORDER BY dia_semana, concelho;


SELECT concelho, cat, dia_semana, SUM(unidades) AS artigos_vendidos FROM vendas
WHERE distrito = 'Lisboa'
GROUP BY
	GROUPING SETS((concelho, cat, dia_semana), ())
ORDER BY concelho, cat, dia_semana;
