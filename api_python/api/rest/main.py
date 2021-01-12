from flask import Flask, json
import requests
import logging
import sys
import socket
from datetime import date

api_version='v1.0.0'

logging.basicConfig(filename='./app.log', filemode='w', format='%(name)s - %(levelname)s - %(message)s', level=logging.INFO)

api = Flask(__name__)

@api.route('/version', methods=['GET'])
def get_version():
  data={}
  data['version']=api_version
  logging.info('API ' + api_version+ ' GET: /version') 
  return json.dumps(data)

@api.route('/health', methods=['GET'])
def get_health():
  message='ok'
  logging.info('API ' + api_version+ ' GET: /health') 
  return message

if __name__ == '__main__':
    api.run(host='0.0.0.0')