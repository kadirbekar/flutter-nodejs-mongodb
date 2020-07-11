const taskRouter = require("express").Router();
const taskController = require("../controllers/task_controller");

taskRouter.post("/addNewTask", taskController.addNewTask);

taskRouter.post("/updateTask", taskController.updateTask);

taskRouter.post("/deleteTask", taskController.deleteTask);

taskRouter.get("/getAllTasks", taskController.getAllTasks);

module.exports = taskRouter;
