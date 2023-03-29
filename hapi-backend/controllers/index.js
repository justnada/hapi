const moodController = require("./moodController");
const userMoodController = require("./userMoodController");
const psychiatristController = require("./psychiatristController");

const controller = {
  moodController: moodController,
  userMoodController: userMoodController,
  psychiatristController: psychiatristController,
};

module.exports = controller;
