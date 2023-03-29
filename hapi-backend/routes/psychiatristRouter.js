const express = require("express");
const router = express.Router();
const controller = require("../controllers");

router.get("/getAllPsychiatrist", controller.psychiatristController.getAll);

router.post("/createPsychiatrist", controller.psychiatristController.create);

router.put("/updatePsychiatrist/:id", controller.psychiatristController.update);

router.delete(
  "/deletePsychiatrist/:id",
  controller.psychiatristController.delete
);

module.exports = router;
