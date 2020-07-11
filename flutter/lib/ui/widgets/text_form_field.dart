import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String label;
  final TextInputType textInputType;
  final TextStyle textStyle;
  final Function validationFunction;
  final Function onsavedGelenDeger;
  final TextEditingController controller;
  final int lineCount;
  final String willBeSavedValue;
  final bool password;
  final int characterLenght;
  final FontWeight fontWeight;
  final TextInputAction nextButton;
  final IconButton trailingIcon;
  final Function onFieldSubmitted;
  final FocusNode focusNode;
  final bool autoFocus;
  final bool autoValidate;
  final Function onTap;
  final String labelText;
  final Icon prefixIcon;

  const MyTextFormField(
      {Key key,
      this.label,
      this.focusNode,
      this.onFieldSubmitted,
      this.nextButton,
      this.trailingIcon,
      this.textStyle,
      this.fontWeight,
      this.textInputType,
      this.willBeSavedValue,
      this.password,
      this.controller,
      this.lineCount,
      this.validationFunction,
      this.characterLenght,
      this.onsavedGelenDeger,
      this.autoFocus,
      this.autoValidate,
      this.onTap,
      this.labelText,
      this.prefixIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: this.onTap,
      autovalidate: this.autoValidate ?? false,
      autofocus: this.autoFocus ?? false,
      focusNode: this.focusNode,
      onFieldSubmitted: this.onFieldSubmitted,
      textInputAction: this.nextButton,
      obscureText: this.password ?? false,
      maxLines: this.lineCount,
      maxLength: this.characterLenght,
      controller: this.controller,
      validator: this.validationFunction,
      onSaved: this.onsavedGelenDeger,
      style: this.textStyle,
      keyboardType: this.textInputType,
      decoration: InputDecoration(
        suffixIcon: this.trailingIcon,
        hintText: this.label,
        labelText: this.labelText,
        labelStyle: TextStyle(color: Colors.black, fontSize: 7),
        prefixIcon: this.prefixIcon,
        hintStyle: TextStyle(fontWeight: this.fontWeight),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black,
              width: MediaQuery.of(context).size.width * (0.001)),
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * (0.02),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black,
              width: MediaQuery.of(context).size.width * (0.003)),
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * (0.02),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black,
              width: MediaQuery.of(context).size.width * (0.003)),
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * (0.02),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black,
              width: MediaQuery.of(context).size.width * (0.003)),
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * (0.02),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black,
              width: MediaQuery.of(context).size.width * (0.003)),
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * (0.02),
          ),
        ),
      ),
    );
  }
}
