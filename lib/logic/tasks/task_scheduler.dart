import 'package:tcc/enums/task.dart';
import 'package:workmanager/workmanager.dart';

abstract class TaskScheduler {
  Future<void> schedule(
    String id,
    Task task, {
    required Duration delay,
    Map<String, dynamic>? data,
    bool? connectionRequired,
    bool? append,
  }) async {
    await Workmanager().registerOneOffTask(
      id,
      task.name,
      initialDelay: delay,
      inputData: data,
      existingWorkPolicy:
          append == true ? ExistingWorkPolicy.append : ExistingWorkPolicy.keep,
      constraints: Constraints(
        networkType: connectionRequired == true
            ? NetworkType.connected
            : NetworkType.not_required,
      ),
    );
  }

  Future<void> cancel(String id) async {
    await Workmanager().cancelByUniqueName(id);
  }
}
