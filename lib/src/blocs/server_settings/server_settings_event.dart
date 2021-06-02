part of 'server_settings_bloc.dart';

abstract class ServerSettingsEvent extends Equatable {
  const ServerSettingsEvent();
}

class GetServerSettings extends ServerSettingsEvent {
  const GetServerSettings();

  @override
  List<Object> get props => [];
}
