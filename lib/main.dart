import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tcc/Screens/Login/login_screen.dart';
import 'package:tcc/config/app_keys.dart';
import 'package:tcc/enums/task.dart';
import 'package:tcc/logic/preferences/auth_preferences.dart';
import 'package:tcc/logic/tasks/task_handler.dart';
import 'package:tcc/notifications/flutter_notification_plugin.dart';
import 'package:tcc/screens/app_drawer/app_drawer.dart';
import 'package:tcc/screens/questionnaire/questionnaire_screen.dart';
import 'package:tcc/screens/register/register_screen.dart';
import 'package:tcc/themes/light.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((name, inputData) async {
    // print("->---------------------[task]: $task");
    // print("->----------------[inputData]: $inputData");
    //
    // print("->----------------[inputData]: ");
    //
    // await NotificationService().initNotification();
    // tz.initializeTimeZones();
    //
    // // NotificationService().scheduleNotification(
    // //   title: 'Scheduled Notification',
    // //   body: 'TESTE',
    // //   scheduledNotificationDateTime: DateTime.now(),
    // // );
    //
    // await NotificationService().showNotification(
    //   id: 0,
    //   body: 'TESTE @',
    //   payLoad: 'TESTE',
    //   title: 'outra',
    // );
    //
    // Logger l = Logger();
    // l.f('Logger notification service');
    //
    // return Future.value(true);
    Task? task = Task.getFromName(name);

    if (task == null) {
      return true;
    }

    TaskManager manager = TaskManager(task, inputData);
    return await manager.handle();
  });
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ByteData data =
  //     await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  // SecurityContext.defaultContext
  //     .setTrustedCertificatesBytes(data.buffer.asUint8List());
  HttpOverrides.global = MyHttpOverrides();

  NotificationService().initNotification();
  tz.initializeTimeZones();

  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  AuthPreferences preferences = AuthPreferences();
  bool authDataExpired = await preferences.isAuthExpired();

  if (authDataExpired) {
    preferences.deleteAuthData();
  }

  runApp(App(
    loggedIn: !authDataExpired,
  ));
}

class App extends StatelessWidget {
  final bool loggedIn;

  const App({
    super.key,
    required this.loggedIn,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TCC App',
      theme: themeLight,
      initialRoute: loggedIn ? "/" : 'login',
      routes: {
        '/': (context) => const AppDrawer(),
        'login': (context) => const LoginScreen(),
        'register': (context) => RegisterScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "questionnaire") {
          Map<String, dynamic> arguments =
              settings.arguments as Map<String, dynamic>;

          final int id = arguments["id"] ?? 0;
          final String name = arguments["name"] ?? "";

          return MaterialPageRoute<bool>(
            builder: (context) => QuestionnaireScreen(
              id: id,
              name: name,
            ),
          );
        }

        return null;
      },
      navigatorKey: AppKeys.navigatorState,
      scaffoldMessengerKey: AppKeys.scaffoldState,
    );
  }
}
