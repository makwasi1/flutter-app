import 'package:citizen_feedback/app_navigator.dart';
import 'package:citizen_feedback/blocs/auth/auth_bloc.dart';
import 'package:citizen_feedback/services/auth_navigator.dart';
import 'package:citizen_feedback/services/auth_repository.dart';
import 'package:citizen_feedback/services/sessions/session_cubit.dart';
import 'package:citizen_feedback/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reflectable/reflectable.dart';
import 'blocs/internet/internet_bloc.dart';
import 'main.reflectable.dart';

class MyReflectable extends Reflectable {
  const MyReflectable() : super(invokingCapability);
}

const myReflectable = MyReflectable();


void main() {
  // The program execution must start run this initialization before
  // any reflective features can be used.
  initializeReflectable();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Citizen Feedback',
      theme: ThemeData(
        primarySwatch: turquoise,
        fontFamily: BodyFont,
      ),
     // home: MyHomePage(title: 'Welcome to Citizen Feedback App'),
      home: RepositoryProvider(
        create: (context) => AuthRepository(),
        child: BlocProvider(
          create: (context) => AuthBloc(authRepository: context.read<AuthRepository>(), internetBloc: InternetBloc()),
          child: BlocProvider(
            create: (context) => SessionCubit(authRepo: context.read<AuthRepository>(), authBloc: context.read<AuthBloc>()),
            child: AuthNavigator(),
          ),
        ),
      ),
    );
  }
}
