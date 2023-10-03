part of 'app_data_cubit.dart';

abstract class AppDataStates {}

class AppDataLoading extends AppDataStates {}

class AppDataAuthenticated extends AppDataStates {
  String token;
  String expiresAt;

  AppDataAuthenticated({
    required this.token,
    required this.expiresAt,
  });
}

class AppDataUnauthenticated extends AppDataStates {}

class AppDataError extends AppDataStates {
  String message;

  AppDataError(this.message);
}
