from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger

class verifyScholarship(Resource):

	def get():
		logger.debug("In GET verify Scholarship")
		response = "To create verify Scholarship use POST request"
		return response,200
	
	def post(self):
		logger.debug("Inside the POST Scholarship Creation Method ")
		parser = reqparse.RequestParser()
		parser.add_argument('sid')
		parser.add_argument('v_status')

		#Get parameters as POST parameters
		args = parser.parse_args()
			
		sid = args["sid"]
		v_status = args["v_status"]

		#Call Pratiks Method
		response = verifyScholarshipDB(sid,v_status)
		return response,200
	
def verifyScholarshipDB(sid,v_status):
	#SQL Query: dbResponse=Query
	dbResponse = {}
	dbResponse["sid"] = sid
	dbResponse["v_status"] = v_status
	return dbResponse