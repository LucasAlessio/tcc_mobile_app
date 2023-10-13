part of 'answer_cubit.dart';

abstract class AnswerStates {}

class AnswerLoading extends AnswerStates {}

class AnswerSuccess extends AnswerStates {}

class AnswerError extends AnswerStates {
  bool unauthorized;
  String message;

  AnswerError(
    this.message, {
    this.unauthorized = false,
  });
}

class AnswerValidationError extends AnswerStates {
  final Map<String, dynamic> errors;

  AnswerValidationError(this.errors);
}
