const express = require("express");
const router = express.Router();
const controller = require("../controllers");

router.get("/getAllMood", controller.moodController.getAllMood);

router.post("/createMood", controller.moodController.createMood);

router.put("/updateMood/:id", controller.moodController.updateMood);

router.delete("/deleteMood/:id", controller.moodController.deleteMood);

module.exports = router;
