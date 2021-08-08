part of 'auth_bloc.dart';

///Check if someone is logged in
abstract class AuthEvents extends Equatable {
  const AuthEvents();

  @override
  List<Object> get props => [];
}

// Fired just after the app is launched
class AppStartedEvent extends AuthEvents {
  @override
  String toString() => "AppStartedEvent";
}

// Fired when a user has successfully logged in
class LoggedInEvent extends AuthEvents {
  final User currentUser;
  final String accessToken;
  LoggedInEvent({this.accessToken, this.currentUser});

  @override
  List<Object> get props => [currentUser, accessToken];

  @override
  String toString() => "LoggedIn";
}

// Fired when the user has logged out
class LoggedOutEvent extends AuthEvents {
  @override
  String toString() => "LoggedOutEvent";
}

class NoInternetEvent extends AuthEvents {
  @override
  String toString() => "NoInternetEvent";
}
class InternetConnectedEvent extends AuthEvents {
  @override
  String toString() => "InternetConnectedEvent";
}

// Fired when the user has logged out
class DeRegisterEvent extends AuthEvents {
  @override
  String toString() => "DeRegisterEvent";
}
