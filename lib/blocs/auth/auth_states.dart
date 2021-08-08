part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

//waiting to see if user is authenticated on app start
class NoInternet extends AuthState {}
class InternetConnected extends AuthState {}

//not authenticated
class AuthUninitialized extends AuthState {}

class AuthRegister extends AuthState {}

class AuthDeRegister extends AuthState {
  final String phonenumber;
  final String password;

  AuthDeRegister({@required this.phonenumber, @required this.password});

  @override
  List<Object> get props => [phonenumber, password];
}

class AuthConfirmation extends AuthState {}

//waiting to persist/delete a token
class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

// successfully authenticated
class AuthAuthenticated extends AuthState {
  final User currentUser;
  final String accessToken;

  AuthAuthenticated({@required this.currentUser, @required this.accessToken});

  @override
  List<Object> get props => [currentUser, accessToken];
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure({@required this.message});

  @override
  List<Object> get props => [message];
}
