import 'package:citizen_feedback/blocs/internet/internet_bloc.dart';
import 'package:citizen_feedback/screens/main_view.dart';
import 'package:citizen_feedback/screens/loading_view.dart';
import 'package:citizen_feedback/services/auth_navigator.dart';
import 'package:citizen_feedback/services/auth_repository.dart';
import 'package:citizen_feedback/services/sessions/session_cubit.dart';
import 'package:citizen_feedback/services/sessions/session_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/auth/auth_bloc.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      return Navigator(
        pages: [
          //Show loading screen
          if (state is UnknownSessionState) MaterialPage(child: LoadingView()),

          //Show auth screen
          if (state is Unauthenticated)
            MaterialPage(
              child: RepositoryProvider(
                create: (context) => AuthRepository(),
                child: BlocProvider(
                  create: (context) => AuthBloc(
                      authRepository: context.read<AuthRepository>(),
                      internetBloc: context.read<InternetBloc>()),
                  child: AuthNavigator(),
                ),
              ),
            ),

          //Show session flow
          if (state is Authenticated)
            MaterialPage(child: MyHomePage(title: "Citizen Feedback")),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
