import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcc/services/auth_service.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  bool _isLoading = false;
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: _isLoading
          ? const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 14, bottom: 14),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Text('efetuando logout...'),
              ],
            )
          : OutlinedButton(
              onPressed: () {
                logout(context);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  width: 1.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              child: const Text('Sair'),
            ),
    );
  }

  Future<void> logout(BuildContext context) async {
    setState(() {
      _isLoading = !_isLoading;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('access_token') ?? "";

    try {
      await authService.logout(token: token);

      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, '/login');
    } catch (error) {
      return;
    }
  }
}
