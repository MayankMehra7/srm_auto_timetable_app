import firebase_admin
from firebase_admin import credentials, messaging
import os

def main(context):
    key = eval(os.environ['KEY'])
    if 'timetable_app' not in firebase_admin._apps:
        cred = credentials.Certificate(key)
        firebase_admin.initialize_app(cred, name='timetable_app')
    context.log(key)
    if (context.req.path == "/"):
        return context.res.json({"msg": "working, use /subscribe to register users"})
    if (context.req.path == "/subscribe"):
        token = context.req.query['token']
        context.log(token)
        response = messaging.subscribe_to_topic(token, "timetable")
        context.log(response.success_count, 'tokens were subscribed successfully')
        return context.res.json({"msg": "success"}, 200)
    return context.res.json({"msg": "invalid path"}, 400)


