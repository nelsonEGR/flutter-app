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
    // Minimal, stable implementation used for a clean starter project.
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(label),
      ),
    );
  }
}
