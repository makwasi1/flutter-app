import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class InternetState extends Equatable {
  InternetState();

  @override
  List<Object> get props => [];
}

enum ConnectionType { wifi, mobile, none }

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  final ConnectionType connectionType;

  InternetConnected({this.connectionType});
}

class InternetDisconnected extends InternetState {}
