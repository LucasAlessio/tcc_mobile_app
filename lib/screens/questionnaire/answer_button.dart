import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tcc/logic/cubit/answer_cubit.dart';
import 'package:tcc/logic/cubit/app_data_cubit.dart';

class AnswerButton extends StatelessWidget {
  final int id;
  final GlobalKey<FormBuilderState> formKey;

  const AnswerButton({
    Key? key,
    required this.id,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnswerCubit, AnswerStates?>(
      builder: (context, state) {
        if (state is AnswerLoading) {
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

        if (state is AnswerSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sucesso",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text("Sua respostas foram enviadas com sucesso"),
                ],
              ),
              showCloseIcon: true,
            ));

            Navigator.of(context).pop();
          });
        }

        if (state is AnswerError) {
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

        if (state is AnswerValidationError) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            for (MapEntry e in state.errors.entries) {
              formKey.currentState?.fields[e.key]?.invalidate(e.value);
            }
          });
        }

        return ElevatedButton(
          onPressed: () {
            if (formKey.currentState?.saveAndValidate() ?? false) {
              answer(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColorLight,
          ),
          child: const Text(
            "Responder",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  void answer(BuildContext context) {
    AppDataCubit appData = context.read<AppDataCubit>();
    AppDataStates? data = appData.state;

    if (data is! AppDataAuthenticated) return;

    final AnswerCubit bloc = context.read<AnswerCubit>();
    bloc.answer(
      id: id,
      token: data.token,
      data: convertToNestedObject(formKey.currentState?.value ?? {}),
    );
  }

  Map<String, dynamic> convertToNestedObject(Map<String, dynamic> input) {
    Map<String, dynamic> result = {};

    input.forEach((key, value) {
      List<String> keys = key.split('.');
      Map<dynamic, dynamic> temp = result;

      for (int i = 0; i < keys.length - 1; i++) {
        temp[keys[i]] ??= {};
        temp = temp[keys[i]];
      }

      temp[keys.last] = value;
    });

    return result;
  }
}