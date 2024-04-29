import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tcc/components/alert_unauthorized.dart';
import 'package:tcc/components/error_callout.dart';
import 'package:tcc/components/menu_widget.dart';
import 'package:tcc/components/spacer.dart' as common;
import 'package:tcc/logic/cubit/questionnaires_cubit.dart';
import 'package:tcc/models/questionnaire.dart';

class HomeScreen extends StatelessWidget {
  final QuestionnairesCubit _bloc = QuestionnairesCubit();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getQuestionnaires();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: const MenuWidget(),
        actions: [
          IconButton(
            onPressed: getQuestionnaires,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 8,
        ),
        child: BlocListener<QuestionnairesCubit, QuestionnairesStates?>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is QuestionnairesError && state.unauthorized) {
              alertUnauthorized(context: context, message: state.message);
            }
          },
          child: BlocBuilder<QuestionnairesCubit, QuestionnairesStates?>(
            bloc: _bloc,
            builder: (context, state) {
              if (state is QuestionnairesLoading) {
                return Skeletonizer(
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: ListTile(
                          title: const Text("##############"),
                          subtitle:
                              const Text("##############################"),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 8, 8, 8),
                          tileColor: Colors.white,
                          dense: false,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }

              if (state is QuestionnairesError && !state.unauthorized) {
                return ErrorCallout(
                  title: "Erro ao obter os instrumentos",
                  message: state.message,
                );
              }

              if (state is QuestionnairesSuccess) {
                if (state.isEmpty) {
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.psychology_alt_outlined,
                          size: 96,
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const Text(
                          'Nada de novo por aqui',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const Text(
                          'Aguarde as atualizações de seu psicólogo',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 128,
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: !state.isEmpty ? state.data.length : 0,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Tile(
                      questionnaire: state.data[index],
                      bloc: _bloc,
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  void getQuestionnaires() {
    _bloc.getQuestionnaires();
  }
}

class Tile extends StatelessWidget {
  final Questionnaire questionnaire;
  final QuestionnairesCubit bloc;
  const Tile({
    Key? key,
    required this.questionnaire,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (questionnaire.disabled) {
      List<Widget> content = [
        Opacity(
          opacity: .3,
          child: Text(questionnaire.description),
        ),
      ];

      if (questionnaire.disabledUntil != null) {
        DateFormat dateFormat = DateFormat('dd/MM/yyyy');

        content.addAll([
          const common.Spacer(height: 8),
          Text(
            "Indisponível até ${dateFormat.format(questionnaire.disabledUntil!.toLocal())}",
            style: const TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
        ]);
      }

      return ListTile(
        title: Opacity(
          opacity: .3,
          child: Text(questionnaire.name),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: content,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
        tileColor: const Color.fromARGB(156, 255, 255, 255),
        dense: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      );
    }

    return ListTile(
      title: Text(questionnaire.name),
      subtitle: Text(questionnaire.description),
      contentPadding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
      tileColor: Colors.white,
      dense: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      onTap: () {
        Navigator.pushNamed<bool>(
          context,
          'questionnaire',
          arguments: {
            "id": questionnaire.id,
            "name": questionnaire.name,
          },
        ).then((value) {
          if (value == true) {
            bloc.getQuestionnaires();
          }
        });
      },
      trailing: const Icon(
        Icons.chevron_right,
        size: 40,
      ),
    );
  }
}
