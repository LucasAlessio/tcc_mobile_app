enum FamilyIncome {
  upTo3MinimumWages(1),
  from4To6MinimumWages(2),
  from7To11MinimumWages(3),
  above11MinimumWages(4);

  final int value;

  const FamilyIncome(this.value);

  static Map<int, String> getDefinitions() {
    return {
      FamilyIncome.upTo3MinimumWages.value: 'Até 3 salários mínimos',
      FamilyIncome.from4To6MinimumWages.value: 'De 4 a 6 salários mínimos',
      FamilyIncome.from7To11MinimumWages.value: 'De 7 a 11 salários mínimos',
      FamilyIncome.above11MinimumWages.value: 'Acima de 11 salários mínimos',
    };
  }
}
