DROP TRIGGER IF EXISTS ri_1 ON tem_outra;
DROP TRIGGER IF EXISTS ri_4 ON evento_reposicao;
DROP TRIGGER IF EXISTS ri_5 ON evento_reposicao;

CREATE OR REPLACE FUNCTION ri_1_proc()
RETURNS TRIGGER
AS $$
DECLARE
	cat_original VARCHAR(255);
	cat VARCHAR(255);
	super_cat VARCHAR(255);
	contador INT;
BEGIN
	cat_original = new.nome_categoria;
	cat = new.nome_categoria;
	super_cat = new.nome_super_categoria;
	contador = 1;

	WHILE contador <> 0 LOOP
		IF (SELECT nome_super_categoria FROM tem_outra WHERE nome_categoria = super_cat) = cat_original THEN
			RAISE EXCEPTION	'Uma categoria não pode estar contida em si própria.';
		END IF;

		cat = super_cat;

		SELECT nome_super_categoria INTO super_cat
		FROM tem_outra
		WHERE nome_categoria = cat;

		SELECT COUNT(distinct nome_super_categoria) INTO contador
		FROM tem_outra
		WHERE nome_categoria = cat;

	END LOOP;

	RETURN NEW;
END
$$
LANGUAGE plpgsql;

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

CREATE TRIGGER ri_1_insert
BEFORE INSERT ON tem_outra
FOR EACH ROW EXECUTE PROCEDURE ri_1_proc();

CREATE TRIGGER ri_1_update
BEFORE UPDATE ON tem_outra
FOR EACH ROW EXECUTE PROCEDURE ri_1_proc();

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
