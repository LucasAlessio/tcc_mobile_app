enum QuestionType {
  shortText("1"),
  longText("2"),
  choice("3");

  final String value;

  const QuestionType(this.value);

  static QuestionType getFromValue(String value) {
    Map<String, QuestionType> map = {
      QuestionType.shortText.value: QuestionType.shortText,
      QuestionType.longText.value: QuestionType.longText,
      QuestionType.choice.value: QuestionType.choice,
    };

    return map[value] ?? QuestionType.choice;
  }
}
