from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger
import procs

class ScholarsCategory(Resource):

	def get(self):
		logger.debug("In GET part of ScholarsCategory")
		
		#Call Pratiks Method
		response = procs.get_scholarship_category()
		return response,200
	