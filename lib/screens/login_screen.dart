import 'package:flutter/material.dart';

// NOTE: This screen is a minimal placeholder preserving the screen file
// and architecture. Implement the real login UI and logic when ready.

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
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Minimal placeholder screen
    return Scaffold(
      appBar: AppBar(title: const Text('Login (placeholder)')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Pantalla de Login vacía. Implementa tu UI aquí.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Placeholder navigation — replace when implementing
                Navigator.of(context).pushReplacementNamed('/dashboard');
              },
              child: const Text('Ir al Dashboard (placeholder)'),
            ),
          ],
        ),
      ),
    );
  }
}
