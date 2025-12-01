import 'package:flutter/material.dart';

/// Minimal dashboard placeholder to preserve file and architecture.
///
/// Replace with real dashboard UI and logic when starting feature
/// development. Keep this file as the entry point for authenticated
/// flows.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard (placeholder)')),
      body: const Center(
        child: Text('Pantalla de Dashboard vacía. Implementa tu UI aquí.'),
      ),
    );
  }
}
