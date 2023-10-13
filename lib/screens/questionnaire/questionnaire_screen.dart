import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcc/logic/cubit/answer_cubit.dart';
import 'package:tcc/logic/cubit/questionnaire_cubit.dart';
import 'package:tcc/screens/questionnaire/content.dart';

class QuestionnaireScreen extends StatelessWidget {
  final int id;
  final String name;

  const QuestionnaireScreen({
    Key? key,
    required this.id,
    required this.name,
  })  : assert(id > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<QuestionnaireCubit>(
            create: (context) => QuestionnaireCubit(),
          ),
          BlocProvider<AnswerCubit>(
            create: (context) => AnswerCubit(),
          ),
        ],
        child: Content(id: id),
      ),
      primary: true,
    );
  }
}
