import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcc/components/alert.dart';
import 'package:tcc/logic/cubit/logout_cubit.dart';

class LogoutButton extends StatelessWidget {
  final LogoutCubit _bloc = LogoutCubit();

  LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: BlocListener<LogoutCubit, LogoutStates?>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.pushReplacementNamed(context, 'login');
          }

          if (state is LogoutError) {
            alert(
              context: context,
              title: "Efetuar logout",
              message: state.message,
              buttonText: "Ok",
            );
          }
        },
        child: BlocBuilder<LogoutCubit, LogoutStates?>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is LogoutLoading) {
              return const Row(
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
              );
            }

            return OutlinedButton(
              onPressed: () {
                logout();
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  width: 1.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              child: const Text('Sair'),
            );
          },
        ),
      ),
    );
  }

  void logout() {
    _bloc.logout();
  }
}
