from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger
import procs

class Home(Resource):

	def get(self):
		logger.debug("In GET part of Caste")
		
		s = {
            '1' : '/api/v1/task',
            '2' : '/api/v1/login',
            '3' : '/api/v1/register',
            '4' : '/api/v1/Profile',
            '5' : '/api/v1/GetProfile/<string:uname>',
            '6' : '/api/v1/HelpMeBot/Q/<string:question>/id/<int:UserId>',
            '7' : '/api/v1/Scholarship',
            '8' : '/api/v1/GetScholarship/<string:sid>',
            '9' : '/api/v1/ViewScholarship/<string:oid>',
            '10' : '/api/v1/ScholarShipDetails/<string:sid>',
            '11' : '/api/v1/verifyScholarship',
            '12' : '/api/v1/verifyStudentProfile',
            '13' : '/api/v1/MatchAptScholarship/<int:uname>',
            '14' : '/api/v1/skills',
            '15' : '/api/v1/scholarship_category',
            '16' : '/api/v1/qualification',
            '17' : '/api/v1/hobby',
            '18' : '/api/v1/event',
            '19' : '/api/v1/course',
            '20' : '/api/v1/city',
            '21' : '/api/v1/caste',
            '22' : '/api/v1/SendEmail',
        }
		return s,200