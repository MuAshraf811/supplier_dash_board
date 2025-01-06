const functions = require("firebase-functions");
const admin = require("firebase-admin");

// Initialize the Firebase Admin SDK
admin.initializeApp();

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");



exports.sendNotification = functions.https.onCall(async (data, context) => {
  const fcmToken = data.fcmToken;  // Device's FCM token to send the notification
  const title = data.title;        // Title of the notification
  const body = data.body;          // Body of the notification

  // Check if the fcmToken is valid
  if (!fcmToken || fcmToken.trim().isEmpty) {
      return { success: false, error: "FCM token is empty or invalid" };
  }

  // Create the message for FCM
  const message = {
      token: fcmToken,
      notification: {
          title: title,
          body: body,
      },
  };

  try {
      // Send the notification using the Admin SDK
      const response = await admin.messaging().send(message);
      return { success: true, response: response };
  } catch (error) {
      console.error("Error sending notification:", error);
      return { success: false, error: error.message };
  }
});

  
// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
