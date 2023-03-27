const moodModel = require("./moodModel");
const userMoodModel = require("./userMoodModel");
const userMoodDetailModel = require("./userMoodDetailModel");
const { addRelation } = require("./relations");
const sequelize = require("../database/hapi");

addRelation(sequelize);

const models = {
  Mood: moodModel,
  UserMood: userMoodModel,
  UserMoodDetail: userMoodDetailModel,
};

module.exports = models;
