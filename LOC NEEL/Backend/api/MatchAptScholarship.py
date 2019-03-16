from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger
import test

class MatchAptScholarship(Resource):
	def get(self,uname):
		logger.debug("In GET Apt Scholarship")
		t = test.Test()
		logger.debug(t.printSomething())
		#Call Pratiks Method
		response = getAptScholarshipFromDB(uname)
		return response,200
	
def getAptScholarshipFromDB(uname):
	#SQL Query: dbResponse=Query
	dbResponse = {}
	dbResponse["name"] = uname
	return dbResponse