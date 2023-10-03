enum Schooling {
  incompleteElementaryEducation(1),
  completePrimaryEducation(2),
  incompleteHighSchool(3),
  completeHighSchool(4),
  incompleteHigherEducation(5),
  completeHigherEducation(6),
  postgraduate(7);

  final int value;

  const Schooling(this.value);

  static Map<int, String> getDefinitions() {
    return {
      Schooling.incompleteElementaryEducation.value:
          'Ensino fundamental Incompleto',
      Schooling.completePrimaryEducation.value: 'Ensino fundamental Completo',
      Schooling.incompleteHighSchool.value: 'Ensino médio incompleto',
      Schooling.completeHighSchool.value: 'Ensino médio completo',
      Schooling.incompleteHigherEducation.value: 'Ensino superior incompleto',
      Schooling.completeHigherEducation.value: 'Ensino superior completo',
      Schooling.postgraduate.value: 'Pós-graduação',
    };
  }
}
