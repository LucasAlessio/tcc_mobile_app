import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:tcc/exceptions/unauthorized_exception.dart';
import 'package:tcc/exceptions/validation_exception.dart';
import 'package:tcc/services/auth_service.dart';

part 'update_profile_states.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileStates?> {
  final AuthService service = AuthService();

  UpdateProfileCubit() : super(null);

  Future<void> saveProfile({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    emit(UpdateProfileLoading());

    try {
      await service.updateProfile(
        token: token,
        data: data,
      );
      emit(UpdateProfileSuccess());
    } on ValidationException catch (error) {
      emit(UpdateProfileValidationError(error.errors));
    } on UnauthorizedException catch (error) {
      emit(UpdateProfileError(error.message, unauthorized: true));
    } on HttpException catch (error) {
      emit(UpdateProfileError(error.message));
    } on SocketException catch (_) {
      emit(UpdateProfileError(
          "Verifique se o dispositivo está conectado à internet."));
    } catch (error) {
      emit(UpdateProfileError("Ocorreu um erro ao atualizar o perfil"));
    }
  }

  // Future<void> saveProfile({required })
}
