import 'package:citizen_feedback/blocs/auth/auth_bloc.dart';
import 'package:citizen_feedback/theme/theme.dart';
import 'package:citizen_feedback/widgets/curved_widget.dart';
import 'package:flutter/material.dart';

class LayoutWidget extends StatelessWidget {
  final bool showBackButton;
  final String onBackClick;
  final AuthBloc authBloc;
  const LayoutWidget({Key key,this.showBackButton, this.onBackClick, this.authBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedWidget(
      child: Container(
        padding: const EdgeInsets.only(top: 100, left: 0),
        width: double.infinity,
        height: 800,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: Combination2),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: (showBackButton),
                  child : IconButton(
                    icon: new Icon(Icons.arrow_back_ios),
                    highlightColor: Colors.black,
                    onPressed: (){
                      if(onBackClick == 'showLogin') authBloc.showLogin();
                      if(onBackClick == 'showRegister') authBloc.showRegister();
                      },
                    padding: EdgeInsets.only(right: 50.0),
                  ),
                ),
                Image.asset('assets/images/logo.png',
                fit: BoxFit.contain, width: 200),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
