import 'package:flutter/material.dart';
import 'screens/screens.dart';

/// Punto de entrada de la aplicación
/// 
/// Esta es la función main que se ejecuta cuando se inicia la app.
/// Simplemente ejecuta [MyApp] que es el widget raíz.
void main() {
  runApp(const MyApp());
}

/// Widget raíz de la aplicación
/// 
/// Configura:
/// - Título: "My App"
/// - Tema: Material 3 con color base azul
/// - Pantalla inicial: [LoginScreen] (autenticación)
/// 
/// Arquitectura:
/// - Material Design 3: Última especificación de Material Design
/// - ColorScheme fromSeed: Genera paleta de colores desde color base
/// 
/// Flujo de la app:
/// 1. Usuario ve LoginScreen
/// 2. Después de autenticar, navega a DashboardScreen
/// 3. Desde Dashboard puede ver notificaciones, editar perfil, etc
/// 
/// TODO: Mejoras futuras:
/// - Agregar Provider para state management global
/// - Implementar persistencia de sesión
/// - Agregar navegación más compleja con named routes
/// - Agregar error handling global
/// - Localización (múltiples idiomas)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // Pantalla inicial - mostrar LoginScreen primero
      home: const LoginScreen(),
    );
  }
}
