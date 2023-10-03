import 'package:bloc/bloc.dart';
import 'package:tcc/services/auth_service.dart';

part 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates?> {
  AuthService service;

  ProfileCubit()
      : service = AuthService(),
        super(null);

  Future<void> getProfile({required String token}) async {
    emit(ProfileLoading());

    try {
      Map<String, dynamic> data = await service.getProfile(token: token);
      emit(ProfileSuccess(data));
    } catch (error) {
      emit(ProfileError(error.toString()));
    }
  }
}
