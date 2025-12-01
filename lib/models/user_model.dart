class User {
  final String id;
  final String username;
  final String email;
  final DateTime createdAt;
  final int loginCount;
  final DateTime? lastLogin;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.createdAt,
    this.loginCount = 0,
    this.lastLogin,
  });

  // Convertir desde JSON (para tus APIs)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      loginCount: json['loginCount'] as int? ?? 0,
      lastLogin: json['lastLogin'] != null
          ? DateTime.parse(json['lastLogin'] as String)
          : null,
    );
  }

  // Convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
      'loginCount': loginCount,
      'lastLogin': lastLogin?.toIso8601String(),
    };
  }

  // Copiar con cambios
  User copyWith({
    String? id,
    String? username,
    String? email,
    DateTime? createdAt,
    int? loginCount,
    DateTime? lastLogin,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      loginCount: loginCount ?? this.loginCount,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }
}
