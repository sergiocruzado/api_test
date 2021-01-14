from flask import Flask, json, request
import logging
import sys
import socket
from datetime import date
import sqlite3

api_version='v1.0.0'

logging.basicConfig(filename='./app.log', filemode='w', format='%(name)s - %(levelname)s - %(message)s', level=logging.INFO)

api = Flask(__name__)

logging.info('Creating in memory DB') 
conn = sqlite3.connect(':memory:')
logging.info('In memory DB created') 
cursor = conn.cursor()

# Create a table in the in-memory database
logging.info('Create table users') 
sql = """ CREATE TABLE users(
            id INTEGER PRIMARY KEY, 
            name varchar(32) NOT NULL, 
            surname varchar(32) NOT NULL)
"""

cursor.execute(sql)
cursor.execute("select * from SQLite_master where type=\"table\"")
tables = cursor.fetchall()
logging.info('Table users created') 

def db_connection():
    conn = None
    try:
      conn = sqlite3.connect(':memory:')
    except sqlite3.error as e:
      print(e)
    return conn

@api.route('/version', methods=['GET'])
def version():
  data={}
  data['version']=api_version
  logging.info('API ' + api_version+ ' GET: /version') 
  return json.dumps(data)

@api.route('/health', methods=['GET'])
def health():
  data={}
  data['status']="running"
  logging.info('API ' + api_version+ ' GET: /health') 
  return json.dumps(data)

@api.route('/user', methods=['GET'])
def get_users():
  logging.info('API ' + api_version+ ' GET: /user') 
  data={}

  try:
    cursor = conn.cursor()
    cursor.execute("SELECT *  FROM users")
    r = [dict((cursor.description[i][0], value) for i, value in enumerate(row)) for row in cursor.fetchall()]
  except Exception as e:
    print(e)
    data = {}
    data['message'] = "internal error"
    return json.dumps(data), 500

  return json.dumps(r)

@api.route('/user', methods=['POST'])
def save_user():
  logging.info('API ' + api_version+ ' POST: /user') 

  if not request.content_type == 'application/json':
      data = {}
      data['message'] = "content type not allowed. Only application/json"
      return json.dumps(data), 400

  data = request.get_json()

  if data is None or data == {}:
      data = {}
      data['message'] = "empty data"
      return json.dumps(data), 400
  
  name = data['name']
  surname = data['surname']
  sql = """INSERT INTO users (name, surname)
                VALUES (?,?)"""
  try:
    cursor = conn.cursor()
    cursor = cursor.execute(sql, (name, surname))
    conn.commit()

    response = {}
    data['id'] = cursor.lastrowid
    data['name'] = name
    data['surname'] = surname
  except Exception as e:
    print(e)
    data = {}
    data['message'] = "internal error"
    return json.dumps(data), 500

  return json.dumps(data), 201

@api.route('/user/<int:id>', methods=['GET', 'DELETE' ])
def user(id):
  user_id = str(id)
  logging.info('API ' + api_version + ' ' + request.method + ': /user/' + user_id) 

  try:
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM users WHERE id=?", (user_id,))
    # fechall( method -> [(1, 'sergio', 'cruzado')])
    r = [dict((cursor.description[i][0], value) for i, value in enumerate(row)) for row in cursor.fetchall()]
  except Exception as e:
    print(e)
    data = {}
    data['message'] = "internal error"
    return json.dumps(data), 500

  if len(r) == 0:
    data = {}
    data['message'] = "not found"
    return json.dumps(data), 404 
  
  if request.method == "DELETE":
    sql  = """ DELETE FROM users WHERE id=? """
    conn.execute(sql, (id,))
    conn.commit()

  return json.dumps(r)



if __name__ == '__main__':
    api.run(host='0.0.0.0')