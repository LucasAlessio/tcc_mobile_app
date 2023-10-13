import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:tcc/exceptions/validation_exception.dart';
import 'package:tcc/services/auth_service.dart';

part 'login_states.dart';

class LoginCubit extends Cubit<LoginStates?> {
  final AuthService service = AuthService();

  LoginCubit() : super(null);

  Future<void> login({
    required Map<String, dynamic> data,
  }) async {
    emit(LoginLoading());

    try {
      await service.login(data: data);
      emit(LoginSuccess());
    } on ValidationException catch (error) {
      emit(LoginValidationError(error.errors));
    } on HttpException catch (error) {
      emit(LoginError(error.message));
    } on SocketException catch (_) {
      emit(LoginError("Verifique se o dispositivo está conectado à internet."));
    } catch (error) {
      emit(LoginError("Ocorreu um erro ao efetuar o login."));
    }
  }
}
