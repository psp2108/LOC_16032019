from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger
import procs

class ScholarShipDetails(Resource):

	def get(self,sid):
		logger.debug("In GET part of ScholarShipDetails")
		
		#Call Pratiks Method
		response = procs.get_scholarship(sid)
		return response,200
	