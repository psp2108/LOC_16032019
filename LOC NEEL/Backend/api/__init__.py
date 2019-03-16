from flask_restful import reqparse, abort, Api, Resource
from MyAppServer import flaskAppInstance
from .Task import Task
from .Login import Login
from .Register import Register
from .Profile import Profile
from .GetProfile import GetProfile
from .HelpMeBot import HelpMeBot
from .Scholarship import Scholarship
from .GetScholarship import GetScholarship
from .SendOTP import SendOTP
from .SendEmail import SendEmail
from .verifyScholarship import verifyScholarship
from .verifyStudentProfile import verifyStudentProfile
from .MatchAptScholarship import MatchAptScholarship

restServer = Api(flaskAppInstance)
restServer.add_resource(Task, "/api/v1/task")
restServer.add_resource(Login, "/api/v1/login")
restServer.add_resource(Register, "/api/v1/register")
restServer.add_resource(Profile, "/api/v1/Profile")
restServer.add_resource(GetProfile, "/api/v1/GetProfile/<string:uname>")
restServer.add_resource(HelpMeBot, "/api/v1/HelpMeBot/Q/<string:question>/id/<int:UserId>")
restServer.add_resource(Scholarship, "/api/v1/Scholarship")
restServer.add_resource(GetScholarship, "/api/v1/GetScholarship/<int:sid>")
restServer.add_resource(verifyScholarship, "/api/v1/verifyScholarship")
restServer.add_resource(verifyStudentProfile, "/api/v1/verifyStudentProfile")
restServer.add_resource(MatchAptScholarship, "/api/v1/MatchAptScholarship/<int:uname>")
