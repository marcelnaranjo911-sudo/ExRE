import 'package:flutter/material.dart';
import '../models/resource.dart';
import '../main.dart';

class DetailScreen extends StatelessWidget {
  final Resource resource;
  const DetailScreen({super.key, required this.resource});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final isFavorite = appState.favoriteIds.contains(resource.id);
    final isCompleted = appState.completedIds.contains(resource.id);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero/Header
            Container(
              height: 220,
              width: double.infinity,
              color: resource.color.withOpacity(0.2),
              child: SafeArea(
                bottom: false,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        width: 60, height: 60,
                        decoration: BoxDecoration(color: resource.color, borderRadius: BorderRadius.circular(16)),
                        child: Icon(resource.typeIcon, size: 30, color: Colors.white),
                      ),
                    ),
                    Positioned(
                      top: 10, left: 10,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Positioned(
                      top: 10, right: 10,
                      child: IconButton(
                        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: isFavorite ? Colors.pink : Colors.white),
                        onPressed: () => appState.toggleFavorite(resource.id),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(resource.categoryName.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1, color: resource.color)),
                  const SizedBox(height: 8),
                  Text(resource.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.person_outline, size: 14, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(resource.author, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: _buildMetaChip(context, Icons.timer, '${resource.durationMinutes} min')),
                      const SizedBox(width: 10),
                      Expanded(child: _buildMetaChip(context, Icons.bar_chart, resource.levelName)),
                      const SizedBox(width: 10),
                      Expanded(child: _buildMetaChip(context, resource.typeIcon, resource.typeName)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('Descripción', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 8),
                  Text(resource.description, style: const TextStyle(fontSize: 14, color: Colors.white70, height: 1.5)),
                  const SizedBox(height: 20),

                  // Enlace Simulado
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
                    child: Row(
                      children: [
                        const Icon(Icons.link, size: 18, color: Colors.blueAccent),
                        const SizedBox(width: 10),
                        Text('recursos.exre.app/${resource.id}', style: const TextStyle(fontSize: 13, color: Colors.blueAccent)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Botón Marcar Completado
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: isCompleted ? Colors.green : Colors.white54),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        backgroundColor: isCompleted ? Colors.green.withOpacity(0.1) : Colors.transparent,
                      ),
                      icon: Icon(Icons.check, color: isCompleted ? Colors.green : Colors.white),
                      label: Text(isCompleted ? 'Completado' : 'Marcar como completado', style: TextStyle(color: isCompleted ? Colors.green : Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                      onPressed: () => appState.toggleCompleted(resource.id),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMetaChip(BuildContext context, IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 14, color: Colors.grey),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white)),
        ],
      ),
    );
  }
}