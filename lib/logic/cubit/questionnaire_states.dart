part of 'questionnaire_cubit.dart';

abstract class QuestionnaireStates {}

class QuestionnaireLoading extends QuestionnaireStates {}

class QuestionnaireSuccess extends QuestionnaireStates {
  Questionnaire data;

  QuestionnaireSuccess(this.data);
}

class QuestionnaireError extends QuestionnaireStates {
  String message;

  QuestionnaireError(this.message);
}
