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

  /// Obtiene el color de la notificación según su tipo
  /// 
  /// Mapeo:
  /// - success → Verde
  /// - warning → Naranja
  /// - error → Rojo
  /// - info → Azul (default)
  Color _getColorByType(notif_model.NotificationType tipo) {
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

  /// Obtiene el icono de la notificación según su tipo
  /// 
  /// Mapeo:
  /// - success → check_circle
  /// - warning → warning
  /// - error → error
  /// - info → info (default)
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

  /// Convierte una fecha a formato relativo legible
  /// 
  /// Ejemplos:
  /// - Hace unos momentos (< 1 minuto)
  /// - Hace 5 minutos
  /// - Hace 2 horas
  /// - Ayer
  /// - Hace 3 días
  String _formatearFecha(DateTime fecha) {
    final ahora = DateTime.now();
    final diferencia = ahora.difference(fecha);

    if (diferencia.inMinutes < 1) {
      return 'Hace unos momentos';
    } else if (diferencia.inHours < 1) {
      return 'Hace ${diferencia.inMinutes} minutos';
    } else if (diferencia.inDays < 1) {
      return 'Hace ${diferencia.inHours} horas';
    } else if (diferencia.inDays == 1) {
      return 'Ayer';
    } else {
      return 'Hace ${diferencia.inDays} días';
    }
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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notification.message,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  _formatearFecha(notification.createdAt),
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
