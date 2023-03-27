const { UserMood, UserMoodDetail, Mood } = require("../models");
const db = require("../database/hapi.js");
const successResponse = require("../utils/successReponse");
const ErrorResponse = require("../utils/errorResponse");
const moment = require("moment");
const { Op } = require("sequelize");

const userMoodController = {};

userMoodController.getAllUserMood = async (req, res, next) => {
  const { date } = req.query;

  if (!date) throw new ErrorResponse("Date is required", 400);

  try {
    const userMoods = await UserMood.userMoods.findAll({
      where: {
        date: { [Op.like]: `${date}%` },
      },
      limit: 31,
      offset: 0,
      order: [["created_at", "asc"]],
      attributes: {
        exclude: ["updated_at"],
      },
      include: {
        model: Mood.moods,
        attributes: {
          exclude: ["updated_at", "created_at"],
        },
      },
    });

    const newUserMoods = userMoods.map((um) => {
      return {
        id: um?.dataValues?.id,
        date: um?.dataValues?.date,
        mood: um?.dataValues?.mood.dataValues.mood,
      };
    });

    return successResponse(res, newUserMoods);
  } catch (error) {
    next(error);
  }
};

userMoodController.getUserMoodDetail = async (req, res, next) => {
  const { userMoodId } = req.params;
  const { page = 1, size = 10, sort = "DESC" } = req.query;
  const offset = (Number(page) - 1) * Number(size);

  try {
    const userMoodDetails = await UserMoodDetail.userMoodDetails.findAll({
      where: {
        user_mood_id: { [Op.eq]: userMoodId },
      },
      limit: Number(size),
      offset: offset,
      order: [["created_at", sort]],
      attributes: {
        exclude: ["updated_at"],
      },
      include: {
        model: Mood.moods,
        attributes: {
          exclude: ["updated_at", "created_at"],
        },
      },
    });

    const newUserMoodDetails = userMoodDetails.map((umd) => {
      return {
        id: umd.dataValues.id,
        mood: umd.dataValues.mood.dataValues.mood,
        timestamp: umd.dataValues.timestamp,
        title: umd.dataValues.title,
        description: umd.dataValues.description,
      };
    });

    const pagination = {
      page: page,
      limit: size,
      record: newUserMoodDetails.length,
    };

    return successResponse(res, newUserMoodDetails, pagination);
  } catch (error) {
    next(error);
  }
};

userMoodController.createUserMood = async (req, res, next) => {
  const { user_id, mood_id, title, description } = req.body;
  let today = moment().format("YYYY-MM-DD");
  let trx, userMood;

  try {
    // get user mood
    let findUserMood = await UserMood.userMoods.findOne({
      where: {
        [Op.and]: [{ user_id: user_id, date: today }],
      },
    });

    if (!findUserMood) {
      const newUserMood = await UserMood.userMoods.create({
        user_id: user_id,
        date: today,
        score_total: 0,
        score_avg: 0,
        mood_total: 0,
        mood_id: null,
      });

      userMood = newUserMood.dataValues;
    } else {
      userMood = findUserMood;
    }

    // insert mood detail
    trx = await db.transaction({ autocommit: true });

    const userMoodDetail = await UserMoodDetail.userMoodDetails.create(
      {
        user_mood_id: userMood.id,
        mood_id: mood_id,
        title: title,
        description: description,
      },
      {
        transaction: trx,
      }
    );

    if (!userMoodDetail)
      throw new ErrorResponse("Failed create user mood", 400);

    await trx.commit();

    // update user
    let findMood = await Mood.moods.findOne({ where: { id: mood_id } });

    if (!findMood) throw new ErrorResponse("Mood not found", 400);

    let moodTotal = userMood.mood_total + 1;
    let scoreTotal = userMood.score_total + findMood.score;
    let scoreAvg = scoreTotal / moodTotal;
    let roundScoreAvg = Math.round(scoreAvg);

    let findMoodUser = await Mood.moods.findOne({
      where: {
        score: {
          [Op.eq]: roundScoreAvg,
        },
      },
    });

    await UserMood.userMoods.update(
      {
        score_total: scoreTotal,
        score_avg: scoreAvg,
        mood_total: moodTotal,
        mood_id: findMoodUser.id,
      },
      {
        where: { id: userMood.id },
      }
    );

    return successResponse(res);
  } catch (error) {
    next(error);
  }
};

userMoodController.getUserMoodOverview = async (req, res, next) => {
  const { filter } = req.query;
  let startDate, endDate;

  if (!filter) throw new ErrorResponse("Filter is required", 400);

  try {
    startDate = moment().startOf("isoWeek").format("YYYY-MM-DD").toString();
    endDate = moment().endOf("isoWeek").format("YYYY-MM-DD").toString();

    startDate = new Date(startDate);
    endDate = new Date(endDate);

    const userMoods = await UserMood.userMoods.findAll(
      {
        where: {
          date: { [Op.between]: [startDate, endDate] },
        },
        include: {
          model: Mood.moods,
          attributes: {
            exclude: ["updated_at", "created_at"],
          },
        },
      },
      {
        raw: true,
      }
    );

    let moodOverview = [];
    let moodCount = [];
    let moodAggs = {
      great: 0,
      good: 0,
      neutral: 0,
      bad: 0,
      awful: 0,
    };

    userMoods.map((um) => {
      moodOverview.push({
        date: um.dataValues.date,
        total: um.dataValues.mood_total,
        mood: um.dataValues.mood.dataValues.mood,
      });

      moodAggs[um.dataValues.mood.dataValues.mood]++;
    });

    for (key in moodAggs) {
      moodCount.push({
        mood: key,
        count: moodAggs[key],
        percentage: `${(moodAggs[key] * 100) / 100}%`,
      });
    }

    return successResponse(res, {
      mood_overview: moodOverview,
      mood_count: moodCount,
    });
  } catch (error) {
    next(error);
  }
};

module.exports = userMoodController;
