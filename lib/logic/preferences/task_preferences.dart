import 'package:tcc/enums/local_storage_key.dart';
import 'package:tcc/enums/task.dart';
import 'package:tcc/logic/preferences/preferences.dart';

class TaskPreferences extends Preferences {
  String _getTaskId() {
    return "${Task.refreshToken.name}:${DateTime.now().microsecondsSinceEpoch}";
  }

  Future<String> saveRefreshTokenId() async {
    String id = _getTaskId();
    await saveString(LocalStorageKey.taskRefreshTokenId, id);

    return id;
  }

  Future<String?> getRefreshTokenId() async {
    return await getString(LocalStorageKey.taskRefreshTokenId);
  }

  Future<void> deleteRefreshTokenId() async {
    await delete(LocalStorageKey.taskRefreshTokenId);
  }
}
