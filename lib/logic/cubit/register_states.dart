part of 'register_cubit.dart';

abstract class RegisterStates {}

class RegisterLoading extends RegisterStates {}

class RegisterSuccess extends RegisterStates {}

class RegisterError extends RegisterStates {
  String message;

  RegisterError(this.message);
}

class RegisterValidationError extends RegisterStates {
  final Map<String, dynamic> errors;

  RegisterValidationError(this.errors);
}
