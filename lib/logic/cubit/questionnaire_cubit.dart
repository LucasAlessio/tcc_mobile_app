import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:tcc/models/questionnaire.dart';
import 'package:tcc/services/questionnaires_service.dart';

part 'questionnaire_states.dart';

class QuestionnaireCubit extends Cubit<QuestionnaireStates?> {
  QuestionnairesService service;

  QuestionnaireCubit()
      : service = QuestionnairesService(),
        super(null);

  Future<void> getQuestionnaire({
    required int id,
    required String token,
  }) async {
    emit(QuestionnaireLoading());

    try {
      Questionnaire data = await service.getById(id: id, token: token);
      emit(QuestionnaireSuccess(data));
    } on HttpException catch (error) {
      emit(QuestionnaireError(error.message));
    } catch (error) {
      emit(QuestionnaireError(
          "Ocorreu um erro ao carregar as informações do instrumento"));
    }
  }
}