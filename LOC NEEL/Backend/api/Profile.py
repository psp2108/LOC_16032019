from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger
import procs

class Profile(Resource):

	def get(uname):
		logger.debug("In GET payment profile to browser")
		response = "To create account use POST request"
		return response,200
	
	def post(self):
		logger.debug("Inside the POST Profile Creation Method ")
		parser = reqparse.RequestParser()
		parser.add_argument('uid')
		parser.add_argument('name')
		parser.add_argument('age')
		parser.add_argument('gender')
		parser.add_argument('pd')
		parser.add_argument('course')
		parser.add_argument('total_h')
		parser.add_argument('total_s')
		parser.add_argument('adhar')
		parser.add_argument('city')
		parser.add_argument('caste')
		parser.add_argument('caste_cert')
		parser.add_argument('resume')
		parser.add_argument('annual_income')
		parser.add_argument('income_cert_no')
		parser.add_argument('dob')
		parser.add_argument('status')
		parser.add_argument('skills')
		parser.add_argument('hobby')

		#Get parameters as POST parameters
		args = parser.parse_args()
		
		#Prepare profile Data Dict
		profileData = {}
		profileData['uid'] = args['uid']
		profileData['name'] = args['name']
		profileData['age'] = args['age']
		profileData['gender'] = args['gender']
		profileData['pd'] = args['pd']
		profileData['course'] = args['course']
		profileData['adhar'] = args['adhar']
		profileData['city'] = args['city']
		profileData['caste'] = args['caste']
		profileData['caste_cert'] = args['caste_cert']
		profileData['resume'] = args['resume']
		profileData['income_cert_no'] = args['income_cert_no']
		profileData['annual_income'] = args['annual_income']
		profileData['dob'] = args['dob']


		#Call Pratiks Method
		response = procs.createUpdateStudentProfile(profileData)
		return response,200
	
# def createProfile(StudentProfileData):
# 	#SQL Query: dbResponse=Query
# 	dbResponse = StudentProfileData
# 	return dbResponse

#Get Parameters & Parse JSON
#json_data = request.get_json(force=True)
       
#Extract Vaues
#un = json_data['username']
#pw = json_data['password']