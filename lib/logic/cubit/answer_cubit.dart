import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:tcc/exceptions/unauthorized_exception.dart';
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
    } on UnauthorizedException catch (error) {
      emit(AnswerError(error.message, unauthorized: true));
    } on HttpException catch (error) {
      emit(AnswerError(error.message));
    } on SocketException catch (_) {
      emit(
          AnswerError("Verifique se o dispositivo está conectado à internet."));
    } catch (error) {
      emit(AnswerError("Ocorreu um erro ao submter as respostas."));
    }
  }
}
