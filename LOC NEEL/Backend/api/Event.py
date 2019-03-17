from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger
import procs

class Event(Resource):

	def get(self):
		logger.debug("In GET part of Event")
		
		#Call Pratiks Method
		response = procs.get_event()
		return response,200
	