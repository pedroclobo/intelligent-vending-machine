#!/usr/bin/python3

from wsgiref.handlers import CGIHandler
from flask import Flask
from flask import render_template, request
import psycopg2
import psycopg2.extras

from auth import DB_USER, DB_PASSWORD

## SGBD configs
DB_HOST = "db.tecnico.ulisboa.pt"
DB_DATABASE = DB_USER
DB_CONNECTION_STRING = "host=%s dbname=%s user=%s password=%s" % (
    DB_HOST, DB_DATABASE, DB_USER, DB_PASSWORD)

app = Flask(__name__)


@app.route('/')
def menu_principal():
	try:
		return render_template("menu.html")
	except Exception as e:
		return str(e)


@app.route('/adicionar_categoria')
def menu_adicionar_categoria():
	try:
		return render_template("adicionar_categoria.html", params=request.args)
	except Exception as e:
		return str(e)


@app.route('/adicionar_categoria/update', methods=["POST"])
def adicionar_categoria():
	dbConn = None
	cursor = None
	try:
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
		nome = request.form.get("nome")
		tipo = request.form.get("tipo")

		query = "START TRANSACTION; INSERT INTO categoria VALUES (%s); "

		if tipo == "categoria_simples":
			query += "INSERT INTO categoria_simples VALUES (%s); "
		elif tipo == "super_categoria":
			query += "INSERT INTO super_categoria VALUES (%s); "

		query += "COMMIT;"

		data = (nome, nome)
		cursor.execute(query, data)
		return query
	except Exception as e:
		return str(e)
	finally:
		dbConn.commit()
		cursor.close()
		dbConn.close()


@app.route('/remover_categoria')
def menu_remover_categoria():
	dbConn = None
	cursor = None
	try:
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
		query = "SELECT * FROM categoria;"
		cursor.execute(query)
		return render_template("remover_categoria.html", cursor=cursor)
	except Exception as e:
		return str(e)
	finally:
		cursor.close()
		dbConn.close()


@app.route('/remover_categoria/update')
def remover_categoria():
	dbConn = None
	cursor = None
	try:
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
		nome = request.args.get("nome")
		query = "DELETE FROM categoria WHERE nome = %s;"
		data = (nome, )
		cursor.execute(query, data)
		return query
	except Exception as e:
		return str(e)
	finally:
		dbConn.commit()
		cursor.close()
		dbConn.close()


@app.route('/adicionar_sub_categoria')
def menu_adicionar_sub_categoria():
	dbConn = None
	cursor_cat = None
	cursor_sup = None
	try:
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor_cat = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
		cursor_sup = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
		query_cat = "SELECT nome FROM categoria;"
		query_sup = "SELECT nome FROM super_categoria;"
		cursor_cat.execute(query_cat)
		cursor_sup.execute(query_sup)
		return render_template("adicionar_sub_categoria.html",
		                       cursor=(cursor_cat, cursor_sup))
	except Exception as e:
		return str(e)
	finally:
		cursor_cat.close()
		cursor_sup.close()
		dbConn.close()


@app.route('/adicionar_sub_categoria/update', methods=["POST"])
def adicionar_sub_categoria():
	dbConn = None
	cursor = None
	try:
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
		sup = request.form["sup"]
		sub = request.form["sub"]
		query = "INSERT INTO tem_outra VALUES (%s, %s);"
		data = (sup, sub)
		cursor.execute(query, data)
		return query
	except Exception as e:
		return str(e)
	finally:
		dbConn.commit()
		cursor.close()
		dbConn.close()


@app.route('/remover_sub_categoria')
def menu_remover_sub_categoria():
	dbConn = None
	cursor = None
	try:
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
		query = "SELECT * FROM tem_outra;"
		cursor.execute(query)
		return render_template("remover_sub_categoria.html", cursor=cursor)
	except Exception as e:
		return str(e)
	finally:
		cursor.close()
		dbConn.close()


@app.route('/remover_sub_categoria/update')
def remover_sub_categoria():
	dbConn = None
	cursor = None
	try:
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
		sup = request.args.get("sup")
		sub = request.args.get("sub")
		query = """DELETE FROM tem_outra
		WHERE nome_super_categoria = %s
			AND nome_categoria = %s;"""
		data = (sup, sub)
		cursor.execute(query, data)
		return query
	except Exception as e:
		return str(e)
	finally:
		dbConn.commit()
		cursor.close()
		dbConn.close()


@app.route('/adicionar_retalhista')
def menu_adicionar_retalhista():
	dbConn = None
	cursor = None
	try:
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
		query = """SELECT num_serie, fabricante, nome
		FROM ivm, categoria
		WHERE (num_serie, fabricante) NOT IN (
			SELECT num_serie, fabricante
			FROM responsavel_por
		)
		ORDER BY num_serie;"""
		cursor.execute(query)
		return render_template("adicionar_retalhista.html", cursor=cursor)
	except Exception as e:
		return str(e)
	finally:
		cursor.close()
		dbConn.close()


@app.route('/adicionar_retalhista/update', methods=["POST"])
def adicionar_retalhista():
	dbConn = None
	cursor = None
	try:
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
		tin = request.form.get("tin")
		nome = request.form.get("nome")
		option = request.form.getlist("option")

		data = [tin, nome]
		query = """START TRANSACTION;
		INSERT INTO retalhista VALUES (%s, %s);\n"""

		for opt in option:
			query += "INSERT INTO responsavel_por VALUES (%s, %s, %s, %s);\n"
			num_serie, fabricante, nome_cat = opt.split("_")
			data.append(nome_cat)
			data.append(tin)
			data.append(num_serie)
			data.append(fabricante)

		query += "COMMIT;"
		cursor.execute(query, data)
		return query
	except Exception as e:
		return str(e)
	finally:
		dbConn.commit()
		cursor.close()
		dbConn.close()


@app.route('/remover_retalhista')
def menu_remover_retalhista():
	dbConn = None
	cursor = None
	try:
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
		query = "SELECT * FROM retalhista;"
		cursor.execute(query)
		return render_template("remover_retalhista.html", cursor=cursor)
	except Exception as e:
		return str(e)
	finally:
		cursor.close()
		dbConn.close()


@app.route('/remover_retalhista/update')
def remover_retalhista():
	dbConn = None
	cursor = None
	try:
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
		tin = request.args.get("tin")
		query = """DELETE FROM retalhista
		WHERE tin = %s;"""
		data = (tin, )
		cursor.execute(query, data)
		return query
	except Exception as e:
		return str(e)
	finally:
		dbConn.commit()
		cursor.close()
		dbConn.close()


@app.route('/eventos_reposicao')
def menu_eventos_reposicao():
	dbConn = None
	cursor = None
	try:
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
		query = "SELECT * FROM ivm;"
		cursor.execute(query)
		return render_template("listar_ivm.html", cursor=cursor)
	except Exception as e:
		return str(e)
	finally:
		cursor.close()
		dbConn.close()


@app.route('/eventos_reposicao/update')
def eventos_reposicao():
	dbConn = None
	cursor = None
	try:
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
		num_serie = request.args.get("num_serie")
		query = """SELECT nome, SUM(unidades)
		FROM evento_reposicao NATURAL JOIN prateleira
		WHERE num_serie = %s
		GROUP BY nome;"""
		data = (num_serie, )
		cursor.execute(query, data)
		return render_template("listar_evento_reposicao.html", cursor=cursor)
	except Exception as e:
		return str(e)
	finally:
		dbConn.commit()
		cursor.close()
		dbConn.close()


@app.route('/sub_categorias')
def menu_sub_categorias():
	dbConn = None
	cursor = None
	try:
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
		query = "SELECT * FROM super_categoria;"
		cursor.execute(query)
		return render_template("listar_super_categoria.html", cursor=cursor)
	except Exception as e:
		return str(e)
	finally:
		cursor.close()
		dbConn.close()


@app.route('/sub_categorias/update')
def sub_categorias():
	dbConn = None
	cursor = None
	try:
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
		nome = request.args.get("nome")
		query = """WITH RECURSIVE sub_categorias AS (
			SELECT nome_categoria
			FROM tem_outra
			WHERE nome_super_categoria = %s
			UNION ALL
			SELECT tem_outra.nome_categoria
			FROM tem_outra
			JOIN sub_categorias ON
				tem_outra.nome_super_categoria = sub_categorias.nome_categoria
		)
		SELECT * FROM sub_categorias;"""
		data = (nome, )
		cursor.execute(query, data)
		return render_template("listar_sub_categoria.html", cursor=cursor)
	except Exception as e:
		return str(e)
	finally:
		dbConn.commit()
		cursor.close()
		dbConn.close()


CGIHandler().run(app)
