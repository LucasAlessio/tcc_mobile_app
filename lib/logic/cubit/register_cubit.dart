import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:tcc/exceptions/validation_exception.dart';
import 'package:tcc/services/auth_service.dart';

part 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates?> {
  final AuthService service = AuthService();

  RegisterCubit() : super(null);

  Future<void> register({
    required Map<String, dynamic> data,
  }) async {
    emit(RegisterLoading());

    try {
      await service.register(data: data);
      emit(RegisterSuccess());
    } on ValidationException catch (error) {
      emit(RegisterValidationError(error.errors));
    } on HttpException catch (error) {
      emit(RegisterError(error.message));
    } on SocketException catch (_) {
      emit(RegisterError(
          "Verifique se o dispositivo está conectado à internet."));
    } catch (error) {
      emit(RegisterError("Ocorreu um erro ao efetuar o registro."));
    }
  }
}
