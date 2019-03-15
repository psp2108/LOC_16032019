import urllib.request
import urllib.parse
  
def sendSMS(apikey, numbers, sender, message):
    params = {'apikey': apikey, 'numbers': numbers, 'message' : message, 'sender': sender}
    f = urllib.request.urlopen('https://api.textlocal.in/send/?'
        + urllib.parse.urlencode(params))
    return (f.read(), f.code)
  
resp, code = sendSMS('oJNZjI40Lrc-s3L2EXFyQ6NkqXBPNjzKdbHF55TVp1', '918879366022','TXTLCL', 'From Pratik, Message send using python. Tell me if u get this sms.')
print (resp)