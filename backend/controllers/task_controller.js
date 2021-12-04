const Task = require("../models/task_model");
const createError = require("http-errors");

//add new task
const addNewTask = async (req, res, next) => {
  const newTask = new Task(req.body);

  const { error } = newTask.joiValidation(req.body);

  if (error) {
    return res.status(400).json({
      result: false,
      message: error,
    });
  } else {
    try {
      const result = await newTask.save();
      if (result) {
        return res.status(201).json({
          result: true,
          message: "New task saved.",
        });
      } else {
        return res.status(400).json({
          result: false,
          message: "Something went wrong while saving task.",
        });
      }
    } catch (e) {
      next(createError(e));
    }
  }
};

//update task
const updateTask = async (req, res, next) => {
  try {
    const task = await Task.findById(req.body.id, {}, { lean: true });
    if (task) {
      const willBeUpdated = await Task.findByIdAndUpdate(
        { _id: req.body.id },
        req.body,
        { lean: true, new: true }
      );
      if (willBeUpdated) {
        return res.status(201).json({
          result: true,
          message: "Task updated.",
        });
      } else {
        return res.status(400).json({
          result: true,
          message: "Something went wrong while updating task.",
        });
      }
    } else {
      return res.status(404).json({
        result: false,
        message: "No record found.",
      });
    }
  } catch (error) {
    next(createError(error));
  }
};

//delete task
const deleteTask = async (req, res, next) => {
  try {
    const task = await Task.findByIdAndDelete({ _id: req.body.id });
    if (task) {
      return res.status(201).json({
        result: true,
        message: "Task deleted.",
      });
    } else {
      return res.status(400).json({
        result: false,
        message: "Something went wrong while deleting task.",
      });
    }
  } catch (error) {
    next(createError(error));
  }
};

//get all data
const getAllTasks = async (req, res, next) => {
  try {
    const allData = await Task.find({}, {}, { lean: true });
    return res.status(200).json(allData);
  } catch (error) {
    next(createError(error));
  }
};
module.exports = {
  addNewTask,
  updateTask,
  deleteTask,
  getAllTasks,
};
