import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tcc/logic/cubit/app_data_cubit.dart';
import 'package:tcc/logic/cubit/update_password_cubit.dart';

class SaveButton extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;

  const SaveButton({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdatePasswordCubit, UpdatePasswordStates?>(
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

        if (state is UpdatePasswordSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
            formKey.currentState?.reset();
          });
        }

        if (state is UpdatePasswordError) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
          });
        }

        if (state is UpdatePasswordValidationError) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            for (MapEntry e in state.errors.entries) {
              formKey.currentState?.fields[e.key]?.invalidate(e.value);
            }
          });
        }

        return ElevatedButton(
          onPressed: () {
            if (formKey.currentState?.saveAndValidate() ?? false) {
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
    );
  }

  void saveProfile(BuildContext context) {
    AppDataCubit appData = context.read<AppDataCubit>();
    AppDataStates? data = appData.state;

    if (data is! AppDataAuthenticated) return;

    final UpdatePasswordCubit bloc = context.read<UpdatePasswordCubit>();
    bloc.updatePassword(
      token: data.token,
      data: formKey.currentState?.value ?? {},
    );
  }
}
