import 'package:flutter/material.dart';

class Utilities {
  humanize(String s) {
    return s[0].toUpperCase() + s.substring(1);
  }

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  dynamic onBackPressed(context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text("Do you really want to exit the app?"),
          actions: <Widget>[
            FlatButton(
              child: Text("No"),
              onPressed: () => Navigator.pop(context, false),
            ),
            FlatButton(
              child: Text("Yes"),
              onPressed: () => Navigator.pop(context, true),
            ),
          ]),
    );
  }
}
