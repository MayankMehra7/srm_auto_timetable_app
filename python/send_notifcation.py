import firebase_admin
from firebase_admin import credentials, messaging

cred = credentials.Certificate("python\key.json")
firebase_admin.initialize_app(cred)
message = messaging.Message(
    data={"index": "1", "dayOrder": "Day 1"},
    topic="timetable",
)
response = messaging.send(message)
print(response)