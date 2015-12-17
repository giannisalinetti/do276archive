from flask import Flask, jsonify
from flask import g
from flask import Response
from flask import request
from flask import abort
from flask import render_template
import json
import mysql.connector
import os
from mysql.connector import errorcode

app = Flask(__name__)


@app.before_request
def db_connect():
    try:
        g.cnx = mysql.connector.connect(user=os.environ.get("MYSQL_DB_USERNAME", 'root'),
                                        password=os.environ.get("MYSQL_DB_PASSWORD", ''),
                                        host=os.environ.get("MYSQL_DB_HOST", '127.0.0.1'),
                                        port=os.environ.get("MYSQL_DB_PORT", '3306'),
                                        database=os.environ.get("MYSQL_DB_NAME",'todo'))
        g.cursor = g.cnx.cursor()
    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("Something is wrong with your user name or password")
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("Database does not exist")
        else:
            print(err)
    else:
        print("Database connected fine")


@app.after_request
def db_disconnect(response):
    response.headers.add('Access-Control-Allow-Origin', '*')
    response.headers.add('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type')
    response.headers.add('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS')
    g.cursor.close()
    g.cnx.close()
    return response


def query_db(query, args=(), one=False):
    g.cursor.execute(query, args)
    rv = [dict((g.cursor.description[idx][0], value)
               for idx, value in enumerate(row)) for row in g.cursor.fetchall()]
    return (rv[0] if rv else None) if one else rv


def count_items():
    query = "SELECT COUNT(*) FROM todo.Item"
    g.cursor.execute(query)
    data = g.cursor.fetchone()[0]
    return data


def find_items(start_position, max_results, sort_fields, sort_directions):
    query = "SELECT * FROM todo.Item ORDER BY todo.Item." + sort_fields + " " + sort_directions + " limit " + \
            str(start_position) + "," + str(max_results)

    result = query_db(query)
    return result


@app.route("/todo", methods=['GET', 'POST'])
def index():
    return render_template("index.html")


@app.route("/", methods=['GET', 'POST'])
def hello():
    return render_template("hello.html")


@app.route("/todo/api/items", methods=['GET'])
def list_items():
    page_size = 10
    page = request.args.get('page')
    if page is None:
        page = 1
    sort_fields = request.args.get('sortFields')
    sort_directions = request.args.get('sortDirections')
    start = (int(page) - 1) * page_size
    result = find_items(start, page_size, sort_fields, sort_directions)
    full_response = ({
        "currentPage": page,
        "list": result,
        "pageSize": page_size,
        "sortDirections": sort_directions,
        "sortFields": sort_fields,
        "totalResults": count_items()
    })
    json_resp = json.dumps(full_response)
    print(json_resp)
    return Response(json_resp, status=200, mimetype='application/json')


@app.route("/todo/api/items/<id>", methods=['DELETE'])
def delete_item(id):
    query = "DELETE FROM todo.Item WHERE todo.Item.id = " + id
    g.cursor.execute(query)
    g.cnx.commit()
    resp = Response("Deleted", status=200, mimetype='application/json')
    return resp


@app.route("/todo/api/items/<id>", methods=['GET'])
def get_item(id):
    result = query_db("SELECT * FROM todo.Item WHERE todo.Item.id = " + id)
    dict = result[0]
    if dict['done']:
        dict['done'] = True
    else:
        dict['done'] = False
    data = json.dumps(dict)
    resp = Response(data, status=200, mimetype='application/json')
    return resp


@app.route("/todo/api/items", methods=['POST'])
def save_item():
    the_request = request.get_json(force=True)
    if not the_request:
        abort(400)
    item = {
        'id': the_request.get('id', ""),
        'description': the_request.get('description', ""),
        'done': the_request.get('done', "")
    }

    if not item.get('id', ""):
        query = "INSERT INTO todo.Item(description, done) VALUES(%s,%s)"
    else:
        query = "UPDATE todo.Item SET description = %s, done = %s WHERE todo.Item.id = " + str(item.get('id', ""))
    args = (item.get('description', ""), item.get('done', ""))
    g.cursor.execute(query, args)
    g.cnx.commit()
    data = json.dumps(item)
    resp = Response(data, status=201, mimetype='application/json')
    return resp


if __name__ == "__main__":
    port = int(os.environ.get('PORT', 30080))
    app.run(port=port)