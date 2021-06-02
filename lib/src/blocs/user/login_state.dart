import 'package:equatable/equatable.dart';
import 'package:flutter_app1/src/api/responses/forgot_password_response.dart';
import 'package:flutter_app1/src/models/user.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();

  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  const LoginLoading();

  @override
  List<Object> get props => [];
}

class LoginLoaded extends LoginState {
  final User user;

  const LoginLoaded(this.user);

  @override
  List<Object> get props => [this.user];
}

class LoginError extends LoginState {
  final String error;

  const LoginError(this.error);

  @override
  List<Object> get props => [this.error];
}

class ForgotPasswordInitial extends LoginState {
  const ForgotPasswordInitial();

  @override
  List<Object> get props => [];
}

class ForgotPasswordLoading extends LoginState {
  const ForgotPasswordLoading();

  @override
  List<Object> get props => [];
}

class ForgotPasswordLoaded extends LoginState {
  final ForgotPasswordResponse forgotPasswordResponse;

  const ForgotPasswordLoaded(this.forgotPasswordResponse);

  @override
  List<Object> get props => [this.forgotPasswordResponse];
}

class ForgotPasswordError extends LoginState {
  final String error;

  const ForgotPasswordError(this.error);

  @override
  List<Object> get props => [this.error];
}
