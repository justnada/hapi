const express = require("express");
const router = express.Router();
const controller = require("../controllers");

router.get("/getAllUserMood", controller.userMoodController.getAllUserMood);

router.get(
  "/getUserMoodDetail/:userMoodId",
  controller.userMoodController.getUserMoodDetail
);

router.post("/createUserMood", controller.userMoodController.createUserMood);

router.get(
  "/getUserMoodOverview",
  controller.userMoodController.getUserMoodOverview
);

module.exports = router;
