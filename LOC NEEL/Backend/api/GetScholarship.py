from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger
import procs

class GetScholarship(Resource):

	def get(self,sid):
		logger.debug("In GET part of Scholarship")
		
		#Call Pratiks Method
		response = procs.get_eligible_scholarships(sid)
		return response,200
	