import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tcc/components/alert_unauthorized.dart';
import 'package:tcc/logic/cubit/app_data_cubit.dart';
import 'package:tcc/logic/cubit/update_password_cubit.dart';

class SaveButton extends StatelessWidget {
  final UpdatePasswordCubit _bloc = UpdatePasswordCubit();
  final GlobalKey<FormBuilderState> _formKey;

  SaveButton({
    Key? key,
    required GlobalKey<FormBuilderState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdatePasswordCubit, UpdatePasswordStates?>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is UpdatePasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sucesso",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text("A senha foi atualizada com sucesso"),
              ],
            ),
            showCloseIcon: true,
          ));
          _formKey.currentState?.reset();
        }

        if (state is UpdatePasswordError) {
          if (state.unauthorized) {
            alertUnauthorized(context: context, message: state.message);
            return;
          }

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Ocorreu um erro",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(state.message),
              ],
            ),
            showCloseIcon: true,
            backgroundColor: Theme.of(context).colorScheme.error,
          ));
        }

        if (state is UpdatePasswordValidationError) {
          for (MapEntry e in state.errors.entries) {
            _formKey.currentState?.fields[e.key]?.invalidate(e.value);
          }
        }
      },
      child: BlocBuilder<UpdatePasswordCubit, UpdatePasswordStates?>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is UpdatePasswordLoading) {
            return const Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                Text('aguarde...'),
              ],
            );
          }

          return ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.saveAndValidate() ?? false) {
                saveProfile(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColorLight,
            ),
            child: const Text(
              "Atualizar",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  void saveProfile(BuildContext context) {
    AppDataCubit appData = context.read<AppDataCubit>();
    AppDataStates? data = appData.state;

    if (data is! AppDataAuthenticated) return;

    _bloc.updatePassword(
      token: data.token,
      data: _formKey.currentState?.value ?? {},
    );
  }
}
