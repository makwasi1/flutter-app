import 'package:citizen_feedback/models/poll_model.dart';
import 'package:equatable/equatable.dart';


class PollState extends Equatable {

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PollInitialState extends PollState {}

class PollLoadingState extends PollState {}

class PollLoadedState extends PollState {
  final List<Poll> polls;
  PollLoadedState({this.polls});
}

class PollListError extends PollState {
  final errors;
  PollListError({this.errors});
}