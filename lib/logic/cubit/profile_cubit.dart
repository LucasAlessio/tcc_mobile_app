import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:tcc/exceptions/unauthorized_exception.dart';
import 'package:tcc/services/auth_service.dart';

part 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates?> {
  final AuthService service = AuthService();

  ProfileCubit() : super(null);

  Future<void> getProfile({required String token}) async {
    emit(ProfileLoading());

    try {
      Map<String, dynamic> data = await service.getProfile(token: token);
      emit(ProfileSuccess(data));
    } on UnauthorizedException catch (error) {
      emit(ProfileError(error.message, unauthorized: true));
    } on HttpException catch (error) {
      emit(ProfileError(error.message));
    } on SocketException catch (_) {
      emit(ProfileError(
          "Verifique se o dispositivo está conectado à internet."));
    } catch (error) {
      emit(ProfileError("Ocorreu um erro ao obter as informações do perfil."));
    }
  }
}
