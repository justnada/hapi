const Sequelize = require("sequelize");
const db = require("../database/hapi.js");

const databaseOptions = {
  freezeTableName: true,
  timestamps: false,
};

const userMoods = db.define(
  "user_moods",
  {
    id: {
      type: Sequelize.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    user_id: {
      type: Sequelize.INTEGER,
    },
    date: {
      type: Sequelize.STRING,
    },
    score_total: {
      type: Sequelize.INTEGER,
    },
    score_avg: {
      type: Sequelize.FLOAT,
    },
    mood_total: {
      type: Sequelize.INTEGER,
    },
    mood_id: {
      type: Sequelize.INTEGER,
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
  userMoods,
};
