import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:tcc/exceptions/validation_exception.dart';
import 'package:tcc/services/auth_service.dart';

part 'update_password_states.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordStates?> {
  AuthService service;

  UpdatePasswordCubit()
      : service = AuthService(),
        super(null);

  Future<void> updatePassword({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    emit(UpdatePasswordLoading());

    try {
      await service.updatePassword(
        token: token,
        data: data,
      );
      emit(UpdatePasswordSuccess());
    } on ValidationException catch (error) {
      emit(UpdatePasswordValidationError(error.errors));
    } on HttpException catch (error) {
      emit(UpdatePasswordError(error.message));
    } catch (error) {
      emit(UpdatePasswordError("Ocorreu um erro ao atualizar a senha"));
    }
  }

  // Future<void> saveProfile({required })
}
