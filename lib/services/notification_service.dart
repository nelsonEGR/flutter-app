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
  // TODO: Reemplaza esto con tu API real
  static const String _baseUrl = 'https://tu-api.com/api';

  /// Obtiene todas las notificaciones del usuario
  /// 
  /// Parámetros:
  /// - [userId]: ID del usuario para filtrar notificaciones
  /// 
  /// Retorna:
  /// - [List<Notification>]: Lista de notificaciones ordenadas por fecha (más recientes primero)
  /// 
  /// Las notificaciones no leídas deben aparecer primero
  /// 
  /// Próximo: Integrar con tu API de notificaciones
  @override
  Future<List<Notification>> getNotifications(String userId) async {
    try {
      // TODO: Llamar a tu API real:
      // final response = await http.get(
      //   Uri.parse('$_baseUrl/notifications?userId=$userId'),
      //   headers: {'Authorization': 'Bearer $token'},
      // );
      // 
      // if (response.statusCode == 200) {
      //   final List jsonList = jsonDecode(response.body);
      //   return jsonList
      //       .map((json) => Notification.fromJson(json))
      //       .toList();
      // } else {
      //   throw Exception('Error ${response.statusCode}');
      // }

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

  /// Marca una notificación como leída
  /// 
  /// Parámetros:
  /// - [notificationId]: ID de la notificación a marcar
  /// 
  /// Actualiza en el servidor que la notificación fue vista
  /// 
  /// Próximo: Enviar a tu API de notificaciones
  @override
  Future<void> markAsRead(String notificationId) async {
    try {
      // TODO: Llamar a tu API real:
      // final response = await http.patch(
      //   Uri.parse('$_baseUrl/notifications/$notificationId'),
      //   headers: {
      //     'Authorization': 'Bearer $token',
      //     'Content-Type': 'application/json',
      //   },
      //   body: jsonEncode({'isRead': true}),
      // );
      // 
      // if (response.statusCode != 200) {
      //   throw Exception('Error: ${response.body}');
      // }

      await Future.delayed(const Duration(milliseconds: 300));
    } catch (e) {
      throw Exception('Error marcando notificación como leída: $e');
    }
  }

  /// Elimina una notificación
  /// 
  /// Parámetros:
  /// - [notificationId]: ID de la notificación a eliminar
  /// 
  /// NOTA: Esto no se puede deshacer
  /// 
  /// Próximo: Implementar soft delete en servidor
  @override
  Future<void> deleteNotification(String notificationId) async {
    try {
      // TODO: Llamar a tu API real:
      // final response = await http.delete(
      //   Uri.parse('$_baseUrl/notifications/$notificationId'),
      //   headers: {'Authorization': 'Bearer $token'},
      // );
      // 
      // if (response.statusCode != 200) {
      //   throw Exception('Error: ${response.body}');
      // }

      await Future.delayed(const Duration(milliseconds: 300));
    } catch (e) {
      throw Exception('Error eliminando notificación: $e');
    }
  }
}
