# Estructura de Proyecto Flutter - Escalable

## 📁 Estructura de Carpetas

```
lib/
├── main.dart                 # Punto de entrada de la aplicación
├── models/                   # Modelos de datos
│   ├── user_model.dart
│   ├── notification_model.dart
│   ├── login_request.dart
│   ├── auth_response.dart
│   └── models.dart          # Archivo índice (barrel file)
├── services/                 # Servicios (APIs, lógica de negocio)
│   ├── auth_service.dart    # Autenticación
│   ├── user_service.dart    # Datos de usuario
│   ├── notification_service.dart # Notificaciones
│   └── services.dart        # Archivo índice
├── screens/                  # Pantallas/Pages
│   ├── login_screen.dart
│   ├── dashboard_screen.dart
│   └── screens.dart         # Archivo índice
├── widgets/                  # Widgets reutilizables
│   ├── primary_button.dart
│   ├── custom_text_field.dart
│   ├── action_button.dart
│   ├── statistic_card.dart
│   ├── notification_card.dart
│   └── widgets.dart         # Archivo índice
├── constants/               # Constantes de la aplicación
│   └── app_constants.dart
└── utils/                   # Utilidades y helpers
    ├── validators.dart      # Validadores
    └── formatters.dart      # Formateadores
```

## 🔑 Principios de Escalabilidad

### 1. **Separación de Responsabilidades**
- **Models**: Solo contienen la estructura de datos
- **Services**: Contienen la lógica de negocio y llamadas a APIs
- **Screens**: Solo manejan UI y estado de la pantalla
- **Widgets**: Componentes reutilizables sin lógica compleja

### 2. **Patrones de Diseño**

#### **Pattern: Service Locator** (Future improvement)
```dart
// Próximo paso: implementar GetIt o similar
final getIt = GetIt.instance;
getIt.registerSingleton<AuthService>(AuthService());
```

#### **Pattern: Repository** (Para APIs)
```dart
// Cada servicio actúa como repositorio de sus datos
abstract class IUserRepository {
  Future<User> getUser(String id);
  Future<void> updateUser(User user);
}
```

### 3. **Cómo Agregar tus Propias APIs**

#### Paso 1: Crear el Modelo
```dart
// lib/models/tu_modelo.dart
class TuModelo {
  final String id;
  final String nombre;
  
  TuModelo({required this.id, required this.nombre});
  
  factory TuModelo.fromJson(Map<String, dynamic> json) {
    return TuModelo(
      id: json['id'],
      nombre: json['nombre'],
    );
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
  };
}
```

#### Paso 2: Crear el Servicio
```dart
// lib/services/tu_servicio.dart
import '../models/models.dart';

abstract class ITuServicio {
  Future<TuModelo> obtenerDatos(String id);
  Future<void> guardarDatos(TuModelo data);
}

class TuServicio implements ITuServicio {
  static const String _baseUrl = 'https://tu-api.com/api';
  
  @override
  Future<TuModelo> obtenerDatos(String id) async {
    try {
      // Reemplaza esto con tu API real
      // final response = await http.get(
      //   Uri.parse('$_baseUrl/tu-endpoint/$id'),
      // );
      // return TuModelo.fromJson(jsonDecode(response.body));
      
      // Para ahora, retorna datos simulados
      await Future.delayed(const Duration(milliseconds: 500));
      return TuModelo(id: id, nombre: 'Nombre de ejemplo');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
  
  @override
  Future<void> guardarDatos(TuModelo data) async {
    try {
      // final response = await http.post(
      //   Uri.parse('$_baseUrl/tu-endpoint'),
      //   body: data.toJson(),
      // );
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
```

#### Paso 3: Usar en la Screen
```dart
// lib/screens/tu_screen.dart
import 'package:flutter/material.dart';
import '../services/tu_servicio.dart';
import '../models/models.dart';

class TuScreen extends StatefulWidget {
  @override
  State<TuScreen> createState() => _TuScreenState();
}

class _TuScreenState extends State<TuScreen> {
  late Future<TuModelo> _datos;
  final TuServicio _servicio = TuServicio();
  
  @override
  void initState() {
    super.initState();
    _datos = _servicio.obtenerDatos('id-123');
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TuModelo>(
      future: _datos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        
        final data = snapshot.data!;
        return Scaffold(
          appBar: AppBar(title: const Text('Mi Pantalla')),
          body: Center(child: Text(data.nombre)),
        );
      },
    );
  }
}
```

## 📡 Integrando APIs Reales

### Con HTTP package
```dart
// pubspec.yaml
dependencies:
  http: ^1.1.0

// lib/services/auth_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  @override
  Future<AuthResponse> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );
    
    if (response.statusCode == 200) {
      return AuthResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error en login: ${response.body}');
    }
  }
}
```

### Con Dio package (más potente)
```dart
// pubspec.yaml
dependencies:
  dio: ^5.0.0

// lib/services/dio_service.dart
import 'package:dio/dio.dart';

class DioService {
  late Dio _dio;
  
  DioService() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://tu-api.com/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));
    
    // Interceptores para manejar errores
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Agregar token si es necesario
          // options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
        onError: (error, handler) {
          print('Error: ${error.message}');
          return handler.next(error);
        },
      ),
    );
  }
  
  Dio get dio => _dio;
}
```

## 🗂️ Convenciones de Código

1. **Nombres de archivos**: snake_case (`user_model.dart`)
2. **Nombres de clases**: PascalCase (`UserService`)
3. **Nombres privados**: _leadingUnderscore (`_userService`)
4. **Carpetas**: plural (`models/`, `services/`, `screens/`)

## 🔄 Flujo de Datos

```
1. Screen (UI)
    ↓
2. Services (Lógica + API)
    ↓
3. Models (Datos)
    ↓
4. Back (Servidor)
```

## 📝 Próximos Pasos para Mejorar

1. **Agregar Provider/Riverpod**: Para manejo de estado global
2. **Agregar GetIt**: Para inyección de dependencias
3. **Agregar Freezed**: Para generar copyWith automáticamente
4. **Agregar Hive**: Para almacenamiento local
5. **Agregar Unit Tests**: Para cada servicio
6. **Agregar Firebase**: Para autenticación y base de datos

## 📚 Recursos Útiles

- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Clean Code in Flutter](https://resocoder.com/flutter-clean-architecture)
- [Flutter Architecture Patterns](https://www.youtube.com/watch?v=C0G2duvWJ5U)
