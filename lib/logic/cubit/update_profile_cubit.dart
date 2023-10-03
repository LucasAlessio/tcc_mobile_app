import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:tcc/exceptions/validation_exception.dart';
import 'package:tcc/services/auth_service.dart';

part 'update_profile_states.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileStates?> {
  AuthService service;

  UpdateProfileCubit()
      : service = AuthService(),
        super(null);

  Future<void> saveProfile({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    emit(UpdateProfileLoading());

    try {
      await service.saveProfile(
        token: token,
        data: data,
      );
      emit(UpdateProfileSuccess());
    } on ValidationException catch (error) {
      emit(UpdateProfileValidationError(error.errors));
    } on HttpException catch (error) {
      emit(UpdateProfileError(error.message));
    } catch (error) {
      emit(UpdateProfileError("Ocorreu um erro ao atualizar o perfil"));
    }
  }

  // Future<void> saveProfile({required })
}
