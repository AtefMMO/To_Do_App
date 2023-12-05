
import 'package:flutter/material.dart';

class AlertMessage {
  static Future<dynamic> showLoadingScreen(
      BuildContext context, String text, bool dismissible) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content:
              Text(text)
        ),
        barrierDismissible: dismissible);
  }
}