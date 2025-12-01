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
    /// Retorna un TextField con decoración personalizada
    /// 
    /// Decoración:
    /// - fillColor: Blanco
    /// - filled: true (para aplicar el color de fondo)
    /// - prefixIcon: Icono azul al inicio
    /// - border: Bordes redondeados sin línea visible
    /// - hintStyle: Gris claro para el texto sugerencia
    /// 
    /// Comportamiento:
    /// - obscureText: Oculta caracteres si es contraseña
    /// - keyboardType: Selecciona el tipo de teclado a mostrar
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(prefixIcon, color: Colors.blue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
