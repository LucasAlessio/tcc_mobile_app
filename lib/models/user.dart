class User {
  final String id;
  final String name;
  final String token;
  final DateTime expiresAt;

  User({
    required this.id,
    required this.name,
    required this.token,
    required this.expiresAt,
  });

  User.fromMap(Map<String, dynamic> map)
      : id = map["id"] ?? "",
        name = map["name"] ?? "",
        token = map["token"] ?? "",
        expiresAt =
            DateTime.parse(map["expires_at"] ?? DateTime.now().toString());
}
