import 'package:flutter/material.dart';
import 'strings.dart';

Future<void> alertDialog(BuildContext context, String alertTitle, String alertMessage) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(alertTitle),
        content: Text(alertMessage),
        actions: <Widget>[
          FlatButton(
            child: Text(Strings.ok),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
