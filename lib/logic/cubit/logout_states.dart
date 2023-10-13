part of 'logout_cubit.dart';

abstract class LogoutStates {}

class LogoutLoading extends LogoutStates {}

class LogoutSuccess extends LogoutStates {}

class LogoutError extends LogoutStates {
  bool unauthorized;
  String message;

  LogoutError(
    this.message, {
    this.unauthorized = false,
  });
}
