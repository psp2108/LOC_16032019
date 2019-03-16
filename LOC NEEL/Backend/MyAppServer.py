from flask import Flask
import logging as logger
from flask_cors import CORS
logger.basicConfig(level="DEBUG")

flaskAppInstance = Flask(__name__)
CORS(flaskAppInstance)
flaskAppInstance.secret_key = 'ABCDEFGH'

if __name__ == '__main__':
	logger.debug("Starting the app")
	from api import *
	flaskAppInstance.run(host="0.0.0.0", port=5000, debug=True, use_reloader=True)
