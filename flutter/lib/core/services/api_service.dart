import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/app_constants.dart';
import '../constants/task_method_constants.dart';
import '../models/response_model.dart';
import '../models/task_list_model.dart';
import '../models/task_model.dart';

class ApiService {
  static final ApiService _apiService = ApiService._init();

  factory ApiService() {
    return _apiService;
  }

  ApiService._init();

  //add new task
  Future<Response> addNewTask(Task task) async {
    final url = Uri.parse(
      AppConstants.API_URL + TaskMethodConstants.ADD_NEW_TASK,
    );
    final request = await http.post(
      url,
      body: jsonEncode(task.toJson()),
      headers: AppConstants.HEADERS,
    );
    Response response = Response();
    try {
      if (request.statusCode == 201) {
        response = responseFromJson(request.body);
      } else {
        print(request.statusCode);
      }
    } catch (e) {
      return Response();
    }
    return response;
  }

  //update task
  Future<Response> updateTask(
      String name, String description, String id) async {
    final json =
        '{"name" : "$name","description" : "$description","id" : "$id"}';
    final url =
        Uri.parse(AppConstants.API_URL + TaskMethodConstants.UPDATE_TASK);
    final request =
        await http.post(url, body: json, headers: AppConstants.HEADERS);
    Response response = Response();
    try {
      if (request.statusCode == 201) {
        response = responseFromJson(request.body);
      } else {
        print(request.statusCode);
      }
    } catch (e) {
      return Response();
    }
    return response;
  }

  //update task
  Future<Response> deleteTask(String id) async {
    String json = '{"id" : "$id"}';
    final url =
        Uri.parse(AppConstants.API_URL + TaskMethodConstants.DELETE_TASK);
    final request =
        await http.post(url, body: json, headers: AppConstants.HEADERS);
    Response response = Response();
    try {
      if (request.statusCode == 201) {
        response = responseFromJson(request.body);
      } else {
        print(request.statusCode);
      }
    } catch (e) {
      return Response();
    }
    return response;
  }

  //get all data
  Future<List<TaskList>> getAllTasks() async {
    final url = Uri.parse(
      AppConstants.API_URL + TaskMethodConstants.LIST_ALL_TASKS,
    );
    final request = await http.get(
      url,
      headers: AppConstants.HEADERS,
    );
    List<TaskList> tasklist = [];
    try {
      if (request.statusCode == 200) {
        tasklist = taskListFromJson(request.body);
      } else {
        print(request.statusCode);
        return const [];
      }
    } catch (e) {
      return const [];
    }
    return tasklist;
  }
}
