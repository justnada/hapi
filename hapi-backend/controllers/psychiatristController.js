const { Psychiatrist } = require("../models");
const db = require("../database/hapi.js");
const successResponse = require("../utils/successReponse");
const ErrorResponse = require("../utils/errorResponse");

const psychiatristController = {};

psychiatristController.getAll = async (req, res, next) => {
  const { page = 1, sort = "ASC", size = 3 } = req.query;
  const offset = (Number(page) - 1) * Number(size);

  try {
    const psychiatrist = await Psychiatrist.psychiatrists.findAll(
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

    const newPsychiatrist = psychiatrist.map((p) => {
      p = p.dataValues;
      let id = String(p.id);
      let rating = p.rating.toFixed(1);
      let location = [parseFloat(p.latitude), parseFloat(p.longtitude)];

      delete p.latitude;
      delete p.longtitude;

      return { ...p, id, rating, location };
    });

    const pagination = {
      page: page,
      limit: size,
      record: newPsychiatrist.length,
    };
    return successResponse(res, newPsychiatrist, pagination);
  } catch (error) {
    next(error);
  }
};

psychiatristController.create = async (req, res, next) => {
  const {
    name,
    status,
    grade,
    experience,
    rating,
    patient,
    image,
    banner,
    address,
    latitude,
    longtitude,
  } = req.body;
  let trx;

  try {
    trx = await db.transaction({ autocommit: true });

    const newPsychiatrist = await Psychiatrist.psychiatrists.create(
      {
        name,
        status,
        grade,
        experience,
        rating,
        patient,
        image,
        banner,
        address,
        latitude,
        longtitude,
      },
      {
        transaction: trx,
      }
    );

    if (!newPsychiatrist)
      throw new ErrorResponse("Failed to create psychiatrist", 400);

    await trx.commit();

    return successResponse(res);
  } catch (error) {
    next(error);
  }
};

psychiatristController.update = async (req, res, next) => {
  const { id } = req.params;
  const {
    name,
    status,
    grade,
    experience,
    rating,
    patient,
    image,
    banner,
    address,
    latitude,
    longtitude,
  } = req.body;
  let trx;

  try {
    trx = await db.transaction({ autocommit: true });

    const findPsychiatrist = await Psychiatrist.psychiatrists.findOne({
      where: { id: id },
      attributes: ["id"],
      raw: true,
    });

    if (!findPsychiatrist)
      throw new ErrorResponse("Psychiatrist not found", 404);

    const updatePsychiatrist = await Psychiatrist.psychiatrists.update(
      {
        name,
        status,
        grade,
        experience,
        rating,
        patient,
        image,
        banner,
        address,
        latitude,
        longtitude,
      },
      {
        where: { id: id },
        transaction: trx,
      }
    );

    if (!updatePsychiatrist)
      throw new ErrorResponse("Failed to update psychiatrist", 400);

    await trx.commit();
    return successResponse(res);
  } catch (error) {
    next(error);
  }
};

psychiatristController.delete = async (req, res, next) => {
  const { id } = req.params;
  let trx;

  try {
    trx = await db.transaction({ autocommit: true });

    const findPsychiatrist = await Psychiatrist.psychiatrists.findOne({
      where: { id: id },
      attributes: ["id"],
      raw: true,
    });

    if (!findPsychiatrist)
      throw new ErrorResponse("Psychiatrist not found", 404);

    const deletePsychiatrist = await Psychiatrist.psychiatrists.destroy({
      where: {
        id: findPsychiatrist.id,
      },
    });

    if (!deletePsychiatrist)
      throw new ErrorResponse("Failed to delete psychiatrist", 400);

    await trx.commit();
    return successResponse(res);
  } catch (error) {
    next(error);
  }
};

module.exports = psychiatristController;
