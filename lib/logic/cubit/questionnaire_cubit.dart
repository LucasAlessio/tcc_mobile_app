import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:tcc/exceptions/unauthorized_exception.dart';
import 'package:tcc/models/questionnaire.dart';
import 'package:tcc/services/questionnaires_service.dart';

part 'questionnaire_states.dart';

class QuestionnaireCubit extends Cubit<QuestionnaireStates?> {
  final QuestionnairesService service = QuestionnairesService();

  QuestionnaireCubit() : super(null);

  Future<void> getQuestionnaire({
    required int id,
  }) async {
    emit(QuestionnaireLoading());

    try {
      Questionnaire data = await service.getById(id);
      emit(QuestionnaireSuccess(data));
    } on UnauthorizedException catch (error) {
      emit(QuestionnaireError(error.message, unauthorized: true));
    } on HttpException catch (error) {
      emit(QuestionnaireError(error.message));
    } on SocketException catch (_) {
      emit(QuestionnaireError(
          "Verifique se o dispositivo está conectado à internet."));
    } catch (error) {
      emit(QuestionnaireError("Ocorreu um erro ao carregar os instrumentos."));
    }
  }
}
