const catchError = (err, req, res, next) => {
  console.log(err);

  //check the value if it is unique or not
  if (err.code === 11000) {
    return res.status(400).json({
      mesaj: JSON.stringify(
        Object.keys(err.keyValue) + " value " + Object.values(err.keyValue) + " must be unique"
      ),
    });
  }

  return res.status(err.statusCode).json({
    mesaj: err.message,
    islemKodu: err.statusCode,
  });
};

module.exports = catchError;
