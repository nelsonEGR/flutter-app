import 'package:flutter/material.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';
import 'dashboard_screen.dart';

/// Pantalla de Inicio de Sesión
/// 
/// Esta es la pantalla principal de autenticación que permite a los usuarios
/// iniciar sesión en la aplicación.
/// 
/// Componentes:
/// - Campo de usuario (username)
/// - Campo de contraseña (password)
/// - Botón de inicio de sesión con indicador de carga
/// 
/// Flujo:
/// 1. Usuario ingresa credenciales
/// 2. Se validan que no estén vacíos
/// 3. Se llama a [AuthService.login] para autenticar
/// 4. Si es exitoso, navega a [DashboardScreen]
/// 5. Si falla, muestra error en SnackBar
/// 
/// TODO: Agregar funcionalidades adicionales:
/// - "Olvidé mi contraseña" link
/// - Sign up / registración
/// - Autenticación biométrica
/// - Persistencia de sesión con SharedPreferences
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// Controlador para el campo de usuario
  final TextEditingController _usuarioController = TextEditingController();
  
  /// Controlador para el campo de contraseña
  final TextEditingController _passwordController = TextEditingController();
  
  /// Indica si está en proceso de login
  bool _isLoading = false;
  
  /// Instancia del servicio de autenticación
  /// 
  /// NOTA: En una aplicación real, usar Provider o GetIt para inyección de dependencias
  final AuthService _authService = AuthService();

  /// Maneja el login del usuario
  /// 
  /// Este método:
  /// 1. Valida que los campos no estén vacíos
  /// 2. Muestra indicador de carga
  /// 3. Llama al servicio de autenticación
  /// 4. Navega al dashboard si es exitoso
  /// 5. Muestra errores si falla
  /// 
  /// TODO: Mejorar validación:
  /// - Validar formato de usuario (email o username)
  /// - Validar longitud mínima de contraseña
  /// - Implementar rate limiting para prevenir fuerza bruta
  void _handleLogin() async {
    final usuario = _usuarioController.text.trim();
    final password = _passwordController.text.trim();

    // Validar que los campos no estén vacíos
    if (usuario.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos')),
      );
      return;
    }

    // Mostrar indicador de carga
    setState(() {
      _isLoading = true;
    });

    try {
      // Llamar al servicio de autenticación
      // Este método retornará un AuthResponse con el token
      // que se puede guardar en SharedPreferences o Provider
      await _authService.login(usuario, password);

      // Navegar al dashboard solo si el widget sigue montado
      // (para evitar errors si el usuario sale rápido)
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => DashboardScreen(usuario: usuario),
          ),
        );
      }
    } catch (e) {
      // Mostrar error si falla el login
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      // Ocultar indicador de carga
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // Importante: Limpiar los controladores para evitar memory leaks
    _usuarioController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Build retorna un Scaffold con:
    /// - Container con gradiente de fondo (azul)
    /// - SingleChildScrollView para permitir scroll en pantallas pequeñas
    /// - Column centrada con:
    ///   - Icono de seguridad
    ///   - Título "Iniciar Sesión"
    ///   - Campo de usuario
    ///   - Campo de contraseña
    ///   - Botón de login con indicador de carga
    /// 
    /// TODO: Mejorar UI:
    /// - Agregar animaciones de transición
    /// - Implementar validación en tiempo real (red border si hay error)
    /// - Agregar biometric auth button
    /// - Agregar "Remember me" checkbox
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade400,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 32),
                Text(
                  'Iniciar Sesión',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  controller: _usuarioController,
                  hintText: 'Usuario',
                  prefixIcon: Icons.person,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Contraseña',
                  prefixIcon: Icons.lock,
                  obscureText: true,
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  label: 'Ingresar',
                  onPressed: _handleLogin,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
