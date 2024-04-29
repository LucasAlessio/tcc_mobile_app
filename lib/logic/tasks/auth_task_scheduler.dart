import 'package:tcc/enums/task.dart';
import 'package:tcc/logic/preferences/task_preferences.dart';
import 'package:tcc/logic/tasks/task_scheduler.dart';

class AuthTaskScheduler extends TaskScheduler {
  final int delayRefreshTokenInDays = 4;
  TaskPreferences preferences = TaskPreferences();

  Future<void> scheduleRefreshToken() async {
    String id = await preferences.saveRefreshTokenId();

    await schedule(
      id,
      Task.refreshToken,
      delay: Duration(days: delayRefreshTokenInDays),
      connectionRequired: true,
    );
  }

  Future<void> cancelRefreshToken() async {
    String? id = await preferences.getRefreshTokenId();

    if (id == null) return;

    await cancel(id);
    await preferences.deleteRefreshTokenId();
  }
}
