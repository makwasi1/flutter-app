import 'package:citizen_feedback/blocs/auth/auth_bloc.dart';
import 'package:citizen_feedback/blocs/confirmation/confirmation_event.dart';
import 'package:citizen_feedback/blocs/confirmation/confirmation_state.dart';
import 'package:citizen_feedback/blocs/counter/count_down.dart';
import 'package:citizen_feedback/theme/theme.dart';
import '../blocs/confirmation/confirmation_bloc.dart';
import 'package:citizen_feedback/blocs/form_submission_status.dart';
import 'package:citizen_feedback/services/auth_repository.dart';
import 'package:citizen_feedback/widgets/gradient_button.dart';
import 'package:citizen_feedback/widgets/layout_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

class ConfirmationView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
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
                    create: (context) => ConfirmationBloc(
                      authRepo: context.read<AuthRepository>(),
                      authBloc: context.read<AuthBloc>(),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        _confirmationForm(),
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

  Widget _confirmationForm() {
    return BlocListener<ConfirmationBloc, ConfirmationState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Confirmation code',
                      style: TextStyle(
                        fontSize: LargeTextSize,
                        color: AccentColor,
                        fontFamily: HeadingFont,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'A 4 Digit-Pin ha been sent to your phone number, Enter it below to continue',
                      style: TextStyle(fontSize: Body1TextSize),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              _codeField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _codeField() {
    return BlocBuilder<ConfirmationBloc, ConfirmationState>(
        builder: (context, state) {
      return Column(
        children: <Widget>[
          VerificationCode(
            textStyle: TextStyle(fontSize: 20.0, color: Colors.teal[900]),
            underlineColor: Colors.teal,
            keyboardType: TextInputType.number,
            length: 4,
            // clearAll is NOT required, you can delete it
            // takes any widget, so you can implement your design
            clearAll: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  CountDown(seconds: 30),
                  SizedBox(
                    height: 25,
                  ),
                  _confirmButton(),
                ],
              ),
            ),
            onCompleted: (value) => context
                .read<ConfirmationBloc>()
                .add(ConfirmationCodeChanged(code: value)),

            onEditing: (bool value) =>
                context.read<ConfirmationBloc>().add(ConfirmationEditing()),
          ),
          SizedBox(
            height: 25,
          ),
        ],
      );
    });
  }

  Widget _confirmButton() {
    return BlocBuilder<ConfirmationBloc, ConfirmationState>(
        builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : GradientButton(
              text: Text(
                'Verify',
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                Icons.code,
                color: Colors.white,
              ),
              colors: CombinationBlue,
              width: 150,
              height: 45,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  context.read<ConfirmationBloc>().add(ConfirmationSubmitted());
                }
              },
            );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
