import * as functions from "firebase-functions";
import {Configuration, OpenAIApi} from "openai";

const OPEN_API_KEY = process.env.OPEN_API_KEY;

const configuration = new Configuration({
  apiKey: OPEN_API_KEY,
});

const formatMessage = (message: string): string => {
  const questionList = [
    `「${message}」と言っている人を褒めてください。`,
    `「${message}」と言っている人を慰めてください。`,
    `「${message}」と言っている人を元気づけてください。`,
  ];
  return questionList[Math.floor(Math.random() * questionList.length)];
};

export const postMessage = functions.https.onCall(async (data) => {
  const openai = new OpenAIApi(configuration);

  const completion = await openai.createCompletion({
    model: "text-davinci-003",
    prompt: formatMessage(data.message),
    max_tokens: 500,
  });
  return {reply: completion.data.choices[0].text};
});
