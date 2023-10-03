import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tcc/exceptions/validation_exception.dart';
import 'package:tcc/models/alternative.dart';
import 'package:tcc/models/question.dart';
import 'package:tcc/models/questionnaire.dart';
import 'package:tcc/services/web_client.dart';

class QuestionnairesService {
  String url = WebClient.url;
  http.Client client = WebClient.client;

  static const String resource = "questionnaires/";

  Future<List<Questionnaire>> getAll({required String token}) async {
    http.Response response = await client.get(
      Uri.parse("$url$resource"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
    );

    if (response.statusCode >= 300) {
      throw HttpException(response.body);
    }

    List<dynamic> raw = json.decode(response.body);

    List<Questionnaire> questionnaires = [];

    for (Map<String, dynamic> map in raw) {
      questionnaires.add(Questionnaire.fromMap(map));
    }

    return questionnaires;
  }

  Future<Questionnaire> getById({
    required int id,
    required String token,
  }) async {
    http.Response response = await client.get(
      Uri.parse("$url$resource$id"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    Map<String, dynamic> raw = json.decode(response.body);

    if (response.statusCode >= 300) {
      print(raw);
      throw HttpException(raw["message"] ??
          "Ocorreu um erro ao obter as informações do instrumento");
    }

    Questionnaire questionnaire;

    questionnaire = Questionnaire.fromMap(raw);

    List<dynamic> rawQuestions = raw["questions"];

    for (Map<String, dynamic> mapQuestion in rawQuestions) {
      Question question = Question.fromMap(mapQuestion);

      List<dynamic> rawAlternatives = mapQuestion["alternatives"];

      for (Map<String, dynamic> mapAlternative in rawAlternatives) {
        Alternative alternative = Alternative.fromMap(mapAlternative);

        question.addAlternative(alternative);
      }

      questionnaire.addQuestion(question);
    }

    return questionnaire;
  }

  Future<void> answer({
    required int id,
    required String token,
    required Map<String, dynamic> data,
  }) async {
    http.Response response = await client.post(
      Uri.parse("${url}questionnaires/$id/answer/"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: json.encode(data),
    );

    if (response.statusCode >= 300) {
      if (response.statusCode == HttpStatus.unprocessableEntity) {
        throw ValidationException.fromErrorResponse(response.body);
      }

      throw HttpException(response.body);
    }
  }
}
