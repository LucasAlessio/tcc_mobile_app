import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tcc/models/alternative.dart';
import 'package:tcc/models/question.dart';
import 'package:tcc/models/questionnaire.dart';
import 'package:tcc/services/web_client.dart';

class QuestionnairesService {
  String url = WebClient.url;
  http.Client client = WebClient.client;

  static const String resource = "questionnaires/";

  Future<List<Questionnaire>> getAll() async {
    http.Response response = await client.get(
      Uri.parse("$url$resource"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    List<dynamic> raw = json.decode(response.body);
    List<Questionnaire> questionnaires = [];

    for (Map<String, dynamic> map in raw) {
      questionnaires.add(Questionnaire.fromMap(map));
    }

    return questionnaires;
  }

  Future<Questionnaire> getById(int id) async {
    http.Response response = await client.get(
      Uri.parse("$url$resource$id"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    Map<String, dynamic> raw = json.decode(response.body);

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
    required Map<String, dynamic> data,
  }) async {
    await client.post(
      Uri.parse("$url$resource$id/answer"),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(data),
    );
  }
}
