# 📚 Ejemplos de Uso Avanzado

## 1. Manejo de Estados Complejos

```dart
// lib/models/app_state.dart
enum AuthState { initial, loading, authenticated, unauthenticated, error }

class AppState {
  final AuthState authState;
  final User? user;
  final String? error;
  
  AppState({
    this.authState = AuthState.initial,
    this.user,
    this.error,
  });
  
  AppState copyWith({
    AuthState? authState,
    User? user,
    String? error,
  }) {
    return AppState(
      authState: authState ?? this.authState,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}
```

## 2. Servicio con Caché Local

```dart
// lib/services/cached_user_service.dart
import '../models/models.dart';

class CachedUserService implements IUserService {
  final UserService _realService = UserService();
  final Map<String, User> _cache = {};
  
  @override
  Future<User> getUserProfile(String userId) async {
    // Retornar desde caché si existe
    if (_cache.containsKey(userId)) {
      return _cache[userId]!;
    }
    
    // Si no, obtener del servicio real
    final user = await _realService.getUserProfile(userId);
    _cache[userId] = user;
    return user;
  }
  
  // Limpiar caché
  void clearCache() => _cache.clear();
  
  // ... resto de métodos
}
```

## 3. Servicio con Reintentos Automáticos

```dart
// lib/services/resilient_auth_service.dart
class ResilientAuthService extends AuthService {
  static const int maxRetries = 3;
  
  Future<T> _retryRequest<T>(Future<T> Function() request) async {
    int attempts = 0;
    
    while (attempts < maxRetries) {
      try {
        return await request();
      } catch (e) {
        attempts++;
        if (attempts >= maxRetries) {
          rethrow;
        }
        // Esperar antes de reintentar (exponential backoff)
        await Future.delayed(Duration(seconds: 2 ^ attempts));
      }
    }
    
    throw Exception('Max retries exceeded');
  }
  
  @override
  Future<AuthResponse> login(String username, String password) {
    return _retryRequest(() => super.login(username, password));
  }
}
```

## 4. Servicio con Autenticación JWT

```dart
// lib/services/secure_auth_service.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureAuthService extends AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  final storage = const FlutterSecureStorage();
  
  @override
  Future<AuthResponse> login(String username, String password) async {
    final response = await super.login(username, password);
    
    // Guardar tokens de forma segura
    await storage.write(key: _tokenKey, value: response.token);
    await storage.write(key: _refreshTokenKey, value: response.refreshToken);
    
    return response;
  }
  
  Future<String?> getToken() async {
    return await storage.read(key: _tokenKey);
  }
  
  @override
  Future<void> logout() async {
    await super.logout();
    await storage.delete(key: _tokenKey);
    await storage.delete(key: _refreshTokenKey);
  }
}
```

## 5. Validadores Reutilizables

```dart
// lib/utils/validators.dart
class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El email es requerido';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Ingresa un email válido';
    }
    return null;
  }
  
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }
    if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Debe contener al menos una mayúscula';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Debe contener al menos un número';
    }
    return null;
  }
  
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'El usuario es requerido';
    }
    if (value.length < 3) {
      return 'El usuario debe tener al menos 3 caracteres';
    }
    if (!RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(value)) {
      return 'Solo se permiten letras, números, guiones y guiones bajos';
    }
    return null;
  }
}
```

## 6. Widget Form Reutilizable

```dart
// lib/widgets/custom_form_field.dart
class CustomFormField extends StatefulWidget {
  final String label;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final IconData? icon;
  
  const CustomFormField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.icon,
  });
  
  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  late bool _obscureText;
  
  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
```

## 7. Manejo de Paginación

```dart
// lib/services/paginated_service.dart
class PaginatedResponse<T> {
  final List<T> items;
  final int page;
  final int pageSize;
  final int total;
  
  PaginatedResponse({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.total,
  });
  
  int get totalPages => (total / pageSize).ceil();
  bool get hasNextPage => page < totalPages;
  
  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return PaginatedResponse(
      items: (json['items'] as List)
          .map((item) => fromJson(item))
          .toList(),
      page: json['page'],
      pageSize: json['pageSize'],
      total: json['total'],
    );
  }
}

class PaginatedListScreen extends StatefulWidget {
  @override
  State<PaginatedListScreen> createState() => _PaginatedListScreenState();
}

class _PaginatedListScreenState extends State<PaginatedListScreen> {
  int _currentPage = 1;
  final List<MiModelo> _allItems = [];
  bool _isLoading = false;
  
  Future<void> _loadMore() async {
    if (_isLoading) return;
    
    setState(() => _isLoading = true);
    
    try {
      final response = await MiServicio().listarPaginado(_currentPage);
      setState(() {
        _allItems.addAll(response.items);
        _currentPage++;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
  
  @override
  void initState() {
    super.initState();
    _loadMore();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista Paginada')),
      body: ListView.builder(
        itemCount: _allItems.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _allItems.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            );
          }
          
          return ListTile(
            title: Text(_allItems[index].id),
            onTap: () {
              // Navegar a detalles
            },
          );
        },
      ),
    );
  }
}
```

## 8. Filtrado y Búsqueda

```dart
// lib/widgets/searchable_list.dart
class SearchableList extends StatefulWidget {
  final List<MiModelo> items;
  final Widget Function(BuildContext, MiModelo) itemBuilder;
  
  const SearchableList({
    required this.items,
    required this.itemBuilder,
  });
  
  @override
  State<SearchableList> createState() => _SearchableListState();
}

class _SearchableListState extends State<SearchableList> {
  final TextEditingController _searchController = TextEditingController();
  late List<MiModelo> _filteredItems;
  
  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _searchController.addListener(_filterItems);
  }
  
  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = widget.items
          .where((item) => item.id.toLowerCase().contains(query))
          .toList();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredItems.length,
            itemBuilder: (context, index) {
              return widget.itemBuilder(context, _filteredItems[index]);
            },
          ),
        ),
      ],
    );
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
```

## Próximos Pasos

1. **Agregar Provider**: Para estado global
2. **Agregar Freezed**: Para generar modelos
3. **Agregar Tests**: Para cada servicio
4. **Agregar Logger**: Para debugging
5. **Agregar Analytics**: Para tracking

¡Tu proyecto ahora está listo para crecer! 🚀
