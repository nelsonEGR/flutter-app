import 'package:flutter/material.dart';

/// Campo de texto personalizado reutilizable
/// 
/// Widget que encapsula un TextField con estilo consistente.
/// Proporciona un campo de entrada con icono, hint text y estilos personalizados.
/// 
/// Características:
/// - Fondo blanco con bordes redondeados
/// - Icono personalizable en el prefijo
/// - Soporte para texto oculto (para contraseñas)
/// - Tipo de teclado personalizable
/// 
/// Uso:
/// ```dart
/// CustomTextField(
///   controller: _usernameController,
///   hintText: 'Usuario',
///   prefixIcon: Icons.person,
/// )
/// 
/// CustomTextField(
///   controller: _passwordController,
///   hintText: 'Contraseña',
///   prefixIcon: Icons.lock,
///   obscureText: true,
/// )
/// ```
/// 
/// TODO: Agregar funcionalidades:
/// - Validación en tiempo real (error messages)
/// - Label text opcionales
/// - Sufijo icono (ej: eye para toggle obscure)
/// - Máximo de caracteres
/// - onChanged callback
class CustomTextField extends StatelessWidget {
  /// Controlador para obtener el valor del campo
  final TextEditingController controller;
  
  /// Texto sugerencia que aparece cuando está vacío
  final String hintText;
  
  /// Icono que aparece al inicio del campo
  final IconData prefixIcon;
  
  /// Si es true, oculta el texto (para contraseñas)
  final bool obscureText;
  
  /// Tipo de teclado que se muestra
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    // Minimal TextField wrapper to keep API surface intact.
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
