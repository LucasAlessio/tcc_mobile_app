part of 'update_password_cubit.dart';

abstract class UpdatePasswordStates {}

class UpdatePasswordLoading extends UpdatePasswordStates {}

class UpdatePasswordSuccess extends UpdatePasswordStates {}

class UpdatePasswordError extends UpdatePasswordStates {
  bool unauthorized;
  String message;

  UpdatePasswordError(
    this.message, {
    this.unauthorized = false,
  });
}

class UpdatePasswordValidationError extends UpdatePasswordStates {
  final Map<String, dynamic> errors;

  UpdatePasswordValidationError(this.errors);
}
