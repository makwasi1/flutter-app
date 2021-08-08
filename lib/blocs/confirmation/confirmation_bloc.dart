import 'package:citizen_feedback/blocs/auth/auth_bloc.dart';
import 'package:citizen_feedback/services/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'confirmation_event.dart';
import 'confirmation_state.dart';
import '../form_submission_status.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final AuthRepository authRepo;
  final AuthBloc authBloc;

  ConfirmationBloc({this.authRepo, this.authBloc}): super(ConfirmationState());

  @override
  Stream<ConfirmationState> mapEventToState(ConfirmationEvent event) async* {
    //confirmation code is updated
    if(event is ConfirmationCodeChanged){
      yield state.copyWith(code: event.code);

      //form submitted
    } else if(event is ConfirmationSubmitted){
      yield state.copyWith(formStatus: FormSubmitting());

      try{
        //final user = await authRepo.sendVerifyToken(state.code, 'loginForm widget');
        yield state.copyWith(formStatus: SubmissionSuccess());

        final credentials = authBloc.credentials;
        //credentials.userId = user['id'];

        authBloc.showLogin();
      }catch(e){
        yield state.copyWith(formStatus: SubmissionFailed(exception: e));
      }
    }
  }
}
