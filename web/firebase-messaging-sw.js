importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-messaging.js');

// Initialize Firebase app
firebase.initializeApp({
    apiKey: "AIzaSyBheZpG2QCtBrBspDi0ns_OWWAGWkSNMYw",
    authDomain: "supply-20735.firebaseapp.com",
    projectId: "supply-20735",
    storageBucket: "supply-20735.firebasestorage.app",
    messagingSenderId: "583335541663",
    appId: "1:583335541663:web:21bd55f2728bdb97219baa"
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage(function(payload) {
  console.log('Received background message ', payload);
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: payload.notification.icon
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
