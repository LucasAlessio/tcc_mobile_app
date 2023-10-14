import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:tcc/exceptions/validation_exception.dart';
import 'package:tcc/logic/preferences/auth_preferences.dart';
import 'package:tcc/models/user.dart';
import 'package:tcc/services/auth_service.dart';

part 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates?> {
  final AuthService service = AuthService();
  final AuthPreferences preferences = AuthPreferences();

  RegisterCubit() : super(null);

  Future<void> register({
    required Map<String, dynamic> data,
  }) async {
    emit(RegisterLoading());

    try {
      User user = await service.register(data: data);

      preferences.saveAuthData(user: user);

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
