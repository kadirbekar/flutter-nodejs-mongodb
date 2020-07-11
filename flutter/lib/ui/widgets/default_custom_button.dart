import 'package:flutter/material.dart';

import '../common/ui_color_helper.dart';

class DefaultRaisedButton extends StatelessWidget {
  final String label;
  final double height;
  final double width;
  final double leftBorderRadiusValue;
  final double rightBorderRadiusValue;
  final Function onPressed;
  final TextStyle textStyle;
  final Color color;

  const DefaultRaisedButton(
      {this.label,
      this.height,
      this.width,
      this.leftBorderRadiusValue,
      this.rightBorderRadiusValue,
      this.onPressed,
      this.textStyle,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      color: Colors.white,
      width: this.width,
      child: RaisedButton(
        color: UIColorHelper.DEFAULT_COLOR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(leftBorderRadiusValue ?? 15),
            topRight: Radius.circular(rightBorderRadiusValue ?? 15),
          ),
        ),
        onPressed: this.onPressed,
        child: Text(
          this.label ?? "Unnamed",
          style: TextStyle(color: Colors.white,fontSize: 17.0),
        ),
      ),
    );
  }
}
