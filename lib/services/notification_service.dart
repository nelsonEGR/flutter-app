import '../models/models.dart';

/// Servicio de Notificaciones
/// Aquí obtienes las notificaciones desde tu API
abstract class INotificationService {
  Future<List<Notification>> getNotifications(String userId);
  Future<void> markAsRead(String notificationId);
  Future<void> deleteNotification(String notificationId);
}

class NotificationService implements INotificationService {
  // TODO: Reemplaza esto con tu API real
  static const String _baseUrl = 'https://tu-api.com/api';

  @override
  Future<List<Notification>> getNotifications(String userId) async {
    try {
      // TODO: Llamar a tu API real
      // final response = await http.get(
      //   Uri.parse('$_baseUrl/notifications?userId=$userId'),
      // );

      // Simulación de respuesta
      await Future.delayed(const Duration(milliseconds: 500));

      return [
        Notification(
          id: '1',
          title: 'Bienvenida',
          message: 'Hola, es un placer verte aquí.',
          createdAt: DateTime.now(),
          type: NotificationType.info,
        ),
        Notification(
          id: '2',
          title: 'Cambio de contraseña',
          message: 'Tu contraseña fue actualizada hace 2 días.',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          type: NotificationType.success,
        ),
        Notification(
          id: '3',
          title: 'Nuevo acceso',
          message: 'Acceso desde Windows - 01/12/2025 10:30 AM',
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          type: NotificationType.info,
        ),
        Notification(
          id: '4',
          title: 'Alerta de seguridad',
          message: 'Se detectó un acceso desde una ubicación desconocida.',
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
          type: NotificationType.warning,
        ),
      ];
    } catch (e) {
      throw Exception('Error obteniendo notificaciones: $e');
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    try {
      // TODO: Llamar a tu API real
      // final response = await http.patch(
      //   Uri.parse('$_baseUrl/notifications/$notificationId'),
      //   body: {'isRead': true},
      // );

      await Future.delayed(const Duration(milliseconds: 300));
    } catch (e) {
      throw Exception('Error marcando notificación como leída: $e');
    }
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    try {
      // TODO: Llamar a tu API real
      // final response = await http.delete(
      //   Uri.parse('$_baseUrl/notifications/$notificationId'),
      // );

      await Future.delayed(const Duration(milliseconds: 300));
    } catch (e) {
      throw Exception('Error eliminando notificación: $e');
    }
  }
}
