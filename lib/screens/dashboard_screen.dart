import 'package:flutter/material.dart';
import '../models/notification_model.dart' as notif_model;
import '../models/user_model.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';
import 'login_screen.dart';

/// Pantalla del Dashboard
/// 
/// Esta es la pantalla principal que ve el usuario después de iniciar sesión.
/// Muestra:
/// - Bienvenida personalizada con nombre del usuario
/// - Acciones rápidas (editar perfil, cambiar contraseña, cerrar sesión)
/// - Estadísticas (login count, notificaciones, perfil)
/// - Historial de notificaciones recientes
/// 
/// Parámetros:
/// - [usuario]: ID del usuario para cargar datos
/// 
/// TODO: Mejoras futuras:
/// - Agregar refresh button
/// - Implementar pagination en notificaciones
/// - Agregar modo oscuro
class DashboardScreen extends StatefulWidget {
  /// ID del usuario para identificar qué datos mostrar
  final String usuario;

  const DashboardScreen({super.key, required this.usuario});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  /// Future que carga los datos del usuario
  /// Se ejecuta una sola vez en initState
  late Future<User> _userFuture;
  
  /// Future que carga las notificaciones del usuario
  late Future<List<notif_model.Notification>> _notificationsFuture;
  
  /// Instancias de los servicios para obtener datos
  final UserService _userService = UserService();
  final NotificationService _notificationService = NotificationService();
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    // Cargar datos del usuario y notificaciones al iniciar
    _userFuture = _userService.getUserProfile(widget.usuario);
    _notificationsFuture = _notificationService.getNotifications(widget.usuario);
  }

  /// Muestra diálogo de confirmación y cierra sesión
  /// 
  /// Este método:
  /// 1. Muestra AlertDialog pidiendo confirmación
  /// 2. Si confirma, llama a [AuthService.logout]
  /// 3. Navega a [LoginScreen] eliminando todo el historial
  /// 
  /// TODO: Integrar con persistencia:
  /// - Limpiar token de SharedPreferences
  /// - Limpiar datos cacheados
  /// - Cerrar WebSocket connections
  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              await _authService.logout();
              if (mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }

  /// Muestra diálogo para cambiar contraseña
  /// 
  /// TODO: Implementar:
  /// - Form con TextFields para contraseña actual y nueva
  /// - Validación de requisitos de contraseña
  /// - Confirmación de contraseña
  /// - Botón de guardar que llame a [UserService.changePassword]
  void _changePassword() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cambiar contraseña'),
        content: const Text('Funcionalidad para cambiar contraseña aquí'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  /// Muestra diálogo para editar perfil
  /// 
  /// TODO: Implementar:
  /// - Form con TextFields para username y email
  /// - Validación de campos
  /// - Botón de guardar que llame a [UserService.updateProfile]
  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar perfil'),
        content: const Text('Funcionalidad para editar perfil aquí'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User>(
        future: _userFuture,
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userSnapshot.hasError) {
            return Center(child: Text('Error: ${userSnapshot.error}'));
          }

          final user = userSnapshot.data!;

          return CustomScrollView(
            slivers: [
              _buildAppBar(user),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildQuickActions(),
                      const SizedBox(height: 24),
                      _buildStatistics(user),
                      const SizedBox(height: 24),
                      _buildNotifications(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Construye la AppBar personalizado con información del usuario
  /// 
  /// Características:
  /// - SliverAppBar expandible con gradiente azul de fondo
  /// - Avatar circular con primera letra del nombre del usuario
  /// - Nombre y mensaje de bienvenida personalizados
  /// - Se fija al scroll (pinned: true)
  SliverAppBar _buildAppBar(User user) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade800,
                Colors.blue.shade400,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Text(
                    user.username[0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Bienvenido, ${user.username}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Tu espacio personal y seguro',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Construye las acciones rápidas en una GridView
  /// 
  /// Muestra 3 botones en una cuadrícula:
  /// - Editar Perfil: Abre diálogo para editar datos
  /// - Cambiar Contraseña: Abre diálogo para cambiar contraseña
  /// - Cerrar Sesión: Abre diálogo de confirmación y cierra sesión (en rojo)
  /// 
  /// Usa el widget reutilizable [ActionButton]
  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Acciones Rápidas',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: [
            ActionButton(
              icon: Icons.person_outline,
              label: 'Editar Perfil',
              onTap: _editProfile,
            ),
            ActionButton(
              icon: Icons.lock_outline,
              label: 'Cambiar Contraseña',
              onTap: _changePassword,
            ),
            ActionButton(
              icon: Icons.logout,
              label: 'Cerrar Sesión',
              onTap: _logout,
              color: Colors.red,
            ),
          ],
        ),
      ],
    );
  }

  /// Construye las estadísticas del usuario en una fila
  /// 
  /// Muestra 3 tarjetas:
  /// - Inicios de Sesión: Contador [user.loginCount]
  /// - Notificaciones: Cantidad de notificaciones obtenidas del futuro
  /// - Perfil: Complitud del perfil (100%)
  /// 
  /// Usa el widget reutilizable [StatisticCard]
  /// La tarjeta de notificaciones carga el dato de forma asincrónica
  Widget _buildStatistics(User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Estadísticas',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StatisticCard(
                title: 'Inicios de Sesión',
                value: user.loginCount.toString(),
                icon: Icons.login,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FutureBuilder<List<notif_model.Notification>>(
                future: _notificationsFuture,
                builder: (context, snapshot) {
                  final count = snapshot.data?.length ?? 0;
                  return StatisticCard(
                    title: 'Notificaciones',
                    value: count.toString(),
                    icon: Icons.notifications,
                    color: Colors.orange,
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatisticCard(
                title: 'Perfil',
                value: '100%',
                icon: Icons.check_circle,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Construye la lista de notificaciones recientes
  /// 
  /// Características:
  /// - Título "Notificaciones Recientes" con link "Ver todo"
  /// - Usa FutureBuilder para cargar notificaciones de forma asincrónica
  /// - Muestra indicador de carga mientras carga
  /// - ListView.builder para mostrar cada notificación
  /// - Usa el widget reutilizable [NotificationCard] para cada item
  /// 
  /// TODO: Agregar funcionalidad de "Ver todo" para navegar a pantalla de todas las notificaciones
  Widget _buildNotifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Notificaciones Recientes',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Ver todo',
              style: TextStyle(
                color: Colors.blue.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        FutureBuilder<List<notif_model.Notification>>(
          future: _notificationsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final notifications = snapshot.data ?? [];

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return NotificationCard(notification: notifications[index]);
              },
            );
          },
        ),
      ],
    );
  }
}
