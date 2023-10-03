import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:tcc/exceptions/validation_exception.dart';
import 'package:tcc/services/questionnaires_service.dart';

part 'answer_states.dart';

class AnswerCubit extends Cubit<AnswerStates?> {
  QuestionnairesService service;

  AnswerCubit()
      : service = QuestionnairesService(),
        super(null);

  Future<void> answer({
    required int id,
    required String token,
    required Map<String, dynamic> data,
  }) async {
    emit(AnswerLoading());

    try {
      await service.answer(
        id: id,
        token: token,
        data: data,
      );
      emit(AnswerSuccess());
    } on ValidationException catch (error) {
      emit(AnswerValidationError(error.errors));
    } on HttpException catch (error) {
      emit(AnswerError(error.message));
    } catch (error) {
      emit(AnswerError("Ocorreu um erro ao atualizar o perfil"));
    }
  }

  // Future<void> saveProfile({required })
}
