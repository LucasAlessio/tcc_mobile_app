class Alternative {
  int id;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  Alternative({
    required this.id,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  Alternative.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        description = map["description"],
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
      "created_at": createdAt.toString(),
      "updated_at": updatedAt.toString(),
    };
  }
}
