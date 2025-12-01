import '../models/models.dart';

/// Servicio de Autenticación
/// Aquí integras tu API de login
abstract class IAuthService {
  Future<AuthResponse> login(String username, String password);
  Future<void> logout();
  Future<AuthResponse> refreshToken();
}

class AuthService implements IAuthService {
  // TODO: Reemplaza esto con tu API real
  static const String _baseUrl = 'https://tu-api.com/api';

  @override
  Future<AuthResponse> login(String username, String password) async {
    try {
      // AQUÍ: Llamar a tu API real
      // final response = await http.post(
      //   Uri.parse('$_baseUrl/auth/login'),
      //   body: LoginRequest(username: username, password: password).toJson(),
      // );

      // Simulación de respuesta exitosa
      await Future.delayed(const Duration(seconds: 1));

      return AuthResponse(
        token: 'token_simulado_$username',
        refreshToken: 'refresh_token_simulado',
        expiresAt: DateTime.now().add(const Duration(hours: 24)),
      );
    } catch (e) {
      throw Exception('Error en login: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      // TODO: Llamar a tu API de logout si es necesario
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      throw Exception('Error en logout: $e');
    }
  }

  @override
  Future<AuthResponse> refreshToken() async {
    try {
      // TODO: Llamar a tu API para refrescar token
      await Future.delayed(const Duration(milliseconds: 500));
      return AuthResponse(
        token: 'nuevo_token',
        refreshToken: 'nuevo_refresh_token',
        expiresAt: DateTime.now().add(const Duration(hours: 24)),
      );
    } catch (e) {
      throw Exception('Error refrescando token: $e');
    }
  }
}
