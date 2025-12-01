import '../models/models.dart';

/// Servicio de Usuario
/// 
/// Maneja todas las operaciones relacionadas con el perfil del usuario:
/// - Obtener datos del usuario
/// - Actualizar perfil
/// - Cambiar contraseña
/// 
/// Comunica con la API de usuarios del backend.
/// 
/// Flujo:
/// 1. [getUserProfile] obtiene datos del usuario
/// 2. [updateProfile] actualiza información
/// 3. [changePassword] cambia la contraseña
abstract class IUserService {
  Future<User> getUserProfile(String userId);
  Future<void> updateProfile(User user);
  Future<void> changePassword(String oldPassword, String newPassword);
}

class UserService implements IUserService {
  // TODO: Reemplaza esto con tu URL de API real
  static const String _baseUrl = 'https://tu-api.com/api';

  /// Obtiene el perfil completo del usuario
  /// 
  /// Parámetros:
  /// - [userId]: ID del usuario a obtener
  /// 
  /// Retorna:
  /// - [User]: Objeto con todos los datos del usuario
  /// 
  /// Próximo: Reemplazar Future.delayed con tu API real
  @override
  Future<User> getUserProfile(String userId) async {
    try {
      // TODO: Llamar a tu API real:
      // final response = await http.get(
      //   Uri.parse('$_baseUrl/users/$userId'),
      //   headers: {'Authorization': 'Bearer $token'},
      // );
      // 
      // if (response.statusCode == 200) {
      //   return User.fromJson(jsonDecode(response.body));
      // } else {
      //   throw Exception('Error ${response.statusCode}');
      // }

      // Simulación: Retorna un usuario de ejemplo
      await Future.delayed(const Duration(milliseconds: 500));

      return User(
        id: userId,
        username: userId,
        email: '$userId@example.com',
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        loginCount: 5,
        lastLogin: DateTime.now().subtract(const Duration(hours: 2)),
      );
    } catch (e) {
      throw Exception('Error obteniendo perfil: $e');
    }
  }

  /// Actualiza los datos del perfil del usuario
  /// 
  /// Parámetros:
  /// - [user]: Objeto User con datos actualizados
  /// 
  /// Lanza excepción si la actualización falla
  /// 
  /// Próximo: Integrar con tu API de actualización
  @override
  Future<void> updateProfile(User user) async {
    try {
      // TODO: Llamar a tu API real:
      // final response = await http.put(
      //   Uri.parse('$_baseUrl/users/${user.id}'),
      //   headers: {
      //     'Authorization': 'Bearer $token',
      //     'Content-Type': 'application/json',
      //   },
      //   body: jsonEncode(user.toJson()),
      // );
      // 
      // if (response.statusCode != 200) {
      //   throw Exception('Error: ${response.body}');
      // }

      // Simular
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      throw Exception('Error actualizando perfil: $e');
    }
  }

  /// Cambia la contraseña del usuario
  /// 
  /// Parámetros:
  /// - [oldPassword]: Contraseña actual (para validar)
  /// - [newPassword]: Nueva contraseña
  /// 
  /// NOTA: La contraseña debe cumplir requisitos de seguridad
  /// (mínimo 8 caracteres, mayúsculas, números, etc)
  /// 
  /// Próximo: Validar contraseña antes de enviar
  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      // TODO: Llamar a tu API real:
      // final response = await http.post(
      //   Uri.parse('$_baseUrl/users/change-password'),
      //   headers: {
      //     'Authorization': 'Bearer $token',
      //     'Content-Type': 'application/json',
      //   },
      //   body: jsonEncode({
      //     'oldPassword': oldPassword,
      //     'newPassword': newPassword,
      //   }),
      // );

      // Simular
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      throw Exception('Error cambiando contraseña: $e');
    }
  }
}
