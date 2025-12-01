// Constantes de la aplicación
class AppConstants {
  // URLs base para tus APIs
  static const String apiBaseUrl = 'https://tu-api.com/api';
  
  // Endpoints
  static const String loginEndpoint = '$apiBaseUrl/auth/login';
  static const String logoutEndpoint = '$apiBaseUrl/auth/logout';
  static const String userProfileEndpoint = '$apiBaseUrl/users';
  static const String notificationsEndpoint = '$apiBaseUrl/notifications';
  
  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  
  // Mensajes
  static const String errorGeneral = 'Ha ocurrido un error. Intenta nuevamente.';
  static const String errorNoInternet = 'No hay conexión a internet.';
}
