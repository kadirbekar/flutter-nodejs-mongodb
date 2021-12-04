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
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final _nameController;
  late final _descriptionController;
  List<TaskList> _taskList = [];
  String _id = "";

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbar,
      body: FutureBuilder(
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return ErrorOccurred();
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              _taskList = snapshot.data != null
                  ? snapshot.data as List<TaskList>
                  : const [];
              return showData;
            default:
              return const ErrorOccurred();
          }
        },
        future: ApiService().getAllTasks(),
      ),
    );
  }

  PreferredSize get appbar => PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: AppBar(
          title: const Text("Task Manager"),
          centerTitle: true,
          backgroundColor: UIColorHelper.DEFAULT_COLOR,
        ),
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
            padding: const EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                MyTextFormField(
                  label: 'Name',
                  controller: _nameController,
                  nextButton: TextInputAction.next,
                ),
                const SizedBox(height: 10),
                MyTextFormField(
                  label: 'Description',
                  controller: _descriptionController,
                  lineCount: 2,
                  nextButton: TextInputAction.done,
                ),
                const SizedBox(height: 10),
                _taskList.length > 0
                    ? Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return showCard(
                              index,
                              _taskList[index].name,
                              _taskList[index].description,
                              _taskList[index].id,
                            );
                          },
                          itemCount: _taskList.length,
                        ),
                      )
                    : const NoSavedData(),
              ],
            ),
          ),
        ),
      );

  Widget get crudPanel => Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(child: addTaskButton),
            Expanded(child: updateTaskButton)
          ],
        ),
      );

  Widget showCard(int index, String name, String description, String id) =>
      GestureDetector(
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
        label: 'Update',
        color: Colors.cyanAccent,
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
  final Widget? widget;

  const TaskPanel({Key? key, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return widget ?? const SizedBox.shrink();
  }
}

class ErrorOccurred extends StatelessWidget {
  const ErrorOccurred({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text(MessageConstants.ERROR_OCCURED),
    );
  }
}

class NoSavedData extends StatelessWidget {
  const NoSavedData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.airline_seat_individual_suite,
          size: 55,
        ),
        const SizedBox(height: 15),
        Text(
          MessageConstants.NO_SAVED_DATA,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
