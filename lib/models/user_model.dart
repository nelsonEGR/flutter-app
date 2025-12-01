/// Modelo de Usuario
/// 
/// Representa los datos de un usuario en la aplicación.
/// Contiene métodos para serializar/deserializar a JSON.
/// 
/// Ejemplo:
/// ```dart
/// final user = User.fromJson({'id': '1', 'username': 'carlos'});
/// final json = user.toJson();
/// ```
class User {
  final String id;                    // ID único del usuario
  final String username;              // Nombre de usuario
  final String email;                 // Email
  final DateTime createdAt;           // Fecha de creación de cuenta
  final int loginCount;               // Cantidad de veces que inició sesión
  final DateTime? lastLogin;          // Último acceso (nullable)

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.createdAt,
    this.loginCount = 0,
    this.lastLogin,
  });

  /// Crea un User desde JSON (respuesta de API)
  /// 
  /// Transforma un Map de JSON en un objeto User tipado.
  /// Se usa cuando recibes datos del servidor.
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

  /// Convierte User a JSON (para enviar a API)
  /// 
  /// Transforma un objeto User en un Map que pueda
  /// ser serializado a JSON para enviar al servidor.
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

  /// Crea una copia del User con algunos campos modificados
  /// 
  /// Útil cuando necesitas actualizar solo algunos datos
  /// sin modificar el objeto original.
  /// 
  /// Ejemplo:
  /// ```dart
  /// final usuarioActualizado = user.copyWith(loginCount: 6);
  /// ```
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
