import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tcc/components/alert_unauthorized.dart';
import 'package:tcc/components/error_callout.dart';
import 'package:tcc/enums/question_type.dart';
import 'package:tcc/logic/cubit/app_data_cubit.dart';
import 'package:tcc/logic/cubit/questionnaire_cubit.dart';
import 'package:tcc/models/alternative.dart';
import 'package:tcc/models/question.dart';
import 'package:tcc/models/questionnaire.dart';
import 'package:tcc/screens/questionnaire/form.dart' as form_questionnaire;

class Content extends StatelessWidget {
  final int id;

  Content({
    Key? key,
    required this.id,
  })  : assert(id > 0),
        super(key: key);

  final QuestionnaireCubit _bloc = QuestionnaireCubit();

  @override
  Widget build(BuildContext context) {
    getQuestionnaire(context);

    return BlocListener<QuestionnaireCubit, QuestionnaireStates?>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is QuestionnaireError && state.unauthorized) {
          alertUnauthorized(context: context, message: state.message);
        }
      },
      child: BlocBuilder<QuestionnaireCubit, QuestionnaireStates?>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is QuestionnaireLoading) {
            return Skeletonizer(
              child: Builder(
                builder: (context) {
                  final Questionnaire questionnaire = Questionnaire.empty();
                  questionnaire.description =
                      "##################################";

                  for (int i = 0; i < 6; i++) {
                    final Question question = Question(
                      id: 0,
                      description: "##################################",
                      type: QuestionType.choice,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    );

                    for (int j = 0; j < 4; j++) {
                      question.addAlternative(Alternative(
                        id: 0,
                        description: "#################",
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      ));
                    }

                    questionnaire.addQuestion(question);
                  }

                  return form_questionnaire.Form(questionnaire: questionnaire);
                },
              ),
            );
          }

          if (state is QuestionnaireError && !state.unauthorized) {
            return ErrorCallout(
              title: "Erro ao obter as informações do instrumento",
              message: state.message,
            );
          }

          if (state is QuestionnaireSuccess) {
            return form_questionnaire.Form(
              questionnaire: state.data,
              isFetched: true,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void getQuestionnaire(BuildContext context) {
    AppDataCubit appData = context.read<AppDataCubit>();
    AppDataStates? data = appData.state;

    if (data is! AppDataAuthenticated) return;

    _bloc.getQuestionnaire(
      id: id,
      token: data.token,
    );
  }
}
