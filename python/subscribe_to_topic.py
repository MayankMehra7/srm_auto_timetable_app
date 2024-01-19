import firebase_admin
from firebase_admin import credentials, messaging
import os

# retreive key from env
key = eval(os.environ['KEY'])

# check if app is alr initialized
try:
    app = firebase_admin.get_app()
except ValueError as e:
    cred = credentials.Certificate(key)
    firebase_admin.initialize_app(cred)

def main(context):
    if (context.req.path == "/"):
        return context.res.json({"msg": "working, use /subscribe to register users"})
    if (context.req.path == "/subscribe"):
        token = context.req.query['token']
        context.log(token)
        response = messaging.subscribe_to_topic(token, "timetable")
        context.log(response.success_count, 'tokens were subscribed successfully')
        return context.res.json({"msg": "success"}, 200)
    return context.res.json({"msg": "invalid path"}, 400)


