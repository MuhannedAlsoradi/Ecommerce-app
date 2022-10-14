// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/home_model.dart';

TextFormField defualtTextField({
  required TextEditingController controller,
  required TextInputType textInputType,
  required String labelText,
  required String? Function(String?) validator,
  required IconData prefixIcon,
  IconData? suffixIcon,
  void Function()? onPressed,
  bool isPassword = false,
  void Function(String)? onSubmit,
  void Function(String)? onChanged,
  TextStyle? style,
  bool autoFocus = false,
}) {
  return TextFormField(
    onChanged: onChanged,
    autofocus: autoFocus,
    style: style,
    controller: controller,
    obscureText: isPassword,
    onFieldSubmitted: onSubmit,
    decoration: InputDecoration(
      labelStyle: TextStyle(
        color: Colors.grey,
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: Colors.grey,
      ),
      suffixIcon: IconButton(
        onPressed: onPressed,
        icon: Icon(
          suffixIcon,
          color: Colors.grey,
        ),
      ),
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: Colors.grey[300]!,
          width: 0.3,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: Colors.grey[300]!,
          width: 1.5,
        ),
      ),
    ),
    validator: validator,
    keyboardType: textInputType,
  );
}

void navigateAndFinish({context, required Widget widget}) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

Future<bool?> showToast({required String ms, required ToastStates state}) =>
    Fluttertoast.showToast(
      msg: ms,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: buildToastColor(state: state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates {
  WARNING,
  SUCCUSS,
  ERROR,
}

Color buildToastColor({required ToastStates state}) {
  Color? color;
  switch (state) {
    case ToastStates.SUCCUSS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }

  return color;
}

dynamic calculateDiscount(model) {
  dynamic discount;
  discount =
      ((model.oldPrice.round() - model.price.round()) / model.price.round()) *
          100;
  return discount.floor();
}
