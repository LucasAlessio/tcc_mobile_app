import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tcc/components/spacer.dart' as common;
import 'package:tcc/enums/question_type.dart';
import 'package:tcc/models/question.dart';
import 'package:tcc/models/questionnaire.dart';
import 'package:tcc/screens/questionnaire/answer_button.dart';
import 'package:tcc/screens/questionnaire/questionnaire_input.dart';

class Form extends StatelessWidget {
  final Questionnaire _questionnaire;
  final bool isFetched;
  final _formKey = GlobalKey<FormBuilderState>();

  Form({
    Key? key,
    required Questionnaire questionnaire,
    this.isFetched = false,
  })  : _questionnaire = questionnaire,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(_questionnaire.description),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ..._questionnaire.questions.asMap().entries.map((e) {
                Question question = _questionnaire.questions[e.key];

                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormBuilderField(
                            name: 'questions.${e.key}.id',
                            enabled: false,
                            initialValue: e.value.id,
                            builder: (FormFieldState<dynamic> field) {
                              //Empty widget
                              return const SizedBox.shrink();
                            },
                          ),
                          Text(
                            e.value.description,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          question.type == QuestionType.choice
                              ? const Divider(
                                  thickness: 1,
                                )
                              : const common.Spacer(
                                  height: 12,
                                ),
                          QuestionnaireInput(
                            _questionnaire.questions[e.key],
                            index: e.key,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ]),
          ),
          SliverToBoxAdapter(
            child: Builder(
              builder: (context) {
                if (!isFetched) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                  child: SizedBox(
                    width: double.infinity,
                    child: AnswerButton(
                      id: _questionnaire.id,
                      formKey: _formKey,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
