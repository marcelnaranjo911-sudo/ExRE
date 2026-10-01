import 'package:flutter/material.dart';
import '../models/resource.dart';
import '../screens/detail_screen.dart';
import '../main.dart';

class ResourceGridCard extends StatelessWidget {
  final Resource resource;
  const ResourceGridCard({super.key, required this.resource});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final isFavorite = appState.favoriteIds.contains(resource.id);
    final isCompleted = appState.completedIds.contains(resource.id);

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(resource: resource)));
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                color: resource.color,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(resource.typeIcon, size: 28, color: Colors.white),
                    if (isCompleted)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.green,
                          child: const Icon(Icons.check, size: 14, color: Colors.white),
                        ),
                      ),
                    if (isFavorite)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.black45,
                          child: const Icon(Icons.favorite, size: 14, color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resource.title,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${resource.categoryName} · ${resource.levelName}',
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}