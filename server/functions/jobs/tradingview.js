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
  const dateText = getCurrentDate();
  const results = [];
  for (const symbol of Symbols) {
    await page.goto(`https://jp.tradingview.com/symbols/${symbol}/ideas/`);
    await page.waitForFunction(
      'document.querySelector(".tv-symbol-price-quote__value.js-symbol-last span").innerText.includes(".")'
    );
    console.log("page", await page.title());
    const prevPrice = await page.evaluate(() => {
      return document.querySelectorAll(
        ".tv-symbol-price-quote__value.js-symbol-last span"
      )[0].innerText;
    });
    results.push({ symbol, prevPrice });
  }

  await db.collection("price_list").doc(dateText).set({
    results: results,
  });
}

function getCurrentDate() {
  const date = convertUTCtoJST(new Date());
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
