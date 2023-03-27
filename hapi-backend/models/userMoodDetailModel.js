const Sequelize = require("sequelize");
const db = require("../database/hapi.js");

const databaseOptions = {
  freezeTableName: true,
  timestamps: false,
};

const userMoodDetails = db.define(
  "user_mood_details",
  {
    id: {
      type: Sequelize.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    user_mood_id: {
      type: Sequelize.INTEGER,
    },
    mood_id: {
      type: Sequelize.INTEGER,
    },
    title: {
      type: Sequelize.STRING,
    },
    description: {
      type: Sequelize.STRING,
    },
    timestamp: {
      type: Sequelize.TIME,
    },
    created_at: {
      type: Sequelize.TIME,
    },
    updated_at: {
      type: Sequelize.TIME,
    },
  },
  databaseOptions
);

module.exports = {
  userMoodDetails,
};
