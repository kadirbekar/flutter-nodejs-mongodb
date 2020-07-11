import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToastMessage {
  static void showCenterShortToast(String content) {
    Fluttertoast.showToast(
      msg: content,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 18,
      textColor: Colors.white,
      timeInSecForIosWeb: 1,
    );
  }
}
