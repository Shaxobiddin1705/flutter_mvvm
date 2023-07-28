import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  Utils._();

  static fieldFocusChange(
    BuildContext context,
    FocusNode current,
    FocusNode next,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static toastMessage({
    required String message,
    Toast? toastLength,
    double? fontSize,
    ToastGravity? gravity,
    Color? backgroundColor,
    Color? textColor,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      fontSize: fontSize,
      gravity: gravity,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }
}
