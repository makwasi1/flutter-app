import 'package:citizen_feedback/blocs/auth/auth_bloc.dart';
import 'package:citizen_feedback/screens/confirmation_view.dart';
import 'package:citizen_feedback/screens/main_view.dart';
import 'package:citizen_feedback/screens/loading_view.dart';
import 'package:citizen_feedback/screens/login_view.dart';
import 'package:citizen_feedback/screens/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthNavigator extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state){
      return Navigator(
        pages: [
          //Show loading screen
          if (state == AuthLoading()) MaterialPage(child: LoadingView()),

          //Show Login
          if (state == AuthUninitialized()) MaterialPage(child: LoginView()),

          //Allow push animation
          if(state == AuthRegister() || state == AuthConfirmation()) ...[
            //show register
            MaterialPage(child: RegisterView()),

            //show confirm register
            if(state == AuthConfirmation())
              MaterialPage(child: ConfirmationView()),
          ],

          //Show Home
          if (state == AuthSuccess())  MaterialPage(child: MyHomePage(title: "Citizen Feedback")),

          if (state == AuthDeRegister()) MaterialPage(child: LoginView()),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
