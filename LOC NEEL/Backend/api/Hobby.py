from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger
import procs

class Hobby(Resource):

	def get(self):
		logger.debug("In GET part of Hobby")
		
		#Call Pratiks Method
		response = procs.get_hobby()
		return response,200
	