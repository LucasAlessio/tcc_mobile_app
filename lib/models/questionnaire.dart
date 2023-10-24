import 'package:tcc/models/question.dart';

class Questionnaire {
  int id;
  String name;
  String description;
  int recurrence;
  DateTime createdAt;
  DateTime updatedAt;
  bool disabled;
  DateTime? disabledUntil;
  final List<Question> _questions = [];

  Questionnaire({
    required this.id,
    required this.name,
    required this.description,
    required this.recurrence,
    required this.disabled,
    required this.disabledUntil,
    required this.createdAt,
    required this.updatedAt,
  });

  Questionnaire.empty()
      : id = 0,
        name = "",
        description = "",
        recurrence = 0,
        disabled = false,
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  Questionnaire.fromMap(Map<String, dynamic> map)
      : id = map["id"] ?? "",
        name = map["name"] ?? "",
        description = map["description"] ?? "",
        recurrence = map["recurrence"] ?? "",
        disabled = !!(map["disabled"] ?? false),
        disabledUntil = (!!(map["disabled"] ?? false) &&
                (map["disabled_until"]?.toString() ?? "").isNotEmpty)
            ? DateTime.parse(map["disabled_until"])
            : null,
        createdAt =
            DateTime.parse(map["created_at"] ?? DateTime.now().toString()),
        updatedAt =
            DateTime.parse(map["updated_at"] ?? DateTime.now().toString());

  @override
  String toString() {
    return "[$id]$name \ncreated_at: $createdAt\nupdated_at:$updatedAt";
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "recurrence": recurrence,
      "created_at": createdAt.toString(),
      "updated_at": updatedAt.toString(),
      "questions": _questions,
    };
  }

  List<Question> get questions => _questions;

  void addQuestion(Question question) {
    _questions.add(question);
  }
}
