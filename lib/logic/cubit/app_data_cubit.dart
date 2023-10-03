import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_data_states.dart';

class AppDataCubit extends Cubit<AppDataStates?> {
  AppDataCubit() : super(null) {
    loadData();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String accessToken = prefs.getString("access_token") ?? "";

    if (accessToken.isEmpty) {
      emit(AppDataUnauthenticated());
    }

    String expiresAt = prefs.getString("expires_at") ?? "";

    if (expiresAt.isEmpty) {
      emit(AppDataUnauthenticated());
    }

    if (DateTime.now().compareTo(DateTime.parse(expiresAt)) > 0) {
      emit(AppDataUnauthenticated());
    }

    emit(AppDataAuthenticated(
      token: accessToken,
      expiresAt: expiresAt,
    ));
  }
}
