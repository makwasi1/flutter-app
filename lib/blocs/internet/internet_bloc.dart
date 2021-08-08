import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'internet_state.dart';
import 'internet_events.dart';

class InternetBloc extends Bloc<InternetEvents, InternetState> {

  Connectivity connectivity;
  StreamSubscription connectivitySubscription;

  InternetBloc() : super(InternetLoading()) {
    try{
      connectivitySubscription = connectivity.onConnectivityChanged.listen((ConnectivityResult connectivityResult) {
        if (connectivityResult == ConnectivityResult.mobile) {
          emitInternetConnected(ConnectionType.mobile);

        } else if (connectivityResult == ConnectivityResult.wifi) {
          emitInternetConnected(ConnectionType.wifi);
        }else if (connectivityResult == ConnectivityResult.none) {
          emitInternetDisconnected();
        }
      });
    }catch(e){}
  }



  @override
  InternetState get initialState => InternetLoading();

  @override
  Stream<InternetState> mapEventToState(InternetEvents event) async* {
  }

  emitInternetConnected(ConnectionType connectionType) =>
      emit(InternetConnected(connectionType: connectionType));

  emitInternetDisconnected() => emit(InternetConnected());

  @override
  Future<Function> close() {
    connectivitySubscription.cancel();
   return super.close();
  }

//
}
