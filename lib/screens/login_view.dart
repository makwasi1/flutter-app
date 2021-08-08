import 'package:citizen_feedback/blocs/auth/auth_bloc.dart';
import 'package:citizen_feedback/blocs/form_submission_status.dart';
import 'package:citizen_feedback/blocs/internet/internet_bloc.dart';
import 'package:citizen_feedback/blocs/login/login_bloc.dart';
import 'package:citizen_feedback/blocs/login/login_event.dart';
import 'package:citizen_feedback/blocs/login/login_state.dart';
import 'package:citizen_feedback/services/auth_repository.dart';
import 'package:citizen_feedback/services/sessions/session_cubit.dart';
import 'package:citizen_feedback/theme/theme.dart';
import 'package:citizen_feedback/widgets/gradient_button.dart';
import 'package:citizen_feedback/widgets/layout_widget.dart';
import 'package:citizen_feedback/widgets/textfield_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(0),
          children: <Widget>[
            Stack(
              children: <Widget>[
                LayoutWidget(
                    showBackButton: false,
                    onBackClick: 'showRegister',
                    authBloc: context.read<AuthBloc>()),
                Container(
                  padding: const EdgeInsets.only(top: 235, left: 0),
                  child: BlocProvider(
                    create: (context) => LoginBloc(
                      context.read<AuthRepository>(),
                      context.read<AuthBloc>(),
                      context.read<SessionCubit>()
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(left: 60.0),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: LargeTextSize,
                                color: AccentColor,
                                fontFamily: HeadingFont,
                              ),
                            ),
                          ),
                        ),
                        _loginForm(),
                        SizedBox(
                          height: 13,
                        ),
                        _showSignUpButton(context),
                        SizedBox(
                          height: 20,
                        ),
                        GradientButton(
                          text: Text(
                            'Skip',
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          colors: CombinationGreen,
                          width: 200,
                          height: 45,
                          onPressed: () {
                            context.read<SessionCubit>().launchSession(AuthRepository().anonymous);
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginFormState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 40.0),
                  child: Text(
                    'Please add your phone number',
                    style: TextStyle(
                      fontSize: Body1TextSize,
                      color: Color(0xff005660),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              _phoneNumberField(),
              _passwordField(),
              _loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _phoneNumberField() {
    return BlocBuilder<LoginBloc, LoginFormState>(builder: (context, state) {
      return Column(children: <Widget>[
        SizedBox(
          height: 25,
        ),
        Container(
          width: 350,
          child: TextFormField(
            decoration: TextFieldDecoration(
                    prefixIcon: Icon(Icons.phone), hintText: 'Phone Number')
                .draw(),
            keyboardType: TextInputType.number,
            validator: (value) =>
                state.isValidPhoneNumber ? null : 'Phone Number is too short',
            onChanged: (value) => context
                .read<LoginBloc>()
                .add(LoginPhoneNumberChanged(username: value)),
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ]);
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginFormState>(builder: (context, state) {
      return Column(
        children: <Widget>[
          Container(
            width: 350,
            child: TextFormField(
              decoration: TextFieldDecoration(
                prefixIcon: Icon(Icons.security),
                hintText: 'Password',
              ).draw(),
              obscureText: true,
              validator: (value) =>
                  state.isValidPassword ? null : 'Password is too short',
              onChanged: (value) => context
                  .read<LoginBloc>()
                  .add(LoginPasswordChanged(password: value)),
            ),
          ),
          SizedBox(
            height: 25,
          ),
        ],
      );
    });
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginFormState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : GradientButton(
              text: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                Icons.login,
                color: Colors.white,
              ),
              colors: CombinationBlue,
              width: 200,
              height: 45,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  context.read<LoginBloc>().add(LoginSubmitted());
                }
              },
            );
    });
  }

  Widget _showSignUpButton(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Text('Don\'t have an account?'),
          SizedBox(
            height: 25,
          ),
          GradientButton(
            text: Text(
              'Register',
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(
              Icons.app_registration,
              color: Colors.white,
            ),
            colors: CombinationPink,
            width: 200,
            height: 45,
            onPressed: () => context.read<AuthBloc>().showRegister(),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
