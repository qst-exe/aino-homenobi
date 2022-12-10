import * as functions from "firebase-functions";

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

export const postMessage = functions.https.onCall((data) => {
  functions.logger.info(data, {structuredData: true});
  return {reply: "ありがとう"};
});
