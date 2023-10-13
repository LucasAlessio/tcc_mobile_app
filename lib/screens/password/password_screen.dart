import 'package:flutter/material.dart';
import 'package:tcc/components/menu_widget.dart';
import 'package:tcc/screens/password/form.dart' as form_password;

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Segurança"),
        leading: const MenuWidget(),
      ),
      body: form_password.Form(),
    );
  }
}
