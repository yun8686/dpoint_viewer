const admin = require("firebase-admin");
const functions = require("firebase-functions");
admin.initializeApp(functions.config().firebase);

const { runTradingView } = require("./jobs/tradingview");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
exports.tradingView = functions
  .runWith({
    memory: "1GB",
    timeoutSeconds: 260,
  })
  .region("asia-northeast1")
  .pubsub.schedule("every 5 minutes from 8:30 to 21:00")
  .timeZone("Asia/Tokyo")
  .onRun(async (context) => {
    await runTradingView(context);
  });

if (process.env.NODE_ENV !== "production") runTradingView();
