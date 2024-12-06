part of 'profile_cubit.dart';

abstract class ProfileStates {}

class ProfileLoading extends ProfileStates {}

class ProfileSuccess extends ProfileStates {
  bool isEmpty = true;
  Map<String, dynamic> data = {};

  ProfileSuccess(this.data);
}

class ProfileError extends ProfileStates {
  bool unauthorized;
  String message;

  ProfileError(
    this.message, {
    this.unauthorized = false,
  });
}
