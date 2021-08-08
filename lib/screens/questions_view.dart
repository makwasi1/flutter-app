import 'package:citizen_feedback/models/poll_model.dart';
import 'package:citizen_feedback/shared/exceptions/app_exception.dart';
import 'package:citizen_feedback/shared/utilities.dart';
import 'package:citizen_feedback/theme/theme.dart';
import 'package:citizen_feedback/widgets/main_appbar.dart';
import 'package:citizen_feedback/widgets/polls/questions_widget.dart';
import 'package:flutter/material.dart';

class QuestionsView extends StatelessWidget {
  final List<Question> questions;

  const QuestionsView({Key key,@required this.questions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   /* WillPopScope(
      onWillPop: Utilities().onBackPressed(context),
      child:*/
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: MainAppBar(
          title: "Poll - Question",
        ),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: Combination1,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 100, left: 0),
            width: double.infinity,
            height: 800,
            color: FaintBlue,
            child: Column(
              children: listOfQuestions(),
            ),
          ),
        ),
      //),
    );
  }

  List<Widget> listOfQuestions(){
    List<Widget> list = <Widget>[];
    if(questions!=null) {
      questions.forEach((element) {
        list.add(QuestionsWidget(
            questionType: getQuestionType(element.qnsType),
            question: element.qns,
            choices: element.choices,
        ));
      });
      return list;
    } else {
      throw NoQuestionsException('No Questions Available');
    }
  }

  QuestionType getQuestionType(int type){
    switch(type){
      case 1:
        return QuestionType.open;
        break;
      case 2:
        return QuestionType.open;
        break;
      case 3: return
        QuestionType.open;
      break;
      default:
        return QuestionType.open;
        break;
    }
  }

}
