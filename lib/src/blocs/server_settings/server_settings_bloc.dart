import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app1/src/api/responses/settings_response.dart';
import 'package:flutter_app1/src/repositories/settings_repo.dart';

part 'server_settings_event.dart';

part 'server_settings_state.dart';

class ServerSettingsBloc
    extends Bloc<ServerSettingsEvent, ServerSettingsState> {
  final ServerSettingsRepo serverSettingsRepo;

  ServerSettingsBloc(this.serverSettingsRepo) : super(ServerSettingsInitial());

  @override
  Stream<ServerSettingsState> mapEventToState(
    ServerSettingsEvent event,
  ) async* {
    if (event is GetServerSettings) {
      try {
        final settingsResponse = await serverSettingsRepo.fetchServerSettings();
        if (settingsResponse.success == "1" && settingsResponse.data != null)
          yield ServerSettingsLoaded(settingsResponse);
        else
          yield ServerSettingsError(settingsResponse.message);
      } on Error {
        yield ServerSettingsError(
            "Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
