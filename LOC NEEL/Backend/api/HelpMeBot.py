# [------------------------------------START IMPORTING LIBRARIES--------------------------------------]
import argparse
import uuid
import os
import dialogflow
import json
import pyexcel as p
from googletrans import Translator
from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger
# [---------------------------------------END IMPORTING LIBRARIES-------------------------------------]

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = u"E:/Project/LOC 2019/LOC_16032019/LOC NEEL/Backend/api/HelpMeBot_Secret.json"

class HelpMeBot(Resource):
	def get(self,question,UserId):
		question = question.replace("-", " ")
		answer = getAnswer(question,UserId)
		if(answer!=""):
			response = {"status":True, "answer":answer}
		else:
			response = {"status":False, "answer":""}
		return response,200
	
def getAnswer(question,UserId):
	chatbot_name = "HelpMeBot"
	project_id = "helpmebot-ebf82"
	UserQuestion = question
	sessionID = UserId
	answer = Neel_Bot(project_id, sessionID, UserQuestion)
	return answer

def detect_intent_texts(project_id, session_id, texts, language_code):
    """Returns the result of detect intent with texts as inputs.
    Using the same `session_id` between requests allows continuation
    of the conversaion."""
    session_client = dialogflow.SessionsClient()

    session = session_client.session_path(project_id, session_id)
    f = open("SessionPath.txt","a+")
    f.write("Session Path :: {}\n".format(session))
    f.close
    for text in texts:
        text_input = dialogflow.types.TextInput(text=text, language_code=language_code)
        query_input = dialogflow.types.QueryInput(text=text_input)
        response = session_client.detect_intent(session=session, query_input=query_input)

        return response.query_result.fulfillment_text

def Neel_Bot(botName,sessionID,question):
    #Converting to english
    #translator = Translator(service_urls=['translate.google.com'])
    #convertedPlaintext = translator.translate([question], dest='en')
	answer=detect_intent_texts(botName, sessionID, [question], u"0")
	return answer
