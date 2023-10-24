enum Task {
  refreshToken("refresh-token"),
  notification("notification");

  final String name;

  const Task(this.name);

  static Task? getFromName(String name) {
    Map<String, Task> map = Task.values.fold(
      {},
      (previousValue, element) => {
        ...previousValue,
        element.name: element,
      },
    );

    return map[name];
  }
}
