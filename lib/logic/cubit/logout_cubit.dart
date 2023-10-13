import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:tcc/exceptions/unauthorized_exception.dart';
import 'package:tcc/services/auth_service.dart';

part 'logout_states.dart';

class LogoutCubit extends Cubit<LogoutStates?> {
  final AuthService service = AuthService();

  LogoutCubit() : super(null);

  Future<void> logout({
    required String token,
  }) async {
    emit(LogoutLoading());

    try {
      await service.logout(token: token);
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
