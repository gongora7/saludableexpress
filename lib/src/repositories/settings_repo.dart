import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/api/responses/settings_response.dart';

abstract class ServerSettingsRepo {
  Future<SettingsResponse> fetchServerSettings();
}

class RealServerSettingsRepo implements ServerSettingsRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<SettingsResponse> fetchServerSettings() {
    return _apiProvider.getSettings();
  }
}
