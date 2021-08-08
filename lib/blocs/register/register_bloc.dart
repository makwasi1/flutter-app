import 'package:citizen_feedback/blocs/auth/auth_bloc.dart';
import 'package:citizen_feedback/blocs/register/register_event.dart';
import 'package:citizen_feedback/blocs/register/register_state.dart';
import 'package:citizen_feedback/services/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../form_submission_status.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepo;
  final AuthBloc authBloc;

  RegisterBloc({this.authRepo, this.authBloc}) : super(RegisterState());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    //phonenumber is updated
    if (event is RegisterPhoneNumberChanged) {
      yield state.copyWith(phonenumber: event.phonenumber);

      //firstname is updated
    } else if (event is RegisterFirstNameChanged) {
      yield state.copyWith(firstname: event.firstname);

      //secondname is updated
    } else if (event is RegisterSecondNameChanged) {
      yield state.copyWith(secondname: event.secondname);

      //region is updated
    } else if (event is RegisterRegionChanged) {
      yield state.copyWith(region: event.region);

      //district is updated
    } else if (event is RegisterDistrictChanged) {
      yield state.copyWith(district: event.district);

      //form submitted
    } else if (event is RegisterSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final status = await authRepo.register(
            phonenumber: state.phonenumber,
            password: state.password != "" ? state.password : '1234',
            firstname: state.firstname,
            secondname: state.secondname,
            region: state.region,
            district: state.district);
        if(status == "Reporter registered") {
          yield state.copyWith(formStatus: SubmissionSuccess());

          authBloc.showConfirmation(
            phonenumber: state.phonenumber,);
        } else {
          print("Failed to Register");
          yield state.copyWith(formStatus: SubmissionFailed());
        }

      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(exception: e));
      }
    }
  }
}
