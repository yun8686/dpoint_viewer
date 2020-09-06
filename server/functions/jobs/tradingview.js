const puppeteer = require("puppeteer");
const admin = require("firebase-admin");
const db = admin.firestore();

let page, browser;

async function getBrowserPage() {
  const isDebug = process.env.NODE_ENV !== "production";

  const launchOptions = {
    headless: isDebug ? false : true,
    args: ["--no-sandbox"],
  };

  browser = await puppeteer.launch(launchOptions);
  return browser.newPage();
}
//runTradingView();
exports.runTradingView = runTradingView;
async function runTradingView(context) {
  if (!page) {
    page = await getBrowserPage();
  }

  const Symbols = [
    "USDJPY",
    "AMEX-EWJ",
    "AMEX-FXI",
    "AMEX-EWT",
    "AMEX-EPI",
    "AMEX-VGK",
    "AMEX-VTV",
    "NASDAQ-QQQ",
    "AMEX-VOT",
    "NASDAQ-IEF",
    "NASDAQ-MBB",
    "NASDAQ-TLT",
    "AMEX-LQD",
    "AMEX-SJNK",
    "AMEX-SRLN",
    "NASDAQ-IGSB",
    "AMEX-HYG",
    "NASDAQ-IGOV",
  ];
  const Rates = {
    grose: {
      "AMEX-EWJ": 19.8,
      "AMEX-FXI": 7.6,
      "AMEX-EWT": 6.5,
      "AMEX-EPI": 4.6,
      "AMEX-VGK": 17.1,
      "AMEX-VTV": 20.0,
      "NASDAQ-QQQ": 18.1,
      "AMEX-VOT": 6.4,
    },
    income: {
      "NASDAQ-IEF": 21.5,
      "NASDAQ-MBB": 19.6,
      "NASDAQ-TLT": 13.5,
      "AMEX-LQD": 11.2,
      "AMEX-SJNK": 10.2,
      "AMEX-SRLN": 7.5,
      "NASDAQ-IGSB": 4.6,
      "AMEX-HYG": 2.5,
      "NASDAQ-IGOV": 9.4,
    },
  };
  const dateText = getCurrentDate();
  const results = [];
  for (const symbol of Symbols) {
    await page.goto(`https://jp.tradingview.com/symbols/${symbol}/ideas/`);
    await page.waitForFunction(
      'document.querySelector(".tv-symbol-price-quote__value.js-symbol-last").innerText.includes(".")'
    );
    const { currentPrice, prevPrice } = await page.evaluate(() => {
      return {
        currentPrice: document
          .querySelectorAll(".tv-symbol-price-quote__value.js-symbol-last")[0]
          .innerText.replace("−", "-"),
        prevPrice: document
          .querySelectorAll(".tv-symbol-price-quote__change span")[0]
          .innerText.replace("−", "-"),
      };
    });
    results.push({ symbol, currentPrice, prevPrice });
  }
  // 仲値取得
  await page.goto("https://www.mizuhobank.co.jp/market/dollar.html");
  const { middleDateText, middleUSD } = await page.evaluate(() => {
    return {
      middleDateText: document
        .querySelectorAll(`.js-market-date`)[0]
        .innerText.match(/\d+/g)
        .map((v, i) => ("00" + v).slice(i === 0 ? -4 : -2))
        .join(""),
      middleUSD: document.querySelectorAll(`[summary="米ドル公示相場"] td`)[4]
        .innerText,
    };
  });
  const middleData = {
    middleDateText,
    middleUSD,
  };

  const yesterDay = new Date();
  yesterDay.setDate(yesterDay.getDate() - 1);
  const todayText = getCurrentDate().substring(0, 8);
  const yesterdayText = getCurrentDate(yesterDay).substring(0, 8);

  // 予想計算
  const yesterdayUSD = yesterdayText === middleDateText ? middleUSD : 105.8;
  const todayUSD = results.find((v) => v.symbol === "USDJPY").currentPrice;
  const groseRate = Object.keys(Rates.grose).reduce((prev, key) => {
    const { currentPrice, prevPrice } = results.find((v) => v.symbol === key);
    const yesterday = (currentPrice - prevPrice) * yesterdayUSD;
    const today = currentPrice * todayUSD;
    const rate = ((today - yesterday) / yesterday) * Rates.grose[key];
    return rate + prev;
  }, 0);
  const incomeRate = Object.keys(Rates.income).reduce((prev, key) => {
    const { currentPrice, prevPrice } = results.find((v) => v.symbol === key);
    const yesterday = (currentPrice - prevPrice) * yesterdayUSD;
    const today = currentPrice * todayUSD;
    const rate = ((today - yesterday) / yesterday) * Rates.income[key];
    return rate + prev;
  }, 0);

  if (process.env.NODE_ENV !== "production") {
    console.log(results);
    console.log(middleData);
    console.log({ groseRate, incomeRate });
  } else {
    await db
      .collection("price_list")
      .doc(dateText)
      .set({
        results: results,
      });
    await db
      .collection("middle_data")
      .doc(middleDateText)
      .set({
        result: middleData,
      });
  }
}

function getCurrentDate(d = new Date()) {
  const date = convertUTCtoJST(d);
  return (
    date.getFullYear() +
    ("0" + (date.getMonth() + 1)).slice(-2) +
    ("0" + date.getDate()).slice(-2) +
    ("0" + date.getHours()).slice(-2) +
    ("0" + date.getMinutes()).slice(-2)
  );
}

function convertUTCtoJST(date) {
  return new Date(
    date.getTime() + date.getTimezoneOffset() * 60 * 1000 + 9 * 60 * 60 * 1000
  );
}
