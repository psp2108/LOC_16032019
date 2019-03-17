from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger
import procs

class Caste(Resource):

	def get(self):
		logger.debug("In GET part of Caste")
		
		#Call Pratiks Method
		response = procs.get_caste()
		return response,200
	