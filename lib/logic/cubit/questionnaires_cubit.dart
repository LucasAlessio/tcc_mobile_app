import 'package:bloc/bloc.dart';
import 'package:tcc/models/questionnaire.dart';
import 'package:tcc/services/questionnaires_service.dart';

part 'questionnaires_states.dart';

class QuestionnairesCubit extends Cubit<QuestionnairesStates?> {
  QuestionnairesService service;

  QuestionnairesCubit()
      : service = QuestionnairesService(),
        super(null);

  Future<void> getQuestionnaires({required String token}) async {
    emit(QuestionnairesLoading());

    try {
      List<Questionnaire> data = await service.getAll(token: token);
      emit(QuestionnairesSuccess(data));
    } catch (error) {
      emit(QuestionnairesError(error.toString()));
    }
  }
}
