import firebase_admin
from firebase_admin import credentials, messaging

cred = credentials.Certificate("python\key.json")
firebase_admin.initialize_app(cred)
message = messaging.Message(
    # notification=messaging.Notification(
    #     title="Hi Roshan",
    #     body="New class"
    # ),
    data={"index": "1", "dayOrder": "Day 1"},
    android=messaging.AndroidConfig(
        priority="high"
    ),
    topic="timetable",
)
response = messaging.send(message)
print(response)