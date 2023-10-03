part of 'questionnaires_cubit.dart';

abstract class QuestionnairesStates {}

class QuestionnairesLoading extends QuestionnairesStates {}

class QuestionnairesSuccess extends QuestionnairesStates {
  bool isEmpty = true;
  List<Questionnaire> data = [];

  QuestionnairesSuccess(this.data) : isEmpty = data.isEmpty;
}

class QuestionnairesError extends QuestionnairesStates {
  String message;

  QuestionnairesError(this.message);
}
