import 'package:tcc/enums/task.dart';
import 'package:tcc/exceptions/unauthorized_exception.dart';
import 'package:tcc/logic/preferences/auth_preferences.dart';
import 'package:tcc/logic/tasks/auth_task_scheduler.dart';
import 'package:tcc/models/user.dart';
import 'package:tcc/services/auth_service.dart';

class TaskManager {
  Task task;
  Map<String, dynamic>? data;

  TaskManager(this.task, this.data);

  Future<bool> handle() async {
    switch (task) {
      case Task.refreshToken:
        return _refreshTokenHandler();

      default:
        return true;
    }
  }

  Future<bool> _refreshTokenHandler() async {
    AuthService service = AuthService();
    AuthPreferences preferences = AuthPreferences();
    AuthTaskScheduler scheduler = AuthTaskScheduler();

    try {
      User user = await service.refreshLogin();

      await preferences.saveAuthData(user: user);

      await scheduler.scheduleRefreshToken();
    } on UnauthorizedException catch (_) {
      return true;
    } catch (_) {
      return false;
    }

    return true;
  }
}
