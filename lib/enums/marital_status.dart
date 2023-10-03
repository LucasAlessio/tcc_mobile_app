enum MaritalStatus {
  single('single'),
  married('married'),
  separated('separated'),
  divorced('divorced'),
  widowed('widowed');

  final String value;

  const MaritalStatus(this.value);

  static Map<String, String> getDefinitions() {
    return {
      MaritalStatus.single.value: 'Solteiro',
      MaritalStatus.married.value: 'Casado',
      MaritalStatus.separated.value: 'Separado',
      MaritalStatus.divorced.value: 'Divorciado',
      MaritalStatus.widowed.value: 'Viúvo',
    };
  }
}
