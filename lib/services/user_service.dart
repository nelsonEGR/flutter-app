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
  /// Stub implementation for user service.
  ///
  /// Keep the interface (`IUserService`) intact. Methods throw
  /// [UnimplementedError] so that developers implement real logic
  /// (HTTP calls, caching, validation) when starting development.

  @override
  Future<User> getUserProfile(String userId) async {
    // TODO: Implement real API call
    throw UnimplementedError('UserService.getUserProfile no implementado.');
  }

  @override
  Future<void> updateProfile(User user) async {
    // TODO: Implement real API call
    throw UnimplementedError('UserService.updateProfile no implementado.');
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    // TODO: Implement real API call
    throw UnimplementedError('UserService.changePassword no implementado.');
  }
}
