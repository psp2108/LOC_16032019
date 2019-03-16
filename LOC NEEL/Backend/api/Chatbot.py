# [------------------------------------START IMPORTING LIBRARIES--------------------------------------]
import argparse
import uuid
import os
import dialogflow
import json
import pyexcel as p
from googletrans import Translator
# [---------------------------------------END IMPORTING LIBRARIES-------------------------------------]

# [--------------------------------START DIALOGFLOW - DETECT INTENTION--------------------------------]

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
# [----------------------------------END DIALOGFLOW - DETECT INTENTION--------------------------------]

# [--------------------------------START DIALOGFLOW CHATBOT ACCESS------------------------------------]

def Neel_Bot(secret_key,botName,sessionID,question):
    #Set the client secret key of the Service Account
    #os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = u""+secret_key+""
    
    #Convert the http encoded question to normal string
    question=question.replace("+"," ")
    question=question.replace("%3F","?")

    #Converting to english
    #translator = Translator(service_urls=['translate.google.com'])
    #convertedPlaintext = translator.translate([question], dest='en')

    #Send the question to DialogFlow Client
    #answer=detect_intent_texts(botName, sessionID, [convertedPlaintext[0].text], u"0")
    answer=detect_intent_texts(botName, sessionID, [question], u"0")
    print("Parameters Received:\n secret={}\n botName={}\n sessionID={}\n question={}".format(secret_key,botName,sessionID,question))
    print("Answer Received:\n {}".format(answer))
    return answer

# [--------------------------------START DIALOGFLOW CHATBOT ACCESS------------------------------------]
