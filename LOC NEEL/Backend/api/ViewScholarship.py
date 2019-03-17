from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger
import procs

class ViewScholarship(Resource):

	def get(self, oid):
		logger.debug("In GET part of ViewScholarship")
		
		#Call Pratiks Method
		response = procs.view_scholarships(oid)
		return response,200
	