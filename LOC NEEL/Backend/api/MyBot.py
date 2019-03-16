from Chatbot import *

service_key_path = ""
chatbot_name = ""
question = ""
sessionID = ""

#Set the client secret key of the Service Account
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = u"{PATH}"    

if __name__ == "__main__":
    answer = Neel_Bot(service_key_path, chatbot_name, sessionID, question
    print(answer)
