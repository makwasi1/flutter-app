import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:citizen_feedback/models/poll_model.dart';
import 'package:citizen_feedback/theme/theme.dart';
import 'package:flutter/material.dart';

class MultipleSelectQuestions extends StatefulWidget {
  final String question;
  final List<Choice> choices;

  const MultipleSelectQuestions({Key key,@required this.question, @required this.choices}) : super(key: key);

  @override
  _MultipleSelectState createState() => _MultipleSelectState();
}

class _MultipleSelectState extends State<MultipleSelectQuestions> {
  final GroupController controller = GroupController(isMultipleSelection: true);
  var value = [];

  @override
  void initState() {
    super.initState();
    listenToChangedValues();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 40.0),
            child: Text(
              'What is this multiple?',
              style: TextStyle(
                fontSize: MediumTextSize,
                color: Color(0xff005660),
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        SimpleGroupedCheckbox<int>(
          controller: controller,
          itemsTitle: ["Item 1", "Item 2", "Item 4", "Item 5"],
          values: [1, 2, 4, 5],
          groupStyle: GroupStyle(
              activeColor: Turquoise, itemTitleStyle: TextStyle(fontSize: 13)),
          checkFirstElement: false,
          onItemSelected: (data) {
            setState(() {
              this.value.add(data);
            });
            if (data == 1) {
              controller.disabledItemsByTitles(["5"]);
            } else if (data == 4) {
              controller.enabledItemsByTitles(["5", "2"]);
              controller.disabledItemsByTitles(["1"]);
            } else if (data == 2) {
              controller.enabledItemsByTitles(["1"]);
            }
          },
        ),
      ]),
    );
  }

  void getSelectedValues() {
    final selectedItems = controller.selectedItem;
  }

  void listenToChangedValues() {
    controller.listen((v) {
      setState(() {
        this.value.add(v);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
