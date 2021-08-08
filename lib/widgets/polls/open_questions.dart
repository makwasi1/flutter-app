import 'package:citizen_feedback/theme/theme.dart';
import 'package:flutter/material.dart';

class OpenQuestions extends StatefulWidget {
  final String question;

  const OpenQuestions({Key key,@required this.question}) : super(key: key);

  @override
  _OpenQuestionsState createState() => _OpenQuestionsState();
}

class _OpenQuestionsState extends State<OpenQuestions> {
  var value = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 40.0),
              child: Text(
                'What is this open?',
                style: TextStyle(
                  fontSize: MediumTextSize,
                  color: Color(0xff005660),
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Container(
            width: 350,
            child: TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.edit),
                  hintText: 'Put your answere here'),
              keyboardType: TextInputType.number,
              validator: (value) {},
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}
