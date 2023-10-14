import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:tcc/exceptions/unauthorized_exception.dart';
import 'package:tcc/exceptions/validation_exception.dart';
import 'package:tcc/services/auth_service.dart';

part 'update_password_states.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordStates?> {
  final AuthService service = AuthService();

  UpdatePasswordCubit() : super(null);

  Future<void> updatePassword({required Map<String, dynamic> data}) async {
    emit(UpdatePasswordLoading());

    try {
      await service.updatePassword(data: data);
      emit(UpdatePasswordSuccess());
    } on ValidationException catch (error) {
      emit(UpdatePasswordValidationError(error.errors));
    } on UnauthorizedException catch (error) {
      emit(UpdatePasswordError(error.message, unauthorized: true));
    } on HttpException catch (error) {
      emit(UpdatePasswordError(error.message));
    } on SocketException catch (_) {
      emit(UpdatePasswordError(
          "Verifique se o dispositivo está conectado à internet."));
    } catch (error) {
      emit(UpdatePasswordError("Ocorreu um erro ao atualizar a senha"));
    }
  }

  // Future<void> saveProfile({required })
}
