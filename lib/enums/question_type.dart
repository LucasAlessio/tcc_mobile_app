enum QuestionType {
  shortText("1"),
  longText("2"),
  choice("3");

  final String value;

  const QuestionType(this.value);

  static QuestionType getFromValue(String value) {
    Map<String, QuestionType> values = QuestionType.values.fold(
      {},
      (previousValue, element) {
        return {
          ...previousValue,
          element.value: element,
        };
      },
    );

    return values[value] ?? QuestionType.shortText;
  }
}
