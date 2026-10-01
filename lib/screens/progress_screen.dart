import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../main.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final total = mockResources.length;
    final completedCount = appState.completedIds.length;
    final percentage = total == 0 ? 0.0 : completedCount / total;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tu Progreso', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 24),

            // Barra de progreso principal
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Avance general', style: TextStyle(color: Colors.grey, fontSize: 13)),
                      Text('${(percentage * 100).toStringAsFixed(0)}%', style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: percentage,
                      minHeight: 8,
                      backgroundColor: Colors.white10,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('$completedCount de $total completados', style: const TextStyle(color: Colors.grey, fontSize: 11)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text('Eventos de ciclo de vida (Historial)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: appState.lifecycleEvents.isEmpty
                    ? [const Text('No hay eventos aún', style: TextStyle(color: Colors.grey))]
                    : appState.lifecycleEvents.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text('• $e', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}