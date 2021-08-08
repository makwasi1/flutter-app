import '../form_submission_status.dart';

class LoginFormState {
  final String phonenumber;
  final String password;
  bool get isValidPhoneNumber => phonenumber.length > 9;
  bool get isValidPassword => password.length > 3;

  final FormSubmissionStatus formStatus;

  LoginFormState({
    this.phonenumber = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginFormState copyWith({
    String phoneNumber,
    String password,
    FormSubmissionStatus formStatus,
  }) {
    return LoginFormState(
      phonenumber: phoneNumber ?? this.phonenumber,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}

///the initial state for our login form
class LoginInitial extends LoginFormState {}
///the state when our form is validating the credentials
class LoginLoading extends LoginFormState {}
class LoginSuccess extends LoginFormState {}
class LoginFailure extends LoginFormState {
  final String error;

  LoginFailure({this.error});
}
