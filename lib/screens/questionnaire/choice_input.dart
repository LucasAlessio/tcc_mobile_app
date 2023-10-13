import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:tcc/enums/question_type.dart';
import 'package:tcc/models/question.dart';

class ChoiceInput extends StatelessWidget {
  final int index;
  final Question question;

  const ChoiceInput(
    this.question, {
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (question.type != QuestionType.choice) return const SizedBox.shrink();

    return FormBuilderRadioGroup(
      name: 'questions.$index.alternative',
      decoration: const InputDecoration(
        filled: false,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        isDense: true,
        isCollapsed: true,
      ),
      options: question.alternatives.map((e) {
        return FormBuilderFieldOption(
          value: e.id,
          child: Text(e.description),
        );
      }).toList(),
      orientation: OptionsOrientation.vertical,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
          errorText: "Todas questões devem ser respondidas",
        ),
      ]),
    );
  }
}
