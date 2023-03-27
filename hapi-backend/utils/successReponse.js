const response = (res, data = {}, pagination = {}) => {
  return res.status(200).json({
    code: "1",
    msg: "Success",
    data: data,
    pagination: pagination,
  });
};

module.exports = response;
