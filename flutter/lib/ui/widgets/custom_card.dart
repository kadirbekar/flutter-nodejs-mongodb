import 'package:flutter/material.dart';

import '../common/ui_color_helper.dart';

class CustomCard extends StatelessWidget {
  final int index;
  final String name;
  final String description;
  final Function function;
  const CustomCard(
      {Key key,
      @required this.index,
      @required this.name,
      @required this.description,
      this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: UIColorHelper.DEFAULT_COLOR,
            child: Text(index.toString()),
          ),
          title: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(description),
          trailing: IconButton(
            icon: Icon(
              Icons.delete_forever,
              color: Colors.red,
              size: 40,
            ),
            onPressed: this.function,
          ),
        ),
      ),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
