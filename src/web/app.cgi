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


@app.route('/adicionar_categoria/input')
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
		nome = request.form["nome"]
		query = 'INSERT INTO categoria VALUES (%s)'
		data = (nome, )
		cursor.execute(query, data)
		return query
	except Exception as e:
		return str(e)
	finally:
		dbConn.commit()
		cursor.close()
		dbConn.close()


# TODO
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


CGIHandler().run(app)