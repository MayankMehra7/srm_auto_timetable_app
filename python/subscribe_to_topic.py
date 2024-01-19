import firebase_admin
from firebase_admin import credentials, messaging
from .utils import key

def main(context):
    if 'timetable_app' not in firebase_admin._apps:
        cred = credentials.Certificate(key)
        firebase_admin.initialize_app(cred, name='timetable_app')
    if (context.req.path == "/subscribe"):
        token = context.req.query['token']
        response = messaging.subscribe_to_topic(token, "timetable")
        context.log(response.success_count, 'tokens were subscribed successfully')
        return context.res.json({"msg": "success"}, 200)
    return context.res.json({"msg": "invalid path"}, 400)


