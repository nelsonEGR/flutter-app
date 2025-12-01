````markdown
# 🔧 Guía Práctica: Cómo Escalar Tu Proyecto

**Demostraciones paso a paso de cómo agregar nuevas features manteniendo escalabilidad**

---

## 📚 Índice

1. [Agregar Nuevo Modelo](#agregar-nuevo-modelo)
2. [Agregar Nuevo Servicio](#agregar-nuevo-servicio)
3. [Agregar Nueva Pantalla](#agregar-nueva-pantalla)
4. [Agregar Nuevo Widget](#agregar-nuevo-widget)
5. [Cambiar Implementación de Servicio](#cambiar-implementación)
6. [Agregar State Management](#agregar-state-management)
7. [Optimizar para Performance](#optimizar-performance)

---

## 1. Agregar Nuevo Modelo

### Ejemplo: Modelo de Producto

**Paso 1: Crear archivo `lib/models/product_model.dart`**

```dart
/// Modelo que representa un producto en el catálogo
/// 
/// Este modelo maneja la serialización y deserialización de productos
/// desde la API REST.
/// 
/// Ejemplo:
/// ```dart
/// final product = Product.fromJson(apiResponse);
/// final json = product.toJson();
/// final updated = product.copyWith(price: 99.99);
/// ```
class Product {
  /// Identificador único del producto
  final String id;
  
  /// Nombre del producto
  final String name;
  
  /// Descripción detallada del producto
  final String description;
  
  /// Precio en dólares
  final double price;
  
  /// URL de la imagen del producto
  final String imageUrl;
  
  /// Cantidad disponible en inventario
  final int stock;

  /// Constructor principal del modelo
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.stock,
  });

  /// Deserializa JSON desde la API
  /// 
  /// Convierte la respuesta de la API en objeto Dart
  /// 
  /// Ejemplo JSON:
  /// ```json
  /// {
  ///   "id": "prod_123",
  ///   "name": "Producto",
  ///   "description": "Descripción",
  ///   "price": 99.99,
  ///   "imageUrl": "https://...",
  ///   "stock": 50
  /// }
  /// ```
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      stock: json['stock'] as int,
    );
  }

  /// Serializa el modelo a JSON
  /// 
  /// Convierte el objeto Dart en JSON para enviar a la API
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
    'imageUrl': imageUrl,
    'stock': stock,
  };

  /// Crea una copia con cambios específicos
  /// 
  /// Útil para inmutabilidad. Permite cambiar campos sin crear
  /// un nuevo objeto desde cero.
  /// 
  /// Ejemplo:
  /// ```dart
  /// final newProduct = product.copyWith(price: 99.99);
  /// ```
  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    int? stock,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      stock: stock ?? this.stock,
    );
  }

  @override
  String toString() => 'Product(id: \$id, name: \$name, price: \$price)';
}
```

**Paso 2: Actualizar `lib/models/models.dart` (Barrel File)**

```dart
export 'user_model.dart';
export 'notification_model.dart';
export 'auth_response.dart';
export 'login_request.dart';
export 'product_model.dart';  // ← AGREGAR ESTA LÍNEA
```

**✅ Listo.** El modelo está disponible en toda la app:
```dart
import '../models/models.dart';

// Ahora puedes usar
final product = Product(
  id: '123',
  name: 'iPhone',
  description: 'Smartphone',
  price: 999.99,
  imageUrl: 'https://...',
  stock: 50,
);
```

---

## 2. Agregar Nuevo Servicio

### Ejemplo: Servicio de Productos

**Paso 1: Crear interfaz `lib/services/product_service.dart`**

```dart
import '../models/models.dart';

/// Interfaz que define el contrato para operaciones de productos
/// 
/// Esta interfaz permite:
/// - Cambiar la implementación sin afectar el código que la usa
/// - Mockear para tests sin necesidad de API real
/// - Múltiples implementaciones (API, caché, etc.)
abstract class IProductService {
  /// Obtiene lista de todos los productos
  /// 
  /// Retorna una lista paginada de productos disponibles
  /// 
  /// Lanza [Exception] si hay error en la conexión
  Future<List<Product>> getProducts();

  /// Obtiene un producto específico por ID
  /// 
  /// Parámetros:
  ///   - [id]: Identificador único del producto
  /// 
  /// Retorna el producto o null si no existe
  Future<Product?> getProductById(String id);

  /// Busca productos por término
  /// 
  /// Parámetros:
  ///   - [query]: Término de búsqueda
  /// 
  /// Retorna lista de productos coincidentes
  Future<List<Product>> searchProducts(String query);

  /// Crea un nuevo producto (solo admin)
  Future<Product> createProduct(Product product);

  /// Actualiza un producto existente
  Future<Product> updateProduct(Product product);

  /// Elimina un producto
  Future<void> deleteProduct(String id);
}

/// Implementación de ProductService usando API REST
/// 
/// IMPORTANTE: Esta es una implementación simulada.
/// Para usar con API real:
/// 1. Agregar `http` o `dio` a pubspec.yaml
/// 2. Reemplazar `Future.delayed` con llamadas HTTP
/// 3. Manejar errores de conexión
/// 
/// Ejemplo con http:
/// ```dart
/// final response = await http.get(
///   Uri.parse('\${AppConstants.baseUrl}/products'),
/// );
/// if (response.statusCode == 200) {
///   return jsonDecode(response.body);
/// }
/// ```
class ProductService implements IProductService {
  /// URL base para las llamadas a la API
  /// TODO: Reemplazar con llamadas HTTP reales
  static const String _baseUrl = '${AppConstants.baseUrl}/products';

  @override
  Future<List<Product>> getProducts() async {
    // TODO: Cambiar por: return http.get(_baseUrl)
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      Product(
        id: 'prod_1',
        name: 'iPhone 15',
        description: 'Smartphone de última generación',
        price: 999.99,
        imageUrl: 'https://example.com/iphone15.jpg',
        stock: 50,
      ),
      Product(
        id: 'prod_2',
        name: 'iPad Pro',
        description: 'Tablet profesional',
        price: 1299.99,
        imageUrl: 'https://example.com/ipadpro.jpg',
        stock: 30,
      ),
    ];
  }

  @override
  Future<Product?> getProductById(String id) async {
    // TODO: Cambiar por: return http.get('$_baseUrl/$id')
    await Future.delayed(const Duration(milliseconds: 500));
    return Product(
      id: id,
      name: 'Producto $id',
      description: 'Descripción del producto',
      price: 99.99,
      imageUrl: 'https://example.com/product.jpg',
      stock: 25,
    );
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    // TODO: Cambiar por: return http.get('$_baseUrl?search=$query')
    await Future.delayed(const Duration(milliseconds: 600));
    return [];
  }

  @override
  Future<Product> createProduct(Product product) async {
    // TODO: Cambiar por: return http.post(_baseUrl, body: product.toJson())
    await Future.delayed(const Duration(milliseconds: 500));
    return product;
  }

  @override
  Future<Product> updateProduct(Product product) async {
    // TODO: Cambiar por: return http.put('$_baseUrl/${product.id}')
    await Future.delayed(const Duration(milliseconds: 500));
    return product;
  }

  @override
  Future<void> deleteProduct(String id) async {
    // TODO: Cambiar por: return http.delete('$_baseUrl/$id')
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
````