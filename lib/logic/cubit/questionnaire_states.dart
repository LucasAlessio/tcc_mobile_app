part of 'questionnaire_cubit.dart';

abstract class QuestionnaireStates {}

class QuestionnaireLoading extends QuestionnaireStates {}

class QuestionnaireSuccess extends QuestionnaireStates {
  Questionnaire data;

  QuestionnaireSuccess(this.data);
}

class QuestionnaireError extends QuestionnaireStates {
  bool unauthorized;
  String message;

  QuestionnaireError(
    this.message, {
    this.unauthorized = false,
  });
}
