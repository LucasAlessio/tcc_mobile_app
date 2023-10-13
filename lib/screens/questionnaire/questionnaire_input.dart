import 'package:flutter/material.dart';
import 'package:tcc/enums/question_type.dart';
import 'package:tcc/models/question.dart';
import 'package:tcc/screens/questionnaire/choice_input.dart';
import 'package:tcc/screens/questionnaire/long_text_input.dart';
import 'package:tcc/screens/questionnaire/short_text_input.dart';

class QuestionnaireInput extends StatelessWidget {
  final int index;
  final Question question;

  const QuestionnaireInput(
    this.question, {
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (question.type == QuestionType.shortText) {
      return ShortTextInput(question, index: index);
    }

    if (question.type == QuestionType.longText) {
      return LongTextInput(question, index: index);
    }

    return ChoiceInput(question, index: index);
  }
}
