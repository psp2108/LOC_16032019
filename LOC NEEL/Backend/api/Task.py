from flask_restful import Resource
import logging as logger

class Task(Resource):

	def get(self,name,age):
		logger.debug("Inside GET method of Task")
		return {"message":"Inside GET method of Task","name":name,"age":age},200
	
	def post(self,name,age):
		logger.debug("Inside POST method of Task")
		return {"message":"Inside POST method of Task","name":name,"age":age},200
	
	def put(self,name,age):
		logger.debug("Inside PUT method of Task")
		return {"message":"Inside PUT method of Task","name":name,"age":age},200

	def delete(self,name,age):
		logger.debug("Inside DELETE method of Task")
		return {"message":"Inside DELETE method of Task","name":name,"age":age},200
