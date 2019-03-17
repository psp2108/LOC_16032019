from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger
import procs

class City(Resource):

	def get(self):
		logger.debug("In GET part of City")
		
		#Call Pratiks Method
		response = procs.get_city()
		return response,200
	