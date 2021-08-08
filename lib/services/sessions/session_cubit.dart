import 'package:citizen_feedback/blocs/auth/auth_bloc.dart';
import 'package:citizen_feedback/services/auth_credentials.dart';
import 'package:citizen_feedback/services/auth_repository.dart';
import 'package:citizen_feedback/services/sessions/session_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepo;
  final AuthBloc authBloc;

  SessionCubit({@required this.authRepo, @required this.authBloc}): super(UnknownSessionState()){
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    authBloc.add(AppStartedEvent());
    try{
      final userLoggedIn = await authRepo.hasToken();

      if(userLoggedIn) {
        final user = await authRepo.getCurrentLoggedInUser();
        showSession(AuthCredentials(username: user.username, user: user));
      } else {
        showAuth();
      }
    } catch (e) {
      emit(Unauthenticated());
    }
  }

  void showAuth() => emit(Unauthenticated());
  void showSession(AuthCredentials credentials) {
    authBloc.add(LoggedInEvent(accessToken: credentials.user.accessToken, currentUser: credentials.user));
    emit(Authenticated(user: credentials.user));
  }

  void logOut() {
    authRepo.logout();
    authBloc.add(LoggedOutEvent());
    emit(Unauthenticated());
  }

  void launchSession(AuthCredentials credentials) => showSession(credentials);
}
