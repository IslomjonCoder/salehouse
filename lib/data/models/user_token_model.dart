class UserToken {
  String accessToken;
  String tokenType;
  int expiresIn;
  User user;

  UserToken({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'user': user,
    };
  }

  factory UserToken.fromJson(Map<String, dynamic> map) {
    return UserToken(
      accessToken: map['access_token'] as String,
      tokenType: map['token_type'] as String,
      expiresIn: map['expires_in'] as int,
      user: User.fromMap(map['user']),
    );
  }
}

class User {
  int id;
  String name;
  String login;
  String password;
  String role;
  String status;
  dynamic createdAt;
  DateTime? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.login,
    required this.password,
    required this.role,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'login': login,
      'password': password,
      'role': role,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    final updatedAt = map['updated_at'] as String?;

    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      login: map['login'] as String,
      password: map['password'] as String,
      role: map['role'] as String,
      status: map['status'] as String,
      createdAt: map['created_at'] as dynamic,
      updatedAt: updatedAt == null ? null : DateTime.parse(updatedAt),
    );
  }
}
