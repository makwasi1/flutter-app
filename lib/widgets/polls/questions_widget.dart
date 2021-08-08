import 'package:citizen_feedback/models/poll_model.dart';
import 'package:citizen_feedback/widgets/polls/mulitple_select_questions.dart';
import 'package:citizen_feedback/widgets/polls/open_questions.dart';
import 'package:citizen_feedback/widgets/polls/single_select_questions.dart';
import 'package:flutter/material.dart';

enum QuestionType { single, multiple, open }

class QuestionsWidget extends StatefulWidget {
  final QuestionType questionType;
  final String question;
  final List<Choice> choices;

  QuestionsWidget({@required this.questionType,@required this.question, this.choices});

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<QuestionsWidget> {

  @override
  Widget build(BuildContext context) {
    switch (widget.questionType) {
      case QuestionType.single:
        return Column(children: <Widget>[
          SingleSelectQuestions(question: widget.question, choices: widget.choices),
        ]);
        break;

      case QuestionType.multiple:
        return Column(children: <Widget>[
          MultipleSelectQuestions(question: widget.question, choices: widget.choices),
        ]);
        break;

      case QuestionType.open:
        return Column(children: <Widget>[
          OpenQuestions(question: widget.question),
        ]);
        break;

      default:
        return null;
    }
  }
}
