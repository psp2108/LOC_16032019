from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger
import procs

class GetEligibleStudents(Resource):

    def get(self, oid):
        logger.debug("In GET part of GetEligibleStudents")

        #Call Pratiks Method
        response = procs.get_eligible_students(oid)
        return response,200
        # return ("Hii" + oid)
	