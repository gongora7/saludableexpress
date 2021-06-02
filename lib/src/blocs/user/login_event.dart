import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class ProcessLogin extends LoginEvent {
  final String email;
  final String password;

  const ProcessLogin(this.email, this.password);

  @override
  List<Object> get props => [this.email, this.password];
}

class ProcessLoginWithGmail extends LoginEvent {
  final String idToken;
  final String customerId;
  final String givenName;
  final String familyName;
  final String email;
  final String imageUrl;

  ProcessLoginWithGmail(this.idToken, this.customerId, this.givenName,
      this.familyName, this.email, this.imageUrl);

  @override
  List<Object> get props =>
      [idToken, customerId, givenName, familyName, email, imageUrl];
}

class ProcessLoginWithFacebook extends LoginEvent {

  final String accessToken;

  ProcessLoginWithFacebook(this.accessToken);

  @override
  List<Object> get props => [this.accessToken];

}

class ProcessRegistration extends LoginEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String countryCode;
  final String phone;

  const ProcessRegistration(this.firstName, this.lastName, this.email,
      this.password, this.countryCode, this.phone);

  @override
  List<Object> get props => [
        this.firstName,
        this.lastName,
        this.email,
        this.password,
        this.countryCode,
        this.phone
      ];
}

class ProcessForgotPassword extends LoginEvent {
  final String email;

  const ProcessForgotPassword(this.email);

  @override
  List<Object> get props => throw UnimplementedError(this.email);
}
