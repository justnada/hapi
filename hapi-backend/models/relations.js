function addRelation(sequelize) {
  const { moods, user_moods, user_mood_details } = sequelize.models;

  moods.hasMany(user_moods, {
    foreignKey: "id",
    onDelete: "cascade",
  });

  moods.hasMany(user_mood_details, {
    foreignKey: "id",
    onDelete: "cascade",
  });

  user_moods.belongsTo(moods, {
    foreignKey: "mood_id",
  });

  user_mood_details.belongsTo(moods, {
    foreignKey: "mood_id",
  });

  console.log("success apply relation");
}

module.exports = { addRelation };
