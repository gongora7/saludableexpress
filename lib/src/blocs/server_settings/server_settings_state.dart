part of 'server_settings_bloc.dart';

abstract class ServerSettingsState extends Equatable {
  const ServerSettingsState();
}

class ServerSettingsInitial extends ServerSettingsState {
  const ServerSettingsInitial();

  @override
  List<Object> get props => [];
}

class ServerSettingsLoading extends ServerSettingsState {
  const ServerSettingsLoading();

  @override
  List<Object> get props => [];
}

class ServerSettingsLoaded extends ServerSettingsState {
  final SettingsResponse settingsResponse;

  const ServerSettingsLoaded(this.settingsResponse);

  @override
  List<Object> get props => [settingsResponse];
}

class ServerSettingsError extends ServerSettingsState {
  final String error;

  const ServerSettingsError(this.error);

  @override
  List<Object> get props => [error];
}
