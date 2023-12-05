import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingScreen {
  static Future<dynamic> showLoadingScreen(
      BuildContext context, String text, bool dismissible) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    width: 10,
                  ),
                  Text(text)
                ],
              ),
            ),
        barrierDismissible: dismissible);
  }
}
