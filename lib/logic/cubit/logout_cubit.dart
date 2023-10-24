import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:tcc/exceptions/unauthorized_exception.dart';
import 'package:tcc/logic/preferences/auth_preferences.dart';
import 'package:tcc/logic/tasks/auth_task_scheduler.dart';
import 'package:tcc/services/auth_service.dart';

part 'logout_states.dart';

class LogoutCubit extends Cubit<LogoutStates?> {
  final AuthService service = AuthService();
  final AuthPreferences preferences = AuthPreferences();
  final AuthTaskScheduler taskManager = AuthTaskScheduler();

  LogoutCubit() : super(null);

  Future<void> logout() async {
    emit(LogoutLoading());

    try {
      await service.logout();

      await preferences.deleteAuthData();
      await taskManager.cancelRefreshToken();

      emit(LogoutSuccess());
    } on UnauthorizedException catch (error) {
      emit(LogoutError(error.message, unauthorized: true));
    } on HttpException catch (error) {
      emit(LogoutError(error.message));
    } on SocketException catch (_) {
      emit(
          LogoutError("Verifique se o dispositivo está conectado à internet."));
    } catch (error) {
      emit(LogoutError("Ocorreu um erro ao efetuar o logout."));
    }
  }
}
