const Sequelize = require("sequelize");
const db = require("../database/hapi.js");

const databaseOptions = {
  freezeTableName: true,
  timestamps: false,
};

const moods = db.define(
  "moods",
  {
    id: {
      type: Sequelize.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    mood: {
      type: Sequelize.STRING,
    },
    score: {
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
  moods,
};
