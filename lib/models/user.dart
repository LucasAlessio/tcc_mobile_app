import 'dart:convert';

class User {
  final int id;
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
      : id = map["user"]["id"] ?? 0,
        name = map["user"]["name"] ?? "",
        token = map["token"] ?? "",
        expiresAt =
            DateTime.parse(map["expires_at"] ?? DateTime.now().toString());

  @override
  String toString() {
    return json.encode({
      id: id,
      name: name,
      token: token,
    });
  }
}
