import 'package:citizen_feedback/models/poll_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListPoll extends StatelessWidget {
  final Poll poll;
  ListPoll({this.poll});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Polls'),
          Text('Poll.title', style: TextStyle(fontSize: 20.0),),
          Divider(),
        ],
      ),
    );
  }
}
