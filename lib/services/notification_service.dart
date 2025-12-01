import '../models/models.dart';

/// Servicio de Notificaciones
/// 
/// Maneja el sistema completo de notificaciones:
/// - Obtener historial de notificaciones
/// - Marcar notificaciones como leídas
/// - Eliminar notificaciones
/// - Suscribirse a notificaciones push
/// 
/// Se integra con Firebase Cloud Messaging o similar para push notifications.
/// 
/// Flujo:
/// 1. [getNotifications] obtiene la lista actual
/// 2. [markAsRead] marca como leída
/// 3. [deleteNotification] elimina
abstract class INotificationService {
  Future<List<Notification>> getNotifications(String userId);
  Future<void> markAsRead(String notificationId);
  Future<void> deleteNotification(String notificationId);
}
class NotificationService implements INotificationService {
  /// Stub implementation for notification service.
  ///
  /// Methods intentionally throw [UnimplementedError] to indicate where
  /// the real integration with a backend (e.g., FCM or REST API) should go.

  @override
  Future<List<Notification>> getNotifications(String userId) async {
    // TODO: Implement real API call
    throw UnimplementedError('NotificationService.getNotifications no implementado.');
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    // TODO: Implement real API call
    throw UnimplementedError('NotificationService.markAsRead no implementado.');
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    // TODO: Implement real API call
    throw UnimplementedError('NotificationService.deleteNotification no implementado.');
  }
}
