import 'package:flutter/material.dart';

/// Tarjeta de estadística reutilizable
/// 
/// Widget que muestra una estadística con icono, valor y título.
/// Se usa en la sección de "Estadísticas" del dashboard.
/// 
/// Características:
/// - Icono personalizable en la parte superior
/// - Valor grande y destacado
/// - Título descriptivo pequeño
/// - Colores personalizables con fondo semi-transparente
/// 
/// Uso:
/// ```dart
/// StatisticCard(
///   title: 'Inicios de Sesión',
///   value: '5',
///   icon: Icons.login,
///   color: Colors.blue,
/// )
/// ```
class StatisticCard extends StatelessWidget {
  /// Título de la estadística
  final String title;
  
  /// Valor a mostrar (número grande)
  final String value;
  
  /// Icono de la tarjeta
  final IconData icon;
  
  /// Color del icono, valor y borde
  final Color color;

  const StatisticCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Minimal visual card for stats
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
