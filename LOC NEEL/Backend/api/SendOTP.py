from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger
import urllib.request
import urllib.parse
import random as r

class SendOTP(Resource):

    def get(self,phoneNo):
        logger.debug("In GET part of send OTP")
        smsResponseStatus = sendOTPtoPhone(phoneNo)
        return smsResponseStatus
        
def sendSMS(apikey, numbers, sender, message):
    params = {'apikey': apikey, 'numbers': numbers, 'message' : message, 'sender': sender}
    f = urllib.request.urlopen('https://api.textlocal.in/send/?'+ urllib.parse.urlencode(params))
    return (f.read(), f.code)

def sendOTPtoPhone(phoneNo):
    #Send the request
    
    message = 'Hi this is Neel. Your OTP is:: '+str(r.randint(1, 9))
    resp, code = sendSMS('oJNZjI40Lrc-s3L2EXFyQ6NkqXBPNjzKdbHF55TVp1', phoneNo, 'TXTLCL', message)
    logger.debug(resp)
    if(resp):
        return "1"
    else:
        return "0"

