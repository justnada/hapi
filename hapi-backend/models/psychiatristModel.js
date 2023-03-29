const Sequelize = require("sequelize");
const db = require("../database/hapi.js");

const databaseOptions = {
  freezeTableName: true,
  timestamps: false,
};

const psychiatrists = db.define(
  "psychiatrists",
  {
    id: {
      type: Sequelize.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    name: {
      type: Sequelize.STRING,
    },
    status: {
      type: Sequelize.STRING,
    },
    grade: {
      type: Sequelize.STRING,
    },
    experience: {
      type: Sequelize.STRING,
    },
    rating: {
      type: Sequelize.FLOAT,
    },
    patient: {
      type: Sequelize.INTEGER,
    },
    image: {
      type: Sequelize.STRING,
    },
    banner: {
      type: Sequelize.STRING,
    },
    address: {
      type: Sequelize.TEXT,
    },
    latitude: {
      type: Sequelize.DECIMAL(9, 6),
    },
    longtitude: {
      type: Sequelize.DECIMAL(9, 6),
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
  psychiatrists,
};
