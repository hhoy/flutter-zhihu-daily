import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {}

class TemperatureUnitsToggled extends SettingsEvent {}

class SettingsState extends Equatable {
  bool automaticOfflineDownload;
  SettingsState({@required this.automaticOfflineDownload})
      : assert(automaticOfflineDownload != null),
        super([automaticOfflineDownload]);
}

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  @override
  SettingsState get initialState =>
      SettingsState(automaticOfflineDownload: true);

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {

  }
}
