from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger

class GetScholarship(Resource):

	def get(self,sid):
		logger.debug("In GET part of Scholarship")
		
		#Call Pratiks Method
		response = getScholarshipFromDB(sid)
		return response,200
	
def getScholarshipFromDB(sid):
	#SQL Query: dbResponse=Query
	dbResponse = sid
	return dbResponse