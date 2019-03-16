from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger

class Register(Resource):

	def post(self):
		#Create parameters
		parser = reqparse.RequestParser()
		parser.add_argument('username')
		parser.add_argument('name')
		parser.add_argument('type')
		parser.add_argument('gender')
		parser.add_argument('email')
		parser.add_argument('phone')
		parser.add_argument('password')

		#Logging request occurance
		logger.debug("Inside the POST Register Method ")

		#Get parameters as POST parameters
		args = parser.parse_args()

		#Fetch Parameters
		user = {}
		user["un"] = args['username']
		user["pw"] = args['password']
		user["name"] = args['name']
		user["typeName"] = args['type']
		user["gender"] = args['gender']
		user["email"] = args['email']
		user["phone"] = args['phone']

		#Call Pratiks Method
		dbResponse = registerDB(user)
		if(dbResponse["status"]):
			response = dbResponse
		else:
			response = dbResponse
		return response,200

def registerDB(user):
	# form Dict
	dbRequest = {}
	dbRequest["status"] = False
	dbRequest["uid"] = user["un"]
	dbRequest["name"] = user["name"]
	dbRequest["typeName"] = user["typeName"]
	dbRequest["gender"] = user["gender"]
	dbRequest["email"] = user["email"]
	dbRequest["phone"] = user["phone"]
	dbRequest["pw"] = user["pw"]

	# insert to DB & change status
	if(user["typeName"] == "Student"):
		#SQL Query for Student
		pass
	elif(user["typeName"] == "Org"):
		#SQL Query for Org
		pass
	return dbRequest

#----------------------------------------------------

#Get Parameters & Parse JSON
#json_data = request.get_json(force=True)
       
#Extract Vaues
#un = json_data['username']
#pw = json_data['password']