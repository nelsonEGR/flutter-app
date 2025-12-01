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
    /// Retorna un GestureDetector con Container personalizado
    /// 
    /// Estructura:
    /// - GestureDetector: Detecta toque y ejecuta onTap
    /// - Container: Fondo semi-transparente con bordes
    /// - Column: Centra icono y label verticalmente
    /// 
    /// Estilos:
    /// - fillColor: Semi-transparente (10% de opacidad)
    /// - border: Semi-transparente (30% de opacidad)
    /// - borderRadius: 12 píxeles
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
