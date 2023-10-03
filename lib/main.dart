import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:tcc/Screens/Login/login_screen.dart';
import 'package:tcc/config/app_keys.dart';
import 'package:tcc/logic/cubit/app_data_cubit.dart';
import 'package:tcc/notifications/flutter_notification_plugin.dart';
import 'package:tcc/screens/app_drawer/app_drawer.dart';
import 'package:tcc/screens/questionnaire/questionnaire_screen.dart';
import 'package:tcc/screens/register/register_screen.dart';
import 'package:tcc/themes/light.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("->---------------------[task]: $task");
    print("->----------------[inputData]: $inputData");

    print(
        "->----------------[inputData]: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");

    await NotificationService().initNotification();
    tz.initializeTimeZones();

    // NotificationService().scheduleNotification(
    //   title: 'Scheduled Notification',
    //   body: 'TESTE',
    //   scheduledNotificationDateTime: DateTime.now(),
    // );

    await NotificationService().showNotification(
      id: 0,
      body: 'TESTE @',
      payLoad: 'TESTE',
      title: 'outra',
    );

    Logger l = new Logger();
    l.f('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  NotificationService().initNotification();
  tz.initializeTimeZones();

  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.setString(LocalStorageKey.accessToken.value,
  //     "10|auth_token_OpyeTqMX1iNiuwf5hgtg2pa2qFxlLAXYrRH6tR5S9ec8576f");
  // prefs.setString(
  //     LocalStorageKey.expiresAt.value, "2023-10-10T19:27:46.000000Z");

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppDataCubit>(
          create: (context) => AppDataCubit(),
        ),
      ],
      child: BlocBuilder<AppDataCubit, AppDataStates?>(
        builder: (context, state) {
          if (state is AppDataLoading || state == null) {
            return MaterialApp(
              title: 'TCC App',
              theme: themeLight,
            );
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TCC App',
            theme: themeLight,
            // home: const MyHomePage(title: 'Flutter Demo Home Page'),
            initialRoute: state is AppDataAuthenticated ? "/" : '/login',
            routes: {
              '/': (context) => const AppDrawer(),
              '/login': (context) => const LoginScreen(),
              '/register': (context) => const RegisterScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == "questionnaire") {
                Map<String, dynamic> arguments =
                    settings.arguments as Map<String, dynamic>;

                final int id = arguments["id"] ?? 0;
                final String name = arguments["name"] ?? "";

                return MaterialPageRoute(
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
        },
      ),
    );
  }
}
