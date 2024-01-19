importScripts("https://www.gstatic.com/firebasejs/9.6.10/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.6.10/firebase-messaging-compat.js");

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

messaging.onBackgroundMessage(function (payload) {
    console.log('[firebase-messaging-sw.js] Received background message ', payload);
    // Customize notification here
    // const notificationTitle = 'Background Message Title';
    // const notificationOptions = {
    //     body: 'Background Message body.',
    //     icon: '/icons/Icon-192.png'
    // };

    // return self.registration.showNotification(notificationTitle,
    //     notificationOptions);
});