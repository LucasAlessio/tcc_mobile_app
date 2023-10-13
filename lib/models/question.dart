import 'package:tcc/enums/question_type.dart';
import 'package:tcc/models/alternative.dart';

class Question {
  int id;
  String description;
  QuestionType type;
  DateTime createdAt;
  DateTime updatedAt;
  final List<Alternative> _alternatives = [];

  Question({
    required this.id,
    required this.description,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  Question.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        description = map["description"],
        type = QuestionType.getFromValue(map["type"]),
        createdAt = DateTime.parse(map["created_at"]),
        updatedAt = DateTime.parse(map["updated_at"]);

  @override
  String toString() {
    return "[$id]$description \ncreated_at: $createdAt\nupdated_at:$updatedAt";
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "description": description,
      "type": type,
      "created_at": createdAt.toString(),
      "updated_at": updatedAt.toString(),
    };
  }

  List<Alternative> get alternatives => _alternatives;

  void addAlternative(Alternative alternative) {
    _alternatives.add(alternative);
  }
}
