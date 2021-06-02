import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/api/responses/forgot_password_response.dart';
import 'package:flutter_app1/src/api/responses/login_response.dart';

abstract class UserRepo {
  Future<LoginResponse> login(String email, String password);

  Future<LoginResponse> loginWithGmail(String idToken,
      String customerId,
      String givenName,
      String familyName,
      String email,
      String imageUrl);

  Future<LoginResponse> loginWithFacebook(String accessToken);

  Future<LoginResponse> registration(String firstName, String lastName,
      String email, String password, String countryCode, String phone);

  Future<ForgotPasswordResponse> forgotPassword(String email);
}

class RealUserRepo extends UserRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<LoginResponse> login(String email, String password) {
    return _apiProvider.processLogin(email, password);
  }

  @override
  Future<LoginResponse> registration(String firstName, String lastName,
      String email, String password, String countryCode, String phone) {
    return _apiProvider.processRegistration(
        firstName, lastName, email, password, countryCode, phone);
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) {
    return _apiProvider.forgotPassword(email);
  }

  @override
  Future<LoginResponse> loginWithGmail(String idToken, String customerId, String givenName, String familyName, String email, String imageUrl) {
    return _apiProvider.processLoginWithGoogle(idToken, customerId, givenName, familyName, email, imageUrl);
  }

  @override
  Future<LoginResponse> loginWithFacebook(String accessToken) {
    return _apiProvider.processLoginWithFacebook(accessToken);
  }
}

class FakeUserRepo extends UserRepo {
  @override
  Future<LoginResponse> login(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<LoginResponse> registration(String firstName, String lastName,
      String email, String password, String countryCode, String phone) {
    throw UnimplementedError();
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) {
    throw UnimplementedError();
  }

  @override
  Future<LoginResponse> loginWithGmail(String idToken, String customerId, String givenName, String familyName, String email, String imageUrl) {
    throw UnimplementedError();
  }

  @override
  Future<LoginResponse> loginWithFacebook(String accessToken) {
    throw UnimplementedError();
  }
}
