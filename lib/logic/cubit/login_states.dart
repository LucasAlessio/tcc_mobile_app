part of 'login_cubit.dart';

abstract class LoginStates {}

class LoginLoading extends LoginStates {}

class LoginSuccess extends LoginStates {}

class LoginError extends LoginStates {
  String message;

  LoginError(this.message);
}

class LoginValidationError extends LoginStates {
  final Map<String, dynamic> errors;

  LoginValidationError(this.errors);
}
