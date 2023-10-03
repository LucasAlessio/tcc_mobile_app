part of 'answer_cubit.dart';

abstract class AnswerStates {}

class AnswerLoading extends AnswerStates {}

class AnswerSuccess extends AnswerStates {}

class AnswerError extends AnswerStates {
  String message;

  AnswerError(this.message);
}

class AnswerValidationError extends AnswerStates {
  final Map<String, dynamic> errors;

  AnswerValidationError(this.errors);
}
