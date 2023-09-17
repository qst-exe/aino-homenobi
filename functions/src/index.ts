import * as functions from "firebase-functions";
import OpenAI from "openai";
import {Message} from "./types";

const getOpenAi = () => {
  const OPEN_API_KEY = process.env.OPEN_API_KEY;

  return new OpenAI({
    apiKey: OPEN_API_KEY,
  });
};

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
  try {
    const message = formatMessage(data.message);
    const completion = await getOpenAi().chat.completions.create({
      model: "gpt-3.5-turbo",
      messages: [{role: "user", content: message.text}],
    });

    return {
      isCool: message.isCool,
      reply: completion.choices[0].message?.content?.trim(),
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
