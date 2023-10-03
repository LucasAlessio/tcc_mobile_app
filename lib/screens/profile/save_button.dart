import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tcc/logic/cubit/app_data_cubit.dart';
import 'package:tcc/logic/cubit/update_profile_cubit.dart';
import 'package:workmanager/workmanager.dart';

class SaveButton extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;

  const SaveButton({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileStates?>(
      builder: (context, state) {
        if (state is UpdateProfileLoading) {
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

        if (state is UpdateProfileSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sucesso",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text("As informações do seu perfil foram atualizadas"),
                ],
              ),
              showCloseIcon: true,
            ));
          });
        }

        if (state is UpdateProfileError) {
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

        if (state is UpdateProfileValidationError) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            for (MapEntry e in state.errors.entries) {
              formKey.currentState?.fields[e.key]?.invalidate(e.value);
            }
          });
        }

        return ElevatedButton(
          onPressed: () {
            if (formKey.currentState?.saveAndValidate() ?? false) {
              registerTask();
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

    final UpdateProfileCubit bloc = context.read<UpdateProfileCubit>();
    bloc.saveProfile(
      token: data.token,
      data: formKey.currentState?.value ?? {},
    );
  }

  void registerTask() {
    Workmanager().registerOneOffTask(
      "test",
      "test-test",
      initialDelay: const Duration(seconds: 4),
      inputData: {
        'name': 'Lucas',
      },
      existingWorkPolicy: ExistingWorkPolicy.append,
    );
  }
}
