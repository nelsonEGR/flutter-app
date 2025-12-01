# 🚀 Guía Rápida: Integrar tus APIs

## Paso a Paso para Conectar tu API

### 1. Actualizar AppConstants
```dart
// lib/constants/app_constants.dart
class AppConstants {
  static const String apiBaseUrl = 'https://tu-api-real.com/api';
  // ... resto de constantes
}
```

### 2. Crear un modelo para tu endpoint
```dart
// lib/models/mi_modelo.dart
class MiModelo {
  final String id;
  final String datos;
  
  MiModelo({required this.id, required this.datos});
  
  factory MiModelo.fromJson(Map<String, dynamic> json) {
    return MiModelo(
      id: json['id'],
      datos: json['datos'],
    );
  }
  
  Map<String, dynamic> toJson() => {'id': id, 'datos': datos};
}
```

### 3. Crear un servicio para esa API
```dart
// lib/services/mi_servicio.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';
import '../models/models.dart';

abstract class IMiServicio {
  Future<MiModelo> obtener(String id);
  Future<List<MiModelo>> listar();
  Future<void> crear(MiModelo modelo);
  Future<void> actualizar(MiModelo modelo);
  Future<void> eliminar(String id);
}

class MiServicio implements IMiServicio {
  static const String _endpoint = '${AppConstants.apiBaseUrl}/mi-endpoint';

  @override
  Future<MiModelo> obtener(String id) async {
    try {
      final response = await http.get(Uri.parse('$_endpoint/$id')).timeout(
        AppConstants.apiTimeout,
        onTimeout: () => throw Exception('Tiempo de espera agotado'),
      );
      
      if (response.statusCode == 200) {
        return MiModelo.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error obteniendo datos: $e');
    }
  }

  @override
  Future<List<MiModelo>> listar() async {
    try {
      final response = await http.get(Uri.parse(_endpoint)).timeout(
        AppConstants.apiTimeout,
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => MiModelo.fromJson(json)).toList();
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error listando datos: $e');
    }
  }

  @override
  Future<void> crear(MiModelo modelo) async {
    try {
      final response = await http.post(
        Uri.parse(_endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(modelo.toJson()),
      ).timeout(AppConstants.apiTimeout);
      
      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception('Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error creando: $e');
    }
  }

  @override
  Future<void> actualizar(MiModelo modelo) async {
    try {
      final response = await http.put(
        Uri.parse('$_endpoint/${modelo.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(modelo.toJson()),
      ).timeout(AppConstants.apiTimeout);
      
      if (response.statusCode != 200) {
        throw Exception('Error ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error actualizando: $e');
    }
  }

  @override
  Future<void> eliminar(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$_endpoint/$id'),
      ).timeout(AppConstants.apiTimeout);
      
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Error ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error eliminando: $e');
    }
  }
}
```

### 4. Usar en una Screen
```dart
// lib/screens/mi_screen.dart
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/mi_servicio.dart';

class MiScreen extends StatefulWidget {
  @override
  State<MiScreen> createState() => _MiScreenState();
}

class _MiScreenState extends State<MiScreen> {
  late Future<List<MiModelo>> _datos;
  final MiServicio _servicio = MiServicio();

  @override
  void initState() {
    super.initState();
    _datos = _servicio.listar();
  }

  void _refrescar() {
    setState(() {
      _datos = _servicio.listar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi Pantalla')),
      body: FutureBuilder<List<MiModelo>>(
        future: _datos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _refrescar,
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          final lista = snapshot.data ?? [];

          return RefreshIndicator(
            onRefresh: () async => _refrescar(),
            child: ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, index) {
                final item = lista[index];
                return ListTile(
                  title: Text(item.id),
                  subtitle: Text(item.datos),
                  onTap: () {
                    // Navegar a detalles
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
```

## ✅ Checklist de Integración

- [ ] He actualizado `AppConstants` con mi URL de API
- [ ] He creado el modelo en `lib/models/`
- [ ] He creado el servicio en `lib/services/`
- [ ] He añadido el servicio al archivo `services.dart`
- [ ] He creado la screen que usa el servicio
- [ ] He probado con `flutter run`
- [ ] Los datos se cargan correctamente

## 🐛 Debugging

### Ver logs de HTTP
```dart
// Agrega esto en tu servicio
print('URL: $_endpoint');
print('Response: ${response.statusCode}');
print('Body: ${response.body}');
```

### Comprobar JSON
```dart
// Asegúrate de que tu API retorna el formato correcto
// Prueba en Postman primero!
```

### Errores comunes
- **CORS**: Asegúrate que tu backend permite peticiones desde Flutter
- **JSON malformado**: Valida con JSONLint.com
- **Certificados SSL**: En desarrollo, puedes permitir certificados auto-firmados
- **Timeouts**: Aumenta el timeout en AppConstants si es lenta tu API

## 💡 Tips Pro

1. **Usa Postman**: Prueba tus endpoints primero
2. **Crea DTOs**: Usa modelos para request y response
3. **Maneja errores**: Siempre usa try-catch
4. **Carga simulada**: Mantén `Future.delayed()` en desarrollo
5. **Tokens JWT**: Agrégalos en los headers si tu API lo requiere

```dart
// Ejemplo con token
final response = await http.get(
  Uri.parse(_endpoint),
  headers: {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  },
);
```
