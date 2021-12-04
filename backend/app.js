//we will be using express.js for creating our service
const express = require('express');
const app = express();
const bodyParser = require('body-parser');

//define data type
app.use(express.json());
app.use(bodyParser.json());

require("./database/mongoose_db");

const errorMiddleWare = require("./middlewares/error_middleware");

const taskRouter = require("./router/task_router");

app.use('/api/task', taskRouter);

app.use(errorMiddleWare);

//set available port to connect our server
const PORT = process.env.PORT || 3000;
app.listen(PORT, (err, suc) => {
  if (err) throw err;
  console.log(`Server running on ${PORT} port`);
});
