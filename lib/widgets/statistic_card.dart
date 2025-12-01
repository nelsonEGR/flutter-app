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
    /// Retorna un Container con información de estadística
    /// 
    /// Estructura:
    /// - Container: Fondo semi-transparente con bordes
    /// - Column: Organiza verticalmentei icono, valor, título
    /// 
    /// Orden visual:
    /// 1. Icono (24px)
    /// 2. Espacio (8px)
    /// 3. Valor grande (20px bold)
    /// 4. Espacio (4px)
    /// 5. Título pequeño gris (11px)
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
