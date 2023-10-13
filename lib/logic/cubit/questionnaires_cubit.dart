import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:tcc/exceptions/unauthorized_exception.dart';
import 'package:tcc/models/questionnaire.dart';
import 'package:tcc/services/questionnaires_service.dart';

part 'questionnaires_states.dart';

class QuestionnairesCubit extends Cubit<QuestionnairesStates?> {
  final QuestionnairesService service = QuestionnairesService();

  QuestionnairesCubit() : super(null);

  Future<void> getQuestionnaires({required String token}) async {
    emit(QuestionnairesLoading());

    try {
      List<Questionnaire> data = await service.getAll(token: token);
      emit(QuestionnairesSuccess(data));
    } on UnauthorizedException catch (error) {
      emit(QuestionnairesError(error.message, unauthorized: true));
    } on HttpException catch (error) {
      emit(QuestionnairesError(error.message));
    } on SocketException catch (_) {
      emit(QuestionnairesError(
          "Verifique se o dispositivo está conectado à internet."));
    } catch (error) {
      emit(QuestionnairesError("Ocorreu um erro ao carregar os instrumentos."));
    }
  }
}
