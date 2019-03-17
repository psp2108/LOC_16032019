from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger
import procs

class Skills(Resource):

	def get(self):
		logger.debug("In GET part of Skills")
		
		#Call Pratiks Method
		response = procs.get_skills()
		return response,200
	