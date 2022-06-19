def categoria():
	categoria = [
	    line.strip().split(",") for line in open("categoria.csv", "r")
	]
	for nome in categoria:
		ins = "INSERT INTO categoria VALUES ('{}');\n".format(nome[0])
		file.write(ins)


def categoria_simples():
	categoria_simples = [
	    line.strip().split(",") for line in open("categoria_simples.csv", "r")
	]
	for nome in categoria_simples:
		ins = "INSERT INTO categoria_simples VALUES ('{}');\n".format(nome[0])
		file.write(ins)


def super_categoria():
	super_categoria = [
	    line.strip().split(",") for line in open("super_categoria.csv", "r")
	]
	for nome in super_categoria:
		ins = "INSERT INTO super_categoria VALUES ('{}');\n".format(nome[0])
		file.write(ins)


def tem_outra():
	tem_outra = [
	    line.strip().split(",") for line in open("tem_outra.csv", "r")
	]
	for nome_super_categoria, nome_categoria in tem_outra:
		ins = "INSERT INTO tem_outra VALUES ('{}', '{}');\n".format(
		    nome_super_categoria, nome_categoria)
		file.write(ins)


def produto():
	produto = [line.strip().split(",") for line in open("produto.csv", "r")]
	for ean, cat, descr in produto:
		ins = "INSERT INTO produto VALUES ('{}', '{}', '{}');\n".format(
		    ean, cat, descr)
		file.write(ins)


def tem_categoria():
	tem_categoria = [
	    line.strip().split(",") for line in open("tem_categoria.csv", "r")
	]
	for ean, nome in tem_categoria:
		ins = "INSERT INTO tem_categoria VALUES ('{}', '{}');\n".format(
		    ean, nome)
		file.write(ins)


def ivm():
	ivm = [line.strip().split(",") for line in open("ivm.csv", "r")]
	for fabricante in ivm:
		ins = "INSERT INTO ivm (fabricante) VALUES ('{}');\n".format(fabricante[0])
		file.write(ins)


def ponto_de_retalho():
	ponto_de_retalho = [
	    line.strip().split(",") for line in open("ponto_de_retalho.csv", "r")
	]
	for nome, distrito, concelho in ponto_de_retalho:
		ins = "INSERT INTO ponto_de_retalho VALUES ('{}', '{}', '{}');\n".format(
		    nome, distrito, concelho)
		file.write(ins)


def instalada_em():
	instalada_em = [
	    line.strip().split(",") for line in open("instalada_em.csv", "r")
	]
	for num_serie, fabricante, local in instalada_em:
		ins = "INSERT INTO instalada_em VALUES ('{}', '{}', '{}');\n".format(
		    num_serie, fabricante, local)
		file.write(ins)


def prateleira():
	prateleira = [
	    line.strip().split(",") for line in open("prateleira.csv", "r")
	]
	for nro, num_serie, fabricante, altura, nome in prateleira:
		ins = "INSERT INTO prateleira VALUES ('{}', '{}', '{}', '{}', '{}');\n".format(
		    nro, num_serie, fabricante, altura, nome)
		file.write(ins)


def planograma():
	planograma = [
	    line.strip().split(",") for line in open("planograma.csv", "r")
	]
	for ean, nro, num_serie, fabricante, faces, unidades, loc in planograma:
		ins = "INSERT INTO planograma VALUES ('{}', '{}', '{}', '{}', '{}', '{}', '{}');\n".format(
		    ean, nro, num_serie, fabricante, faces, unidades, loc)
		file.write(ins)


def retalhista():
	retalhista = [
	    line.strip().split(",") for line in open("retalhista.csv", "r")
	]
	for name in retalhista:
		ins = "INSERT INTO retalhista (name) VALUES ('{}');\n".format(name[0])
		file.write(ins)


def responsavel_por():
	responsavel_por = [
	    line.strip().split(",") for line in open("responsavel_por.csv", "r")
	]
	for nome_cat, tin, num_serie, fabricante in responsavel_por:
		ins = "INSERT INTO responsavel_por VALUES ('{}', '{}', '{}', '{}');\n".format(
		    nome_cat, tin, num_serie, fabricante)
		file.write(ins)


def evento_reposicao():
	evento_reposicao = [
	    line.strip().split(",") for line in open("evento_reposicao.csv", "r")
	]
	for ean, nro, num_serie, fabricante, instante, unidades, tin in evento_reposicao:
		ins = "INSERT INTO evento_reposicao VALUES ('{}', '{}', '{}', '{}', '{}', '{}', '{}');\n".format(
		    ean, nro, num_serie, fabricante, instante, unidades, tin)
		file.write(ins)


if __name__ == "__main__":
	file = open('../new_populate.sql', 'w')

	categoria()
	file.write('\n')
	super_categoria()
	file.write('\n')
	categoria_simples()
	file.write('\n')
	produto()
	file.write('\n')
	retalhista()
	file.write('\n')
	ivm()
	file.write('\n')
	prateleira()
	file.write('\n')
	ponto_de_retalho()
	file.write('\n')
	planograma()
	file.write('\n')
	instalada_em()
	file.write('\n')
	tem_categoria()
	file.write('\n')
	tem_outra()
	file.write('\n')
	evento_reposicao()
	file.write('\n')
	responsavel_por()

	file.close()
