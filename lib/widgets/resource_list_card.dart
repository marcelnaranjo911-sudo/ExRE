import 'package:flutter/material.dart';
import '../models/resource.dart';
import '../screens/detail_screen.dart';
import '../main.dart';

class ResourceListCard extends StatelessWidget {
  final Resource resource;
  const ResourceListCard({super.key, required this.resource});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final isFavorite = appState.favoriteIds.contains(resource.id);

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(resource: resource)));
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: resource.color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(resource.typeIcon, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resource.title,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(resource.categoryName, style: TextStyle(fontSize: 12, color: resource.color)),
                      const Text(' · ', style: TextStyle(color: Colors.grey)),
                      Text(resource.author, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.timer_outlined, size: 12, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text('${resource.durationMinutes} min', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                      const SizedBox(width: 10),
                      Text(resource.levelName, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  )
                ],
              ),
            ),
            IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              color: isFavorite ? Colors.pinkAccent : Colors.grey,
              onPressed: () => appState.toggleFavorite(resource.id),
            )
          ],
        ),
      ),
    );
  }
}