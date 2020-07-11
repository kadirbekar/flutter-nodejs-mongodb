import 'package:flutter/material.dart';
import 'package:todoapp_flutter_nodejs/core/constants/message_constants.dart';
import 'package:todoapp_flutter_nodejs/ui/common/show_toast_message.dart';

import '../../core/models/task_list_model.dart';
import '../../core/models/task_model.dart';
import '../../core/services/api_service.dart';
import '../common/ui_color_helper.dart';
import '../widgets/custom_card.dart';
import '../widgets/default_custom_button.dart';
import '../widgets/text_form_field.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  List<TaskList> _taskList = [];
  String _id = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appbar,
        body: FutureBuilder(
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return ErrorOccurred();
                break;
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator(),);
                break;
              case ConnectionState.done:
                _taskList = snapshot.data;
                return showData;
                break;
              default:
                return ErrorOccurred();
                break;
            }
          },
          future: ApiService().getAllTasks(),
        ),
      ),
    );
  }

  Widget get appbar => AppBar(
        title: const Text("Task Manager"),
        centerTitle: true,
        backgroundColor: UIColorHelper.DEFAULT_COLOR,
        
      );

  Widget get showData => Column(
        children: <Widget>[
          newTaskPanel,
          crudPanel,
        ],
      );

  Widget get newTaskPanel => TaskPanel(
        widget: Expanded(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                MyTextFormField(
                  label: 'Name',
                  controller: _nameController,
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextFormField(
                  label: 'Description',
                  controller: _descriptionController,
                  lineCount: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                _taskList.length > 0
                    ? Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return showCard(
                                index,
                                _taskList[index].name,
                                _taskList[index].description,
                                _taskList[index].id);
                          },
                          itemCount: _taskList.length,
                        ),
                      )
                    : NoSavedData(),
              ],
            ),
          ),
        ),
      );

  Widget get crudPanel => Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[addTaskButton, updateTaskButton],
        ),
      );

  Widget showCard(int index, String name, String description, String id) => GestureDetector(
        onTap: () {
          _nameController.text = name;
          _descriptionController.text = description;
          _id = id;
        },
        child: CustomCard(
          index: index + 1,
          name: name,
          description: description,
          function: () async {
            _id = id;
            await ApiService().deleteTask(_id).then((data) {
              if (data.result == true) {
                setState(() {
                  _nameController.clear();
                  _descriptionController.clear();
                  ShowToastMessage.showCenterShortToast(
                      MessageConstants.BASARILI);
                });
              } else {
                ShowToastMessage.showCenterShortToast(MessageConstants.HATA);
              }
            });
          },
        ),
      );

  Widget get addTaskButton => DefaultRaisedButton(
        height: 55,
        width: 120,
        color: UIColorHelper.DEFAULT_COLOR,
        label: 'Add',
        onPressed: () async {
          await ApiService()
              .addNewTask(Task(
                  name: _nameController.text,
                  description: _descriptionController.text))
              .then((data) {
            if (data.result == true) {
              setState(() {
                _nameController.clear();
                _descriptionController.clear();
                ShowToastMessage.showCenterShortToast(
                    MessageConstants.BASARILI);
              });
            } else {
              ShowToastMessage.showCenterShortToast(MessageConstants.HATA);
            }
          });
        },
      );

  Widget get updateTaskButton => DefaultRaisedButton(
        height: 55,
        width: 120,
        label: 'Update',
        color: UIColorHelper.DEFAULT_COLOR,
        onPressed: () async {
          await ApiService()
              .updateTask(
                  _nameController.text, _descriptionController.text, _id)
              .then((data) {
            if (data.result == true) {
              setState(() {
                _nameController.clear();
                _descriptionController.clear();
                ShowToastMessage.showCenterShortToast(
                    MessageConstants.BASARILI);
              });
            } else {
              ShowToastMessage.showCenterShortToast(MessageConstants.HATA);
            }
          });
        },
      );
}

class TaskPanel extends StatelessWidget {
  final Widget widget;

  const TaskPanel({Key key, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return widget;
  }
}

class ErrorOccurred extends StatelessWidget {
  const ErrorOccurred({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text(MessageConstants.ERROR_OCCURED),
    );
  }
}

class NoSavedData extends StatelessWidget {
  const NoSavedData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          Icons.airline_seat_individual_suite,
          size: 55,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          MessageConstants.NO_SAVED_DATA,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.red),
        ),
      ],
    );
  }
}
