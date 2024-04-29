import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:tcc/enums/question_type.dart';
import 'package:tcc/models/question.dart';

class ShortTextInput extends StatelessWidget {
  final int index;
  final Question question;

  const ShortTextInput(
    this.question, {
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (question.type != QuestionType.shortText) return const SizedBox.shrink();

    return FormBuilderTextField(
      name: 'questions.$index.comment',
      decoration: const InputDecoration(
        hintText: 'Digite sua resposta',
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
          errorText: "Todas questões devem ser respondidas",
        ),
      ]),
    );
  }
}
