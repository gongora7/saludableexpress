
import 'package:flutter_app1/src/api/responses/forgot_password_response.dart';
import 'package:flutter_app1/src/api/responses/login_response.dart';
import 'package:flutter_app1/src/repositories/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepo userRepo;

  LoginBloc(this.userRepo) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is ProcessLogin) {
      try {
        yield LoginLoading();
        LoginResponse loginResponse =
            await userRepo.login(event.email, event.password);
        if (loginResponse.success == "1" && loginResponse.data.isNotEmpty) {
          yield LoginLoaded(loginResponse.data.first);
        } else {
          yield LoginError(loginResponse.message);
        }
      } on Error {
        yield LoginError("Couldn't fetch response. Is the device online?");
      }
    } else if(event is ProcessRegistration) {
      try {
        yield LoginLoading();
        LoginResponse loginResponse =
        await userRepo.registration(event.firstName, event.lastName, event.email, event.password,event.countryCode, event.phone);
        if (loginResponse.success == "1" && loginResponse.data.isNotEmpty) {
          yield LoginLoaded(loginResponse.data.first);
        } else {
          yield LoginError(loginResponse.message);
        }
      } on Error {
        yield LoginError("Couldn't fetch response. Is the device online?");
      }
    } else if (event is ProcessForgotPassword) {
      try {
        yield ForgotPasswordLoading();
        ForgotPasswordResponse forgotPasswordResponse =
        await userRepo.forgotPassword(event.email);
        if (forgotPasswordResponse.success == "1") {
          yield ForgotPasswordLoaded(forgotPasswordResponse);
        } else {
          yield LoginError(forgotPasswordResponse.message);
        }
      } catch(e) {
        yield LoginError(e.toString());
      }

    } else if (event is ProcessLoginWithGmail) {
      try {
        yield LoginLoading();
        LoginResponse loginResponse =
        await userRepo.loginWithGmail(event.idToken, event.customerId, event.givenName, event.familyName, event.email, event.imageUrl);
        if ((loginResponse.success == "1" || loginResponse.success == "2") && loginResponse.data.isNotEmpty) {
          yield LoginLoaded(loginResponse.data.first);
        } else {
          yield LoginError(loginResponse.message);
        }
      } catch(e) {
        yield LoginError("Couldn't fetch response. Is the device online?");
      }
    } else if (event is ProcessLoginWithFacebook) {
      try {
        yield LoginLoading();
        LoginResponse loginResponse =
        await userRepo.loginWithFacebook(event.accessToken);
        if (loginResponse.success != "0" && loginResponse.data.isNotEmpty) {
          yield LoginLoaded(loginResponse.data.first);
        } else {
          yield LoginError(loginResponse.message);
        }
      } catch(e) {
        yield LoginError("Couldn't fetch response. Is the device online?");
      }
    }
  }
}
