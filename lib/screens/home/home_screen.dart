import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tcc/components/menu_widget.dart';
import 'package:tcc/logic/cubit/app_data_cubit.dart';
import 'package:tcc/logic/cubit/questionnaires_cubit.dart';
import 'package:tcc/services/questionnaires_service.dart';

class HomeScreen extends StatelessWidget {
  final QuestionnairesCubit _bloc = QuestionnairesCubit();
  final Logger l = Logger();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getQuestionnaires(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: const MenuWidget(),
        actions: [
          IconButton(
            onPressed: () {
              getQuestionnaires(context);
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: BlocBuilder<QuestionnairesCubit, QuestionnairesStates?>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is QuestionnairesLoading) {
              // return const CircularProgressIndicator(); // Mostra o loader enquanto os dados estão sendo carregados
              return Skeletonizer(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                      ),
                      child: ListTile(
                        title: const Text("##############"),
                        subtitle: const Text("##############################"),
                        contentPadding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
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

            if (state is QuestionnairesError) {
              return Text('Erro ao carregar os dados: ${state.message}');
            }

            if (state is QuestionnairesSuccess) {
              return ListView.builder(
                itemCount: !state.isEmpty ? state.data.length : 0,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: ListTile(
                    title: Text(state.data[index].name),
                    subtitle: Text(state.data[index].description),
                    contentPadding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                    tileColor: Colors.white,
                    dense: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, 'questionnaire', arguments: {
                        "id": state.data[index].id,
                        "name": state.data[index].name,
                      });
                    },
                    trailing: const Icon(
                      Icons.chevron_right,
                      size: 40,
                    ),
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void getQuestionnaires(BuildContext context) {
    AppDataCubit appData = context.read<AppDataCubit>();
    AppDataStates? data = appData.state;

    if (data is! AppDataAuthenticated) return;

    _bloc.getQuestionnaires(token: data.token);
  }
}