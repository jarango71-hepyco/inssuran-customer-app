import 'package:flutter/material.dart';

import '../utils/constants.dart';

class MessageDialogs {

  static Future<void> showDialogMessage(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          title: const Text(Consts.S_ALRDLG_HEADER_MSG),
          content: Text(message, style: const TextStyle(fontSize: 15.0)),
          actions: <Widget>[
            TextButton(
              child: Text(Consts.S_BTN_OK.toUpperCase(), style: const TextStyle(color: Color(Consts.C_LIGHTCOLOR), fontWeight: FontWeight.bold, fontSize: 15)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showDialogWarning(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          title: const Text(Consts.S_ALRDLG_HEADER_WARNING),
          content: Text(message, style: const TextStyle(fontSize: 15)),
          actions: <Widget>[
            TextButton(
              child: Text(Consts.S_BTN_OK.toUpperCase(), style: const TextStyle(color: Color(Consts.C_LIGHTCOLOR), fontWeight: FontWeight.bold, fontSize: 15.0)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showDialogWError(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          title: const Text(Consts.S_ALRDLG_HEADER_ERROR),
          content: Text(message, style: const TextStyle(fontSize: 15)),
          actions: <Widget>[
            TextButton(
              child: Text(Consts.S_BTN_OK.toUpperCase(), style: const TextStyle(color: Color(Consts.C_LIGHTCOLOR), fontWeight: FontWeight.bold, fontSize: 15.0)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showDialogMessageFocus(BuildContext context, String message, FocusNode usernameFocusNode) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 10),
          title: Text(Consts.S_ALRDLG_HEADER_MSG),
          content: Text(message, style: TextStyle(fontSize: 15)),
          actions: <Widget>[
            TextButton(
              child: Text(Consts.S_BTN_CONTINUE.toUpperCase(), style: TextStyle(color: Color(Consts.C_LIGHTCOLOR), fontWeight: FontWeight.bold, fontSize: 15.0)),
              onPressed: () {
                usernameFocusNode.requestFocus();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}