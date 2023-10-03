import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:logger/logger.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tcc/components/error_callout.dart';
import 'package:tcc/logic/cubit/answer_cubit.dart';
import 'package:tcc/logic/cubit/app_data_cubit.dart';
import 'package:tcc/logic/cubit/questionnaire_cubit.dart';
import 'package:tcc/models/questionnaire.dart';
import 'package:tcc/screens/questionnaire/answer_button.dart';

class QuestionnaireScreen extends StatelessWidget {
  final int id;
  final String name;

  const QuestionnaireScreen({
    Key? key,
    required this.id,
    required this.name,
  })  : assert(id > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<QuestionnaireCubit>(
            create: (context) => QuestionnaireCubit(),
          ),
          BlocProvider<AnswerCubit>(
            create: (context) => AnswerCubit(),
          ),
        ],
        child: QuestionnaireContent(id: id),
      ),
      primary: true,
    );
  }
}

class QuestionnaireContent extends StatelessWidget {
  final int id;

  QuestionnaireContent({
    Key? key,
    required this.id,
  })  : assert(id > 0),
        super(key: key);

  final QuestionnaireCubit _bloc = QuestionnaireCubit();

  @override
  Widget build(BuildContext context) {
    getQuestionnaires(context);

    return BlocBuilder<QuestionnaireCubit, QuestionnaireStates?>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is QuestionnaireLoading) {
          // return const CircularProgressIndicator(); // Mostra o loader enquanto os dados estão sendo carregados
          return Skeletonizer(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return const Text("##############");
              },
            ),
          );
        }

        if (state is QuestionnaireError) {
          return ErrorCallout(
            title: "Erro ao obter as informações do instrumento",
            message: state.message,
          );
        }

        if (state is QuestionnaireSuccess) {
          return Form(questionnaire: state.data);
        }

        return const SizedBox.shrink();
      },
    );
  }

  void getQuestionnaires(BuildContext context) {
    AppDataCubit appData = context.read<AppDataCubit>();
    AppDataStates? data = appData.state;

    if (data is! AppDataAuthenticated) return;

    _bloc.getQuestionnaire(
      id: id,
      token: data.token,
    );
  }
}

class Form extends StatelessWidget {
  final Questionnaire questionnaire;
  final _formKey = GlobalKey<FormBuilderState>();

  Logger logger = Logger();

  Form({
    Key? key,
    required this.questionnaire,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(questionnaire.description),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ...questionnaire.questions.asMap().entries.map((e) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormBuilderField(
                            name: 'questions.${e.key}.id',
                            enabled: false,
                            initialValue: e.value.id,
                            builder: (FormFieldState<dynamic> field) {
                              //Empty widget
                              return const SizedBox.shrink();
                            },
                          ),
                          Text(
                            e.value.description,
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const Divider(),
                          FormBuilderRadioGroup(
                            name: 'questions.${e.key}.alternative',
                            decoration: const InputDecoration(
                              filled: false,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                              isCollapsed: true,
                            ),
                            options: e.value.alternatives.map((e) {
                              return FormBuilderFieldOption(
                                value: e.id,
                                child: Text(e.description),
                              );
                            }).toList(),
                            orientation: OptionsOrientation.vertical,
                            // validator: FormBuilderValidators.compose([
                            //   FormBuilderValidators.required(
                            //     errorText: "Responda essa questão",
                            //   ),
                            // ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ]),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: AnswerButton(
                  id: questionnaire.id,
                  formKey: _formKey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
