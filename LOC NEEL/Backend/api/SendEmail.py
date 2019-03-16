from flask_restful import Resource
from flask_restful import reqparse, abort, Api, Resource
import logging as logger
import urllib.request
import urllib.parse
import smtplib
import random as r

class SendEmail(Resource):

    def post(self):
        logger.debug("In GET part of send OTP")
        parser = reqparse.RequestParser()
        parser.add_argument('email')
        args = parser.parse_args()

        otp = str(r.randint(10000, 99999))
        email = args['email']
        subject = "Testing the Scholarship Portal"
        body = "Your OTP is:: "+otp
        emailRes = send_email("yash.chanchad123@gmail.com", "loclinesofcode111", [email], subject, body)
        emailResponseStatus = {}
        emailResponseStatus["status"] = emailRes
        emailResponseStatus["OTP"] = otp
        return emailResponseStatus
  
def send_email(user, pwd, recipient, subject, body):
    FROM = user
    TO = recipient if isinstance(recipient, list) else [recipient]
    SUBJECT = subject
    TEXT = body

    # Prepare actual message
    message = """From: %s\nTo: %s\nSubject: %s\n\n%s
    """ % (FROM, ", ".join(TO), SUBJECT, TEXT)
    try:
        server = smtplib.SMTP("smtp.gmail.com", 587)
        server.ehlo()
        server.starttls()
        server.login(user, pwd)
        server.sendmail(FROM, TO, message)
        server.close()
        logger.debug('successfully sent the mail')
        return "1"
    except Exception as e: 
        logger.debug(e)
        return "0"

