import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:citizen_feedback/blocs/auth/auth_bloc.dart';
import 'package:citizen_feedback/services/auth_credentials.dart';
import 'package:citizen_feedback/services/sessions/session_cubit.dart';
import 'package:citizen_feedback/shared/exceptions/app_exception.dart';
import '../../services/auth_repository.dart';
import '../form_submission_status.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginFormState> {
  final AuthRepository _authRepository;
  final AuthBloc _authBloc;
  final SessionCubit _sessionCubit;

  LoginBloc(AuthRepository authRepository, AuthBloc authBloc, SessionCubit sessionCubit)
      : assert(authRepository != null),
        assert(authBloc != null),
        _authRepository = authRepository,
        _authBloc = authBloc,
        _sessionCubit = sessionCubit,
        super(LoginFormState());

  @override
  Stream<LoginFormState> mapEventToState(LoginEvent event) async* {
    //phone number is updated
    if (event is LoginPhoneNumberChanged) {
      yield state.copyWith(phoneNumber: event.username);

    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);
      //form submitted
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      //yield LoginLoading();

      try {
        final user = await _authRepository.login(state.phonenumber, state.password);
        if (user != null) {
          _authBloc.add(
              LoggedInEvent(accessToken: user.accessToken, currentUser: user));
         // yield LoginSuccess();
          yield state.copyWith(formStatus: SubmissionSuccess());
          _sessionCubit.launchSession(AuthCredentials(username: state.phonenumber, user: user ));
        } else {
          //yield LoginFailure(error: "Error while logging in..");
          yield state.copyWith(formStatus: SubmissionFailed());
        }
      } on UnauthorisedException catch (e) {
        //yield LoginFailure(error: e.message);
        yield state.copyWith(formStatus: SubmissionFailed(exception: e));
      } catch (err, stackTrace) {
        print(err);
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }

}
