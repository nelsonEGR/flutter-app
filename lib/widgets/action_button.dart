import 'package:flutter/material.dart';

/// Botón de acción rápida reutilizable
/// 
/// Widget que muestra un botón cuadrado con icono y etiqueta.
/// Se usa en la sección de "Acciones Rápidas" del dashboard.
/// 
/// Características:
/// - Icono centrado en la parte superior
/// - Etiqueta debajo del icono
/// - Colores personalizables con fondo semi-transparente
/// - Responde al toque con callback onTap
/// 
/// Uso:
/// ```dart
/// ActionButton(
///   icon: Icons.person,
///   label: 'Editar Perfil',
///   onTap: () { /* acción */ },
/// )
/// ```
/// 
/// TODO: Agregar animaciones al presionar
class ActionButton extends StatelessWidget {
  /// Icono a mostrar
  final IconData icon;
  
  /// Texto debajo del icono
  final String label;
  
  /// Callback ejecutado al presionar
  final VoidCallback onTap;
  
  /// Color del icono, fondo y borde
  final Color color;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    // Simple reusable action button
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(color: color, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
