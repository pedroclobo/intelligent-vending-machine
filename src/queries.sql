SELECT name
FROM responsavel_por NATURAL JOIN retalhista
GROUP BY name
HAVING COUNT(DISTINCT nome_cat) >= ALL (
	SELECT COUNT(DISTINCT nome_cat)
	FROM responsavel_por NATURAL JOIN retalhista
	GROUP BY name
);


SELECT name
FROM responsavel_por NATURAL JOIN retalhista
GROUP BY name
HAVING COUNT(DISTINCT nome_cat) = (
	SELECT COUNT(*)
	FROM categoria_simples
);


(SELECT ean FROM produto)
EXCEPT
(SELECT ean FROM evento_reposicao);


SELECT ean
FROM evento_reposicao
GROUP BY ean
HAVING COUNT(DISTINCT tin) = 1;
