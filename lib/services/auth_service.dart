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
  // TODO: Reemplaza esto con tu URL de API real
  // Ejemplo: 'https://tu-api.com/api'
  static const String _baseUrl = 'https://tu-api.com/api';

  @override
  Future<AuthResponse> login(String username, String password) async {
    try {
      // IMPORTANTE: Reemplaza esto con tu API real:
      // final response = await http.post(
      //   Uri.parse('$_baseUrl/auth/login'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: jsonEncode({
      //     'username': username,
      //     'password': password,
      //   }),
      // );
      // 
      // if (response.statusCode == 200) {
      //   return AuthResponse.fromJson(jsonDecode(response.body));
      // } else {
      //   throw Exception('Error: ${response.body}');
      // }

      // POR AHORA: Simular respuesta exitosa (remover cuando uses API real)
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
      // TODO: Llamar a tu API de logout
      // final response = await http.post(
      //   Uri.parse('$_baseUrl/auth/logout'),
      //   headers: {'Authorization': 'Bearer $token'},
      // );

      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      throw Exception('Error en logout: $e');
    }
  }

  @override
  Future<AuthResponse> refreshToken() async {
    try {
      // TODO: Llamar a tu API para refrescar token
      // final response = await http.post(
      //   Uri.parse('$_baseUrl/auth/refresh'),
      //   body: jsonEncode({'refreshToken': currentRefreshToken}),
      // );

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
