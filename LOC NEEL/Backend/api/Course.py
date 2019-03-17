from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger
import procs

class Course(Resource):

	def get(self):
		logger.debug("In GET part of Course")
		
		#Call Pratiks Method
		response = procs.get_course()
		return response,200
	