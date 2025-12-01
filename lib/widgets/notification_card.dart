import 'package:flutter/material.dart';
import '../models/notification_model.dart' as notif_model;

/// Tarjeta de notificación reutilizable
/// 
/// Widget que muestra una notificación individual con:
/// - Icono que varía según el tipo
/// - Título y mensaje
/// - Fecha relativa (ej: "Hace 2 horas")
/// 
/// Características:
/// - Color dinámico según el tipo de notificación
/// - Icono diferente para success, warning, error, info
/// - Formato de fecha relativa
/// - Descripción truncada a 2 líneas
/// 
/// Tipos de notificación soportados:
/// - Success (verde): ✓ check_circle
/// - Warning (naranja): ⚠ warning
/// - Error (rojo): ✗ error
/// - Info (azul): ℹ info
/// 
/// Uso:
/// ```dart
/// NotificationCard(notification: notificationObject)
/// ```
class NotificationCard extends StatelessWidget {
  /// Objeto notificación a mostrar
  final notif_model.Notification notification;

  const NotificationCard({
    super.key,
    required this.notification,
  });

  Color _getColorByType(notif_model.NotificationType tipo) {
    // Keep mapping small and deterministic. For starter project fine defaults.
    switch (tipo) {
      case notif_model.NotificationType.success:
        return Colors.green;
      case notif_model.NotificationType.warning:
        return Colors.orange;
      case notif_model.NotificationType.error:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  IconData _getIconByType(notif_model.NotificationType tipo) {
    switch (tipo) {
      case notif_model.NotificationType.success:
        return Icons.check_circle;
      case notif_model.NotificationType.warning:
        return Icons.warning;
      case notif_model.NotificationType.error:
        return Icons.error;
      default:
        return Icons.info;
    }
  }

  String _formatearFecha(DateTime fecha) {
    // Minimal, stable relative date for starter.
    final ahora = DateTime.now();
    final diff = ahora.difference(fecha);
    if (diff.inDays >= 1) return '${diff.inDays}d';
    if (diff.inHours >= 1) return '${diff.inHours}h';
    if (diff.inMinutes >= 1) return '${diff.inMinutes}m';
    return 'now';
  }

  @override
  Widget build(BuildContext context) {
    /// Retorna una tarjeta de notificación con:
    /// - Color dinámico según tipo
    /// - Icono izquierdo
    /// - Contenido derecho (título, mensaje, fecha)
    /// 
    /// Estructura:
    /// - Container: Fondo semi-transparente
    /// - Row: Distribuye icono (izq) y contenido (der)
    /// - Column: Organiza título, mensaje, fecha verticalmente
    /// 
    /// Comportamiento:
    /// - Mensaje limitado a 2 líneas con ellipsis
    /// - Espaciado consistente entre elementos
    final color = _getColorByType(notification.type);
    final icon = _getIconByType(notification.type);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(notification.message, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(_formatearFecha(notification.createdAt), style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
