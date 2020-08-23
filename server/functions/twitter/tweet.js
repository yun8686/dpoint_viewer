const Twitter = require("twitter");
const setting = require("./twitter.setting.json");
const client = new Twitter(setting);

const content = "Dポイント投資はじめます。 #Dポイント投資";
client.post("statuses/update", { status: content }, function(
  error,
  tweet,
  response
) {
  if (!error) {
    console.log("tweet success: " + content);
  } else {
    console.log(error);
  }
});
