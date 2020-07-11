//local database connection
const mongoose = require("mongoose");
const dbConnection = "mongodb://127.0.0.1:27017/flutter_todoapp";

mongoose
  .connect(dbConnection, {
    useCreateIndex: true,
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useFindAndModify: false,
  })
  .then((suc) => console.log("Connected to db"))
  .catch((err) => console.log("Error occurred while connecting to db", err));
