const { Mood } = require("../models");
const db = require("../database/hapi.js");
const successResponse = require("../utils/successReponse");
const ErrorResponse = require("../utils/errorResponse");

const moodController = {};

moodController.getAllMood = async (req, res, next) => {
  const { page = 1, sort = "ASC", size = 10 } = req.query;
  const offset = (Number(page) - 1) * Number(size);

  try {
    const moods = await Mood.moods.findAll(
      {
        limit: Number(size),
        offset: offset,
        order: [["created_at", sort]],
        attributes: {
          exclude: ["created_at", "updated_at"],
        },
      },
      {
        raw: true,
      }
    );

    const pagination = {
      page: page,
      limit: size,
      record: moods.length,
    };

    return successResponse(res, moods, pagination);
  } catch (error) {
    next(error);
  }
};

moodController.createMood = async (req, res, next) => {
  const { mood, score } = req.body;
  let trx;

  try {
    trx = await db.transaction({ autocommit: true });

    const newMood = await Mood.moods.create(
      {
        mood: mood,
        score: score,
      },
      {
        transaction: trx,
      }
    );

    if (!newMood) throw new ErrorResponse("Failed to create mood", 400);
    await trx.commit();

    return successResponse(res);
  } catch (error) {
    next(error);
  }
};

moodController.updateMood = async (req, res, next) => {
  const { id } = req.params;
  const { mood, score } = req.body;
  let trx;

  try {
    trx = await db.transaction({ autocommit: true });

    const findMood = await Mood.moods.findOne({
      where: { id: id },
      attributes: ["id"],
      raw: true,
    });

    if (!findMood) throw new ErrorResponse("Mood not found", 404);

    const updateMood = await Mood.moods.update(
      {
        mood: mood,
        score: score,
      },
      {
        where: { id: id },
        transaction: trx,
      }
    );

    if (!updateMood) throw new ErrorResponse("Failed to update mood", 400);

    await trx.commit();
    return successResponse(res);
  } catch (error) {
    next(error);
  }
};

moodController.deleteMood = async (req, res, next) => {
  const { id } = req.params;
  let trx;

  try {
    trx = await db.transaction({ autocommit: true });

    const findMood = await Mood.moods.findOne({
      where: { id: id },
      attributes: ["id"],
      raw: true,
    });

    if (!findMood) throw new ErrorResponse("Mood not found", 404);

    const deleteMood = await Mood.moods.destroy({
      where: {
        id: findMood.id,
      },
    });

    if (!deleteMood) throw new ErrorResponse("Failed to delete mood", 400);

    await trx.commit();
    return successResponse(res);
  } catch (error) {
    next(error);
  }

  console.log("id : ", id);
};

module.exports = moodController;
