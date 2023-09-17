import * as functions from "firebase-functions-test";
import {postMessage} from "../src";
import OpenAI from "openai";

jest.mock("openai");

describe("postMessage function", () => {
  const testEnv = functions();

  beforeAll(() => {
    // OpenAI モック化
    const mockOpenAi = {
      chat: {
        completions: {
          create: jest.fn().mockResolvedValue({
            choices: [
              {
                message: {content: "Mocked content"},
              },
            ],
          }),
        },
      },
    };

    // eslint-disable-next-line max-len, @typescript-eslint/no-explicit-any
    (OpenAI as jest.MockedClass<typeof OpenAI>).mockImplementation(() => mockOpenAi as any);
  });

  afterAll(() => {
    testEnv.cleanup();
  });

  it("Should return a reply from openai", async () => {
    jest.spyOn(global.Math, "random").mockReturnValue(0.5);

    const test = functions();
    const data = {data: {message: "Hello"}};
    const context = {
      app: {},
    };
    const result = await test.wrap(postMessage)(data, context);

    expect(result.reply).toBe("Mocked content");
    expect(result.isCool).toBe(false);
    jest.spyOn(global.Math, "random").mockRestore();
  });

  it("Should return a cool reply depending on the situation", async () => {
    jest.spyOn(global.Math, "random").mockReturnValue(0.05);

    const test = functions();
    const data = {data: {message: "Hello"}};
    const context = {
      app: {},
    };
    const result = await test.wrap(postMessage)(data, context);

    expect(result.reply).toBe("Mocked content");
    expect(result.isCool).toBe(true);
    jest.spyOn(global.Math, "random").mockRestore();
  });

  it("Should handle errors gracefully", async () => {
    // mock でエラーを返すようにする
    const mockOpenAi = {
      chat: {
        completions: {
          create: jest.fn().mockRejectedValue(new Error("API Error")),
        },
      },
    };

    // eslint-disable-next-line max-len, @typescript-eslint/no-explicit-any
    (OpenAI as jest.MockedClass<typeof OpenAI>).mockImplementation(() => mockOpenAi as any);

    const test = functions();
    const data = {data: {message: "Hello"}};
    const context = {
      app: {},
    };
    const result = await test.wrap(postMessage)(data, context);

    expect(result.reply).toBe("ほめのびくんの調子が悪いみたいです。また後で声をかけてあげてください。");
    expect(result.isCool).toBe(false);
  });
});
