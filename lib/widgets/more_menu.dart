import 'package:citizen_feedback/blocs/auth/auth_bloc.dart';
import 'package:citizen_feedback/shared/utilities.dart';
import 'package:citizen_feedback/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoreMenu extends StatefulWidget {
  MoreMenu({Key key, this.context}) : super(key: key);
  final BuildContext context;
  @override
  _MoreMenuState createState() => _MoreMenuState();
}

class _MoreMenuState extends State<MoreMenu> {
  TextEditingController _textFieldController = TextEditingController();
  String valueText;
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails tapDownDetails) => onTapDown(
        widget.context,
        tapDownDetails,
      ),
      child: Icon(
        Icons.more_horiz,
        size: 35.0,
      ),
    );
  }

  List<PopupMenuEntry<dynamic>> getMenuItems() => [
        //PopupMenuItem(value: 'option 1', child: Text('option 1')),
        //PopupMenuItem(value: 'option 2', child: Text('option 2')),
        PopupMenuItem(
            value: 'option 3',
            child: Text(
              'Deactivate Account',
              style: TextStyle(color: Colors.red),
            ))
      ];

  void onTapDown(
    BuildContext context,
    TapDownDetails tapDownDetailsDetails,
  ) {
    final double pressX = tapDownDetailsDetails.globalPosition.dx,
        pressY = tapDownDetailsDetails.globalPosition.dy;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(pressX, pressY, pressX, pressY),
      items: getMenuItems(),
    ).then(
      (value) => performSelectedAction(context, value),
    );
  }

  Future<dynamic> performSelectedAction(BuildContext context, dynamic option) {
    switch (option) {
      case 'option 1':
        print('option 1');
        break;
      case 'option 2':
        print('option 2');
        break;
      case 'option 3':
        promptDialog(context);
        break;
      default:
        break;
    }
    return null;
  }

  Future<void> promptDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure you want to deactivate your account?'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(
                  hintText: 'Put password to confirm',
                  prefixIcon: Icon(Icons.security)),
              obscureText: !this._showPassword,
              obscuringCharacter: '•',
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('No', style: TextStyle(color: Turquoise)),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  }),
              FlatButton(
                child: Text('Yes', style: TextStyle(color: Turquoise)),
                onPressed: () {
                  if (valueText != null) {
                    BlocProvider.of<AuthBloc>(context).deRegisterReporter(AuthDeRegister(
                        phonenumber: '0777777777', password: valueText));
                  } else {
                    Utilities().showSnackBar(context, "Please put password");
                  }
                },
              ),
            ],
          );
        });
  }
}
