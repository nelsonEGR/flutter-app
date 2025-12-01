enum NotificationType { info, success, warning, error }

class Notification {
  final String id;
  final String title;
  final String message;
  final DateTime createdAt;
  final NotificationType type;
  final bool isRead;

  Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.type,
    this.isRead = false,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      type: _parseNotificationType(json['type'] as String),
      isRead: json['isRead'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'createdAt': createdAt.toIso8601String(),
      'type': type.toString().split('.').last,
      'isRead': isRead,
    };
  }

  Notification copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? createdAt,
    NotificationType? type,
    bool? isRead,
  }) {
    return Notification(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
    );
  }

  static NotificationType _parseNotificationType(String value) {
    return NotificationType.values.firstWhere(
      (e) => e.toString().split('.').last == value,
      orElse: () => NotificationType.info,
    );
  }
}
