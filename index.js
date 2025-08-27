const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

// HTTP callable function instead of regular callable
exports.sendNotification = functions.https.onRequest(async (req, res) => {
  // Enable CORS
  res.set('Access-Control-Allow-Origin', '*');
  res.set('Access-Control-Allow-Methods', 'POST');
  res.set('Access-Control-Allow-Headers', 'Content-Type');

  // Handle OPTIONS request for CORS preflight
  if (req.method === 'OPTIONS') {
    res.status(204).send('');
    return;
  }

  // Ensure POST method
  if (req.method !== 'POST') {
    res.status(405).send('Method Not Allowed');
    return;
  }

  try {
    const { token, title, body, data } = req.body;

    // Validate required fields
    if (!token || !title || !body) {
      console.error('Missing required fields:', { token, title, body });
      res.status(400).send('Missing required fields');
      return;
    }

    console.log('Attempting to send notification with data:', {
      token,
      title,
      body,
      data
    });

    // Create message
    const message = {
      token,
      notification: {
        title,
        body,
      },
    };

    if (data) {
      message.data = data;
    }

    // Send message
    const response = await admin.messaging().send(message);
    console.log('Successfully sent message:', response);

    res.status(200).json({ success: true, messageId: response });
  } catch (error) {
    console.error('Error sending notification:', error);
    res.status(500).json({ error: error.message });
  }
});