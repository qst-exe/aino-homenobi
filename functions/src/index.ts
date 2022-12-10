import * as functions from "firebase-functions";
import {Configuration, OpenAIApi} from "openai";

const OPEN_API_KEY = process.env.OPEN_API_KEY;

const configuration = new Configuration({
  apiKey: OPEN_API_KEY,
});

type Message = {
  isCool: boolean
  text: string
}

const formatMessage = (message: string): Message => {
  const questionList = [
    `「${message}」と言っている人を褒めてください。`,
    `「${message}」と言っている人を慰めてください。`,
    `「${message}」と言っている人を元気づけてください。`,
  ];

  if (Math.random() < 0.1) {
    return {
      isCool: true,
      text: `「${message}」と言っている人を罵倒してください。`,
    };
  }

  return {
    isCool: false,
    text: questionList[Math.floor(Math.random() * questionList.length)],
  };
};

export const postMessage = functions.https.onCall(async (data) => {
  const openai = new OpenAIApi(configuration);

  try {
    const message = formatMessage(data.message);
    const completion = await openai.createCompletion({
      model: "text-davinci-003",
      prompt: message.text,
      max_tokens: 500,
    });

    return {
      isCool: message.isCool,
      reply: completion.data.choices[0].text?.trim(),
    };
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
  } catch (error: any) {
    console.error(error);
  }

  return {
    isCool: false,
    reply: "ほめのびくんの調子が悪いみたいです。また後で声をかけてあげてください。",
  };
});
