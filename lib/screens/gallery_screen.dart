import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../widgets/resource_grid_card.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 16, 20, 4),
            child: Text('Galería', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          Expanded(
            // Uso obligatorio de GridView.builder con mínimo 2 columnas (RF3)
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.85,
              ),
              itemCount: mockResources.length,
              itemBuilder: (context, index) {
                return ResourceGridCard(resource: mockResources[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}