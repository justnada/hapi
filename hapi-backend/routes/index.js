const moodRouter = require("./moodRouter");
const userMoodRouter = require("./userMoodRouter");
const psychiatristRouter = require("./psychiatristRouter");

const routes = {
  moodRouter: moodRouter,
  userMoodRouter: userMoodRouter,
  psychiatristRouter: psychiatristRouter,
};

module.exports = routes;
