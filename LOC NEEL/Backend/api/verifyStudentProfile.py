from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger

class verifyStudentProfile(Resource):

	def get():
		logger.debug("In GET verify Student Profile")
		response = "To create verify Student Profile POST request"
		return response,200
	
	def post(self):
		logger.debug("Inside the POST verify Student Profile Creation Method ")
		parser = reqparse.RequestParser()
		parser.add_argument('uname')
		parser.add_argument('v_status')

		#Get parameters as POST parameters
		args = parser.parse_args()
			
		sid = args["uname"]
		v_status = args["v_status"]

		#Call Pratiks Method
		response = verifyScholarshipDB(sid,v_status)
		return response,200
	
def verifyScholarshipDB(uname,v_status):
	#SQL Query: dbResponse=Query
	dbResponse = {}
	dbResponse["uname"] = uname
	dbResponse["v_status"] = v_status
	return dbResponse