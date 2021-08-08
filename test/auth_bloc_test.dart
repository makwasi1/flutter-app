/*
import 'package:citizen_feedback/blocs/auth/auth_bloc.dart';
import 'package:citizen_feedback/blocs/internet/internet_bloc.dart';
import 'package:citizen_feedback/blocs/internet/internet_state.dart';
import 'package:citizen_feedback/models/user.dart';
import 'package:citizen_feedback/services/auth_repository.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AuthBloc authBloc;
  InternetBloc internetBloc;
  AuthRepository mockRepository;
  setUp(() {
    mockRepository = MockAuthRepository();
    internetBloc= InternetBloc(InternetLoading(), Connectivity());
    authBloc = AuthBloc(internetBloc:internetBloc,authRepository: mockRepository);
  });
  tearDown(() {
    authBloc?.close();
  });
  blocTest<AuthBloc, AuthState>(
    "initial state is AuthAuthenticated when users are saved in local storage",
    build: () {
      when(mockRepository.getCurrentUserToken())
          .thenAnswer((_) async => "abcdef");
      when(mockRepository.getCurrentLoggedInUser()).thenAnswer((_) async =>
          User(username: 'vkakama', password: 'pass', accessToken: "abcdef"));
      return authBloc;
    },
    act: (authBloc) => authBloc.add(AppStartedEvent()),
    expect: () => [
      AuthLoading(),
      AuthAuthenticated(
          currentUser: User(
              username: 'vkakama', password: 'pass', accessToken: "abcdef"),
          accessToken: "abcdef")
    ],
  );
  blocTest<AuthBloc, AuthState>(
    "test that initial state is AuthUnAuthenticated if token is missing",
    build: () {
      when(mockRepository.getCurrentLoggedInUser()).thenAnswer((_) async =>
          User(username: 'vkakama', password: 'pass', accessToken: "abcdef"));
      return authBloc;
    },
    act: (authBloc) => authBloc.add(AppStartedEvent()),
    expect: () => [AuthLoading(), AuthNotAuthenticated()],
  );
  blocTest<AuthBloc, AuthState>(
    "test that initial state is AuthUnAuthenticated if User is missing",
    build: () {
      when(mockRepository.getCurrentUserToken())
          .thenAnswer((_) async => "abcdef");
      return authBloc;
    },
    act: (authBloc) => authBloc.add(AppStartedEvent()),
    expect: () => [AuthLoading(), AuthNotAuthenticated()],
  );
  blocTest<AuthBloc, AuthState>(
    "test State is Authenticated when logged in",
    build: () {
      when(mockRepository.storeLoggedInUser(User(
          username: 'vkakama', password: 'pass', accessToken: "abcdef")))
          .thenAnswer((_) async => null);
      return authBloc;
    },
    act: (authBloc) => authBloc.add(LoggedInEvent(
        accessToken: "abcdef",
        currentUser: User(
            username: 'vkakama', password: 'pass', accessToken: "abcdef"))),
    expect: () => [
      AuthAuthenticated(
          currentUser: User(
              username: 'vkakama', password: 'pass', accessToken: "abcdef"),
          accessToken: "abcdef")
    ],
  );
  blocTest<AuthBloc, AuthState>(
    "test state is AuthNotAuthenticated when logged out",
    build: () {
      when(mockRepository.logout())
          .thenAnswer((_) async => null);
      return authBloc;
    },
    act: (authBloc) => authBloc.add(LoggedOutEvent()),
    expect: () => [AuthLoading(), AuthNotAuthenticated()],
  );

}
*/
