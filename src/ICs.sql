DROP TRIGGER IF EXISTS ri_4 ON evento_reposicao;
DROP TRIGGER IF EXISTS ri_5 ON evento_reposicao;

CREATE OR REPLACE FUNCTION ri_4_proc()
RETURNS TRIGGER
AS $$
DECLARE unidades_planograma INT;
BEGIN
	SELECT unidades INTO unidades_planograma
	FROM planograma
	WHERE ean = new.ean AND
		nro = new.nro AND
		num_serie = new.num_serie AND
		fabricante = new.fabricante;

	IF new.unidades > unidades_planograma THEN
		RAISE EXCEPTION	'O número de unidades repostas não pode exceder o especificado no planograma (%).', unidades_planograma;
	END IF;

	RETURN NEW;
END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ri_5_proc()
RETURNS TRIGGER
AS $$
DECLARE categoria_prateleira VARCHAR(255);
BEGIN
	SELECT nome INTO categoria_prateleira
	FROM prateleira
	WHERE nro = new.nro AND
		num_serie = new.num_serie AND
		fabricante = new.fabricante;

	IF categoria_prateleira NOT IN (SELECT nome FROM tem_categoria WHERE ean = new.ean) THEN
		RAISE EXCEPTION
			'A prateleira não apresenta nenhuma das categorias do produto.';
	END IF;

	RETURN NEW;
END
$$
LANGUAGE plpgsql;


CREATE TRIGGER ri_4_insert
BEFORE INSERT ON evento_reposicao
FOR EACH ROW EXECUTE PROCEDURE ri_4_proc();

CREATE TRIGGER ri_4_update
BEFORE UPDATE ON evento_reposicao
FOR EACH ROW EXECUTE PROCEDURE ri_4_proc();

CREATE TRIGGER ri_5_insert
BEFORE INSERT ON evento_reposicao
FOR EACH ROW EXECUTE PROCEDURE ri_5_proc();

CREATE TRIGGER ri_5_update
BEFORE UPDATE ON evento_reposicao
FOR EACH ROW EXECUTE PROCEDURE ri_5_proc();
