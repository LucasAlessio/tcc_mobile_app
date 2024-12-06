part of 'update_profile_cubit.dart';

abstract class UpdateProfileStates {}

class UpdateProfileLoading extends UpdateProfileStates {}

class UpdateProfileSuccess extends UpdateProfileStates {}

class UpdateProfileError extends UpdateProfileStates {
  bool unauthorized;
  String message;

  UpdateProfileError(
    this.message, {
    this.unauthorized = false,
  });
}

class UpdateProfileValidationError extends UpdateProfileStates {
  final Map<String, dynamic> errors;

  UpdateProfileValidationError(this.errors);
}
