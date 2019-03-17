from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger
import procs

class Login(Resource):

	def get():
		logger.debug("Login Resource Called with GET type")
		return {"message":"Use POST Method"},300
	
	def post(self):
		parser = reqparse.RequestParser()
		parser.add_argument('username')
		parser.add_argument('password')

		logger.debug("Inside the POST Login Method ")

		#Get parameters as POST parameters
		args = parser.parse_args()

		un = args['username']
		pw = args['password']

		logger.debug("---------------------Username: "+un+"Password: "+pw)

		#Call Pratiks Method
		dbResponse = procs.check_credentials(un,pw)
		# if(dbResponse["status"]):
		# 	response = {"message":"true", "userID":str(dbResponse["userID"]), "type":dbResponse["type"]}
		# else:
		# 	response = {"message":"false", "userID":"", "type":""}
		return dbResponse,200

#Get Parameters & Parse JSON
#json_data = request.get_json(force=True)
       
#Extract Vaues
#un = json_data['username']
#pw = json_data['password']