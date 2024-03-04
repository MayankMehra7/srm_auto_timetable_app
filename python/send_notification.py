import os
import datetime
from onesignal.api import default_api
import onesignal
from onesignal.model.notification import Notification

configuration = onesignal.Configuration(
	app_key = os.environ['APP_KEY'],
    user_key = os.environ['USER_KEY']
)

def getHour(context):
    year, month, day, hour, minute = datetime.datetime.now().year, datetime.datetime.now().month, datetime.datetime.now().day, datetime.datetime.now().hour, datetime.datetime.now().minute
    date = datetime.datetime(year=year, month=month, day=day, hour=hour, minute=minute)
    time_ranges = [
        datetime.datetime(year=year, month=month, day= day, hour=8, minute=30),
        datetime.datetime(year=year, month=month, day= day, hour=9, minute=20),
        datetime.datetime(year=year, month=month, day= day, hour=10, minute=10),
        datetime.datetime(year=year, month=month, day= day, hour=11, minute=00),
        datetime.datetime(year=year, month=month, day= day, hour=11, minute=50),
        datetime.datetime(year=year, month=month, day= day, hour=12, minute=00),
        datetime.datetime(year=year, month=month, day= day, hour=12, minute=50),
        datetime.datetime(year=year, month=month, day= day, hour=13, minute=40),
        datetime.datetime(year=year, month=month, day= day, hour=14, minute=30),
        datetime.datetime(year=year, month=month, day= day, hour=15, minute=20),
        datetime.datetime(year=year, month=month, day= day, hour=16, minute=10)
    ]
    if (date in time_ranges):
        hour = time_ranges.index(date) + 1
        return hour + 1
    else:
        time_ranges.append(date)
        time_ranges.sort()
        context.log(time_ranges)    
        hour = time_ranges.index(date)
        return hour

def main(context):
    day_order = day_order_data[str(datetime.datetime.now().strftime("%d-%m-%y"))]
    context.log(day_order)
    if (day_order["do"] != "nothing"):
        with onesignal.ApiClient(configuration) as api_client:
            api_instance = default_api.DefaultApi(api_client)


            # Example: send a web push notification to chrome browsers
            def createNotification():
                notification = Notification()
                notification.set_attribute('app_id', "d43f4e31-c574-4639-b7e6-76ae0e24b8d2")
                notification.set_attribute('url', 'https://srmtt.livewires.tech/#/home')
                notificationMessage = "Today's day order: " + day_order["do"] + ", Next hour: " + str(getHour(context))
                notificationPayload = dict()
                notificationPayload["en"] = notificationMessage
                notification.set_attribute('contents', notificationPayload)
                notification.set_attribute('is_any_web', True)
                notification.set_attribute('included_segments', ['All'])
                return notification
        
            # create a notification instance
            notification = createNotification()
            # send notification
            notificationResponse = api_instance.create_notification(notification)
    return context.res.json({"msg":str(notificationResponse)})

day_order_data = {
    "01-01-24": {
        "do": "nothing"
    },
    "02-01-24": {
        "do": "Day 4"
    },
    "03-01-24": {
        "do": "Day 5"
    },
    "04-01-24": {
        "do": "Day 1"
    },
    "05-01-24": {
        "do": "Day 2"
    },
    "06-01-24": {
        "do": "nothing"
    },
    "07-01-24": {
        "do": "nothing"
    },
    "08-01-24": {
        "do": "Day 3"
    },
    "09-01-24": {
        "do": "Day 4"
    },
    "10-01-24": {
        "do": "Day 5"
    },
    "11-01-24": {
        "do": "Day 1"
    },
    "12-01-24": {
        "do": "Day 2"
    },
    "13-01-24": {
        "do": "nothing"
    },
    "14-01-24": {
        "do": "nothing"
    },
    "15-01-24": {
        "do": "nothing"
    },
    "16-01-24": {
        "do": "nothing"
    },
    "17-01-24": {
        "do": "nothing"
    },
    "18-01-24": {
        "do": "Day 3"
    },
    "19-01-24": {
        "do": "Day 4"
    },
    "20-01-24": {
        "do": "nothing"
    },
    "21-01-24": {
        "do": "nothing"
    },
    "22-01-24": {
        "do": "Day 5"
    },
    "23-01-24": {
        "do": "Day 1"
    },
    "24-01-24": {
        "do": "Day 2"
    },
    "25-01-24": {
        "do": "Day 3"
    },
    "26-01-24": {
        "do": "nothing"
    },
    "27-01-24": {
        "do": "nothing"
    },
    "28-01-24": {
        "do": "nothing"
    },
    "29-01-24": {
        "do": "Day 4"
    },
    "30-01-24": {
        "do": "Day 5"
    },
    "31-01-24": {
        "do": "Day 1"
    },
    "01-02-24": {
        "do": "Day 2"
    },
    "02-02-24": {
        "do": "Day 3"
    },
    "03-02-24": {
        "do": "nothing"
    },
    "04-02-24": {
        "do": "nothing"
    },
    "05-02-24": {
        "do": "Day 4"
    },
    "06-02-24": {
        "do": "Day 5"
    },
    "07-02-24": {
        "do": "Day 1"
    },
    "08-02-24": {
        "do": "Day 2"
    },
    "09-02-24": {
        "do": "Day 3"
    },
    "10-02-24": {
        "do": "nothing"
    },
    "11-02-24": {
        "do": "nothing"
    },
    "12-02-24": {
        "do": "Day 4"
    },
    "13-02-24": {
        "do": "Day 5"
    },
    "14-02-24": {
        "do": "Day 1"
    },
    "15-02-24": {
        "do": "Day 2"
    },
    "16-02-24": {
        "do": "Day 3"
    },
    "17-02-24": {
        "do": "nothing"
    },
    "18-02-24": {
        "do": "nothing"
    },
    "19-02-24": {
        "do": "Day 4"
    },
    "20-02-24": {
        "do": "Day 5"
    },
    "21-02-24": {
        "do": "Day 1"
    },
    "22-02-24": {
        "do": "Day 2"
    },
    "23-02-24": {
        "do": "Day 3"
    },
    "24-02-24": {
        "do": "nothing"
    },
    "25-02-24": {
        "do": "nothing"
    },
    "26-02-24": {
        "do": "Day 4"
    },
    "27-02-24": {
        "do": "Day 5"
    },
    "28-02-24": {
        "do": "Day 1"
    },
    "29-02-24": {
        "do": "Day 2"
    },
    "01-03-24": {
        "do": "Day 3"
    },
    "02-03-24": {
        "do": "nothing"
    },
    "03-03-24": {
        "do": "nothing"
    },
    "04-03-24": {
        "do": "Day 4"
    },
    "05-03-24": {
        "do": "Day 5"
    },
    "06-03-24": {
        "do": "Day 1"
    },
    "07-03-24": {
        "do": "Day 2"
    },
    "08-03-24": {
        "do": "Day 3"
    },
    "09-03-24": {
        "do": "nothing"
    },
    "10-03-24": {
        "do": "nothing"
    },
    "11-03-24": {
        "do": "Day 4"
    },
    "12-03-24": {
        "do": "Day 5"
    },
    "13-03-24": {
        "do": "Day 1"
    },
    "14-03-24": {
        "do": "Day 2"
    },
    "15-03-24": {
        "do": "Day 3"
    },
    "16-03-24": {
        "do": "nothing"
    },
    "17-03-24": {
        "do": "nothing"
    },
    "18-03-24": {
        "do": "Day 4"
    },
    "19-03-24": {
        "do": "Day 5"
    },
    "20-03-24": {
        "do": "Day 1"
    },
    "21-03-24": {
        "do": "Day 2"
    },
    "22-03-24": {
        "do": "Day 3"
    },
    "23-03-24": {
        "do": "nothing"
    },
    "24-03-24": {
        "do": "nothing"
    },
    "25-03-24": {
        "do": "Day 4"
    },
    "26-03-24": {
        "do": "Day 5"
    },
    "27-03-24": {
        "do": "Day 1"
    },
    "28-03-24": {
        "do": "Day 2"
    },
    "29-03-24": {
        "do": "nothing"
    },
    "30-03-24": {
        "do": "nothing"
    },
    "31-03-24": {
        "do": "nothing"
    },
    "01-04-24": {
        "do": "Day 3"
    },
    "02-04-24": {
        "do": "Day 4"
    },
    "03-04-24": {
        "do": "Day 5"
    },
    "04-04-24": {
        "do": "nothing"
    },
    "05-04-24": {
        "do": "nothing"
    },
    "06-04-24": {
        "do": "nothing"
    },
    "07-04-24": {
        "do": "nothing"
    },
    "08-04-24": {
        "do": "nothing"
    },
    "09-04-24": {
        "do": "nothing"
    },
    "10-04-24": {
        "do": "nothing"
    },
    "11-04-24": {
        "do": "nothing"
    },
    "12-04-24": {
        "do": "nothing"
    },
    "13-04-24": {
        "do": "nothing"
    },
    "14-04-24": {
        "do": "nothing"
    },
    "15-04-24": {
        "do": "nothing"
    },
    "16-04-24": {
        "do": "nothing"
    },
    "17-04-24": {
        "do": "nothing"
    },
    "18-04-24": {
        "do": "nothing"
    },
    "19-04-24": {
        "do": "nothing"
    },
    "20-04-24": {
        "do": "nothing"
    },
    "21-04-24": {
        "do": "nothing"
    },
    "22-04-24": {
        "do": "nothing"
    },
    "23-04-24": {
        "do": "nothing"
    },
    "24-04-24": {
        "do": "nothing"
    },
    "25-04-24": {
        "do": "nothing"
    },
    "26-04-24": {
        "do": "nothing"
    },
    "27-04-24": {
        "do": "nothing"
    },
    "28-04-24": {
        "do": "nothing"
    },
    "29-04-24": {
        "do": "nothing"
    },
    "30-04-24": {
        "do": "nothing"
    },
    "01-05-24": {
        "do": "nothing"
    },
    "02-05-24": {
        "do": "nothing"
    },
    "03-05-24": {
        "do": "nothing"
    },
    "04-05-24": {
        "do": "nothing"
    },
    "05-05-24": {
        "do": "nothing"
    },
    "06-05-24": {
        "do": "nothing"
    },
    "07-05-24": {
        "do": "nothing"
    },
    "08-05-24": {
        "do": "nothing"
    },
    "09-05-24": {
        "do": "nothing"
    },
    "10-05-24": {
        "do": "nothing"
    },
    "11-05-24": {
        "do": "nothing"
    },
    "12-05-24": {
        "do": "nothing"
    },
    "13-05-24": {
        "do": "nothing"
    },
    "14-05-24": {
        "do": "nothing"
    },
    "15-05-24": {
        "do": "nothing"
    },
    "16-05-24": {
        "do": "nothing"
    },
    "17-05-24": {
        "do": "nothing"
    },
    "18-05-24": {
        "do": "nothing"
    },
    "19-05-24": {
        "do": "nothing"
    },
    "20-05-24": {
        "do": "nothing"
    },
    "21-05-24": {
        "do": "nothing"
    },
    "22-05-24": {
        "do": "nothing"
    },
    "23-05-24": {
        "do": "nothing"
    },
    "24-05-24": {
        "do": "nothing"
    },
    "25-05-24": {
        "do": "nothing"
    },
    "26-05-24": {
        "do": "nothing"
    },
    "27-05-24": {
        "do": "nothing"
    },
    "28-05-24": {
        "do": "nothing"
    },
    "29-05-24": {
        "do": "nothing"
    },
    "30-05-24": {
        "do": "nothing"
    },
    "31-05-24": {
        "do": "nothing"
    }
}
