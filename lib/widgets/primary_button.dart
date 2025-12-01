import 'package:flutter/material.dart';

/// Botón primario reutilizable
/// 
/// Widget personalizado que proporciona un botón ElevatedButton
/// con estilo consistente en toda la aplicación.
/// 
/// Características:
/// - Fondo blanco con texto azul
/// - Soporte para estado de carga con CircularProgressIndicator
/// - Tamaño personalizable (ancho y alto)
/// - Opción de ancho completo o ajustado
/// 
/// Uso:
/// ```dart
/// PrimaryButton(
///   label: 'Ingresar',
///   onPressed: () { /* acción */ },
///   isLoading: false,
/// )
/// ```
/// 
/// TODO: Agregar variaciones:
/// - Diferentes estilos (primary, secondary, danger)
/// - Iconos opcionales
/// - Loading label personalizado
class PrimaryButton extends StatelessWidget {
  /// Texto que se muestra en el botón
  final String label;
  
  /// Callback que se ejecuta cuando se presiona el botón
  final VoidCallback onPressed;
  
  /// Si es true, muestra indicador de carga y desactiva el botón
  final bool isLoading;
  
  /// Altura del botón en píxeles
  final double height;
  
  /// Si es true, el botón ocupa el ancho disponible
  final bool isFullWidth;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.height = 48,
    this.isFullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    /// Retorna un SizedBox con ElevatedButton dentro
    /// 
    /// Lógica:
    /// 1. SizedBox define ancho (completo o null) y alto (48 por defecto)
    /// 2. ElevatedButton con:
    ///    - onPressed: null si isLoading=true (desactiva el botón)
    ///    - Estilos: fondo blanco, bordes redondeados, color deshabilitado gris
    /// 3. Contenido:
    ///    - Si cargando: CircularProgressIndicator
    ///    - Si no: Texto del label
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBackgroundColor: Colors.grey.shade400,
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              )
            : Text(
                label,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
              ),
      ),
    );
  }
}
