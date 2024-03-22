const mongoose = require("mongoose");
const Joi = require("joi");
const Schema = mongoose.Schema;

//define task model restrictions
const TaskSchema = new Schema(
  {
    name: {
      type: String,
      trim: true,
      unique: true,
      required: true,
    },
    description: {
      type: String,
      trim: true,
    },
    createdDate: {
      type: Date,
      default: Date.now,
    },
  },
  { collection: "task" }
);

const schema = Joi.object({
  name: Joi.string().trim(),
  description: Joi.string().trim(),
  createdDate: Joi.date(),
});

TaskSchema.methods.joiValidation = function (taskObject) {
  schema.required();
  return schema.validate(taskObject);
};

const Task = mongoose.model("Task", TaskSchema);
module.exports = Task;
