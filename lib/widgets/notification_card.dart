import 'package:flutter/material.dart';
import '../models/notification_model.dart' as notif_model;

class NotificationCard extends StatelessWidget {
  final notif_model.Notification notification;

  const NotificationCard({
    super.key,
    required this.notification,
  });

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
