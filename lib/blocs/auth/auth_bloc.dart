import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:citizen_feedback/blocs/internet/internet_bloc.dart';
import 'package:citizen_feedback/blocs/internet/internet_state.dart';
import 'package:citizen_feedback/services/auth_credentials.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../services/auth_repository.dart';

part 'auth_events.dart';

part 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  final AuthRepository authRepository;
  final InternetBloc internetBloc;
  StreamSubscription internetStreamSubscription;
  AuthCredentials credentials;

  AuthBloc({@required this.internetBloc, @required this.authRepository})
      : super(AuthUninitialized()) {
    initAuthBloc();
  }

  AuthState get initialState => AuthUninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvents event) async* {
    if (event is AppStartedEvent) {
      yield* _mapAppStartedEventToState(event);
    } else if (event is LoggedInEvent) {
      //get the current user details
      yield* _mapUserLoggedInToState(event);
    } else if (event is LoggedOutEvent) {
      //delete the current token and user details
      yield* _mapUserLoggedOutToState(event);
    } else if (event is NoInternetEvent) {
      //delete the current token and user details
      yield NoInternet();
    } else if (event is NoInternetEvent) {
      yield InternetConnected();
    } else {
      yield AuthUninitialized();
    }
  }

  Stream<AuthState> _mapAppStartedEventToState(AppStartedEvent event) async* {
    yield AuthLoading();
    try {
      final String currentUserToken = await authRepository.getCurrentUserToken();
      final User currentUser = await authRepository.getCurrentLoggedInUser();
      authRepository.downloadDistricts();
      authRepository.downloadRegions();


    if (currentUserToken != null && currentUser != null) {
        yield AuthAuthenticated(currentUser: currentUser, accessToken: currentUserToken);
        yield AuthSuccess();
      } else {
        yield AuthUninitialized();
      }
    } catch (e) {
      yield AuthFailure(message: e ?? 'An unknown error occurred');
    }
  }

  Stream<AuthState> _mapUserLoggedInToState(LoggedInEvent event) async* {
    await authRepository.storeLoggedInUser(event.currentUser);
    yield AuthAuthenticated(currentUser: event.currentUser, accessToken: event.accessToken);
    yield AuthSuccess();
  }

  Stream<AuthState> _mapUserLoggedOutToState(LoggedOutEvent event) async* {
    yield AuthLoading();
    await authRepository.logout();
    yield AuthUninitialized();
  }

  @override
  Future<void> close() {
    if (this.internetBloc != null) this.internetBloc.close();
    if (this.internetStreamSubscription != null)
    this.internetStreamSubscription.cancel();
    return super.close();
  }

  ///Start listening to the stream
  void initAuthBloc() {
    if (internetBloc == null) {
      return;
    }
    internetStreamSubscription = internetBloc.stream.listen((state) {
      if (state is InternetDisconnected) {
        add(NoInternetEvent());
      } else if (state is InternetConnected) {
        add(InternetConnectedEvent());
      }
    });
  }

  void showLogin() => emit(AuthUninitialized());
  void showRegister() => emit(AuthRegister());
  void showConfirmation({
    String phonenumber,
  }) {
    credentials = AuthCredentials(
      username: phonenumber,
    );
    emit(AuthConfirmation());
  }
  void deRegisterReporter(AuthDeRegister authDeRegisterState){
    authRepository.deRegisterReporter(
      username: authDeRegisterState.phonenumber,
      password: authDeRegisterState.password,
    );
    emit(authDeRegisterState);
  }
}
