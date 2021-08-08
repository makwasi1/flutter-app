import 'dart:io';

import 'package:citizen_feedback/blocs/auth/auth_bloc.dart';
import 'package:citizen_feedback/blocs/polling/poll_event.dart';
import 'package:citizen_feedback/blocs/polling/poll_state.dart';
import 'package:citizen_feedback/models/poll_model.dart';
import 'package:citizen_feedback/services/auth_repository.dart';
import 'package:citizen_feedback/services/poll_repository.dart';
import 'package:citizen_feedback/services/sessions/session_cubit.dart';
import 'package:citizen_feedback/shared/exceptions/app_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../form_submission_status.dart';

class PollBloc extends Bloc<PollEvent, PollState> {
  final PollRepository pollRepository;
  List<Poll> polls;


  PollBloc({this.pollRepository})
      : super(PollInitialState());

  @override
  Stream<PollState> mapEventToState(PollEvent event) async* {
    switch (event) {
      case PollEvent.fetchPolls:
        yield PollLoadingState();
        try {
          polls = await pollRepository.getPolls();
          yield PollLoadedState(polls: polls);
        } on SocketException {
          yield PollListError(
            errors: NoPollsException()
          );
        } on HttpException {
          yield PollListError(
            errors: UnknownResponseException()
          );
        } on FormatException {
          yield PollListError(
            errors: FormatException(),
          );
        } catch (e) {
          yield PollListError(
            errors: UnknownResponseException(),
          );
        }
        break;
    }

  }

}
