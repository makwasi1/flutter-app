import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginFrmSubmittedEvent extends LoginEvent {
  final String username;
  final String password;

  LoginFrmSubmittedEvent({@required this.username, @required this.password});

  @override
  List<Object> get props => [username, password];

  @override
  String toString() => 'EmailLoginFrmSubmittedEvent { username: $username, password: $password }';
}

class LoginPhoneNumberChanged extends LoginEvent {
  final String username;

  LoginPhoneNumberChanged({this.username});
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged({this.password});
}

class LoginSubmitted extends LoginEvent {}

