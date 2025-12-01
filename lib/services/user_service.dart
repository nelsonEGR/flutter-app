import '../models/models.dart';

/// Servicio de Usuario
/// Aquí obtienes los datos del usuario desde tu API
abstract class IUserService {
  Future<User> getUserProfile(String userId);
  Future<void> updateProfile(User user);
  Future<void> changePassword(String oldPassword, String newPassword);
}

class UserService implements IUserService {
  // TODO: Reemplaza esto con tu API real
  static const String _baseUrl = 'https://tu-api.com/api';

  @override
  Future<User> getUserProfile(String userId) async {
    try {
      // TODO: Llamar a tu API real
      // final response = await http.get(
      //   Uri.parse('$_baseUrl/users/$userId'),
      // );

      // Simulación de respuesta
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

  @override
  Future<void> updateProfile(User user) async {
    try {
      // TODO: Llamar a tu API real
      // final response = await http.put(
      //   Uri.parse('$_baseUrl/users/${user.id}'),
      //   body: user.toJson(),
      // );

      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      throw Exception('Error actualizando perfil: $e');
    }
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      // TODO: Llamar a tu API real
      // final response = await http.post(
      //   Uri.parse('$_baseUrl/users/change-password'),
      //   body: {
      //     'oldPassword': oldPassword,
      //     'newPassword': newPassword,
      //   },
      // );

      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      throw Exception('Error cambiando contraseña: $e');
    }
  }
}
