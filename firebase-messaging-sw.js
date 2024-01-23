importScripts("https://www.gstatic.com/firebasejs/9.6.10/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.6.10/firebase-messaging-compat.js");
importScripts("local_forage.min.js");

const firebaseConfig = {
    apiKey: "AIzaSyDpPLA4Nt1FY6hsoseVPYD2JRP7e9ENKD4",
    authDomain: "srm-timetable-bb661.firebaseapp.com",
    projectId: "srm-timetable-bb661",
    storageBucket: "srm-timetable-bb661.appspot.com",
    messagingSenderId: "1062574904489",
    appId: "1:1062574904489:web:28469fb2790052f36485b8",
    measurementId: "G-0HHRGFQ665"
};

firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();
// addEventListener('message', (event) => {
//     if (event.data && event.data.type === 'MESSAGE_IDENTIFIER') {
//         // do something
//         localforage.setItem('timetable', event.data).then(function (value) {
//             // Do other things once the value has been saved.
//             console.log(value);
//         })
//     }
// });

messaging.onBackgroundMessage(function (payload) {
    console.log('[firebase-messaging-sw.js] Received background message ', payload);
    var index = payload.data.index
    var dayOrder = payload.data.dayOrder;
    var timetableData = "";
    var notificationTitle = "";
    var notificationOptions = {};
    localforage.getItem('timetable').then(function (value) {
        // This code runs once the value has been loaded
        // from the offline store.
        console.log("Local Forage data:", value);
        timetableData = JSON.parse(value);
        notificationTitle = "ScheduleSRM: You next class";
        notificationOptions = {
            body: timetableData[dayOrder][index],
            icon: '/icons/Icon-192.png'        
        };
    });
    return self.registration.showNotification(notificationTitle,
        notificationOptions);
});