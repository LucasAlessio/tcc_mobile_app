import 'package:flutter/cupertino.dart';
import 'package:tcc/components/alert.dart';

Future<void> alertUnauthorized({
  required BuildContext context,
  required String message,
}) async {
  alert(
    context: context,
    title: "Refazer login",
    message: message,
    buttonText: "Logar novamente",
  ).then((value) {
    Navigator.pushReplacementNamed(context, 'login');
  });
}
