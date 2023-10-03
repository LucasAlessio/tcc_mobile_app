enum Gender {
  male("male"),
  female("female");

  final String value;

  const Gender(this.value);

  static Map<String, String> getDefinitions() {
    return {
      Gender.male.value: 'Masculino',
      Gender.female.value: 'Feminino',
    };
  }
}
