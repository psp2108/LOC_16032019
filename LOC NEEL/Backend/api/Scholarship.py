from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger

class Scholarship(Resource):

	def get():
		logger.debug("In GET part of Scholarship")
		response = "To create Scholarship use POST request"
		return response,200
	
	def post(self):
		logger.debug("Inside the POST Scholarship Creation Method ")
		parser = reqparse.RequestParser()
		parser.add_argument('category')
		parser.add_argument('name')
		parser.add_argument('date')
		parser.add_argument('url')
		parser.add_argument('annualIncome')
		parser.add_argument('caste')
		parser.add_argument('qual')
		parser.add_argument('score')
		parser.add_argument('course')
		parser.add_argument('event')

		#Get parameters as POST parameters
		args = parser.parse_args()
		
		#Prepare profile Data Dict
		scholarshipData = {}
		#profileData['id'] = args['id']
		scholarshipData['category'] = args['category']
		scholarshipData['name'] = args['name']
		scholarshipData['date'] = args['date']
		scholarshipData['url'] = args['url']
		scholarshipData['annualIncome'] = args['annualIncome']
		scholarshipData['caste'] = args['caste']
		scholarshipData['qual'] = args['qual']
		scholarshipData['score'] = args['score']
		scholarshipData['course'] = args['course']
		scholarshipData['event'] = args['event']
		
		#Call Pratiks Method
		response = createScholarship(scholarshipData)
		return response,200
	
def createScholarship(scholarshipData):
	#SQL Query: dbResponse=Query
	dbResponse = scholarshipData
	return dbResponse