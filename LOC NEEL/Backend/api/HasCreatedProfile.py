from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger
import procs

class HasCreatedProfile(Resource):

	def get(self,sid):
		logger.debug("In GET part of Scholarship")
		
		#Call Pratiks Method
		response = procs.has_created_profile(sid)
		return response,200