from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger
import procs

class Qualification(Resource):

	def get(self):
		logger.debug("In GET part of Qualification")
		
		#Call Pratiks Method
		response = procs.get_qualification()
		return response,200
	