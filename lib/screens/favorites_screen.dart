import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../main.dart';
import '../widgets/resource_list_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final favList = mockResources.where((r) => appState.favoriteIds.contains(r.id)).toList();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Text('Favoritos', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          Expanded(
            child: favList.isEmpty
                ? const Center(
              child: Text('Aún no tienes recursos favoritos.', style: TextStyle(color: Colors.grey, fontSize: 16)),
            )
                : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: favList.length,
              separatorBuilder: (context, index) => const Divider(color: Colors.white12, height: 24),
              itemBuilder: (context, index) => ResourceListCard(resource: favList[index]),
            ),
          )
        ],
      ),
    );
  }
}