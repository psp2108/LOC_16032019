from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger

class GetProfile(Resource):
	def get(self,uname):
		logger.debug("In GET profile")
		response = getProfileFromDB(uname)
		return response,200
	
def getProfileFromDB(uname):
	#SQL Query: dbResponse=Query
	StudentProfileData = {}
	StudentProfileData['id'] = uname
	StudentProfileData['name'] = "Neel Patel"
	StudentProfileData['age'] = 19
	StudentProfileData['pd'] = "NULL"
	StudentProfileData['course'] = "Computer Engineering"
	StudentProfileData['total_h'] = 5
	StudentProfileData['total_s'] = 6
	StudentProfileData['adhar'] = 342567184325
	StudentProfileData['city'] = "Mumbai"
	StudentProfileData['caste'] = "OBC"
	StudentProfileData['caste_cert'] = "domain.link/caste_cert"
	StudentProfileData['resume'] = "domain.link/resume"
	StudentProfileData['annual_income'] = 1000000
	StudentProfileData['income_cert_no'] = "domain.link/resume"
	StudentProfileData['dob'] = "YYYY-MM-DD"
	StudentProfileData['status'] = "P"
	return StudentProfileData

#Get Parameters & Parse JSON
#json_data = request.get_json(force=True)
       
#Extract Vaues
#un = json_data['username']
#pw = json_data['password']