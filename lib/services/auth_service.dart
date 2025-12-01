import '../models/models.dart';

/// Servicio de Autenticación
/// 
/// Responsable de manejar el login y logout de usuarios.
/// Comunica con el backend para validar credenciales y obtener tokens.
/// 
/// Flujo:
/// 1. Usuario ingresa credenciales
/// 2. [login] envía a la API
/// 3. API retorna token y refreshToken
/// 4. Se guardan de forma segura
/// 5. Se usa para futuras peticiones
/// 
/// Próximo: Integra con tu API real (ver comentarios TODO)
abstract class IAuthService {
  Future<AuthResponse> login(String username, String password);
  Future<void> logout();
  Future<AuthResponse> refreshToken();
}
class AuthService implements IAuthService {
  /// Implementación mínima del servicio de autenticación.
  ///
  /// Nota: Se mantiene la interfaz (`IAuthService`) para no romper la
  /// arquitectura. Esta clase actualmente actúa como stub y lanza
  /// [UnimplementedError] en los métodos, indicando que aquí debe
  /// integrarse la lógica real (HTTP, storage, refresh token, etc.).
  ///
  /// Mantener esta clase permite a los desarrolladores enlazar la
  /// dependencia en la app mientras se implementa la integración real.

  @override
  Future<AuthResponse> login(String username, String password) async {
    // TODO: Implementar integración con backend (http/dio)
    throw UnimplementedError('AuthService.login no implementado.');
  }

  @override
  Future<void> logout() async {
    // TODO: Implementar logout y limpieza de sesión
    throw UnimplementedError('AuthService.logout no implementado.');
  }

  @override
  Future<AuthResponse> refreshToken() async {
    // TODO: Implementar refresh token
    throw UnimplementedError('AuthService.refreshToken no implementado.');
  }
}
