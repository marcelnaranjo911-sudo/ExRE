import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/resource.dart';
import '../widgets/resource_list_card.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String _searchQuery = '';
  ResourceCategory? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final filteredList = mockResources.where((r) {
      final matchesSearch = r.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          r.author.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCat = _selectedCategory == null || r.category == _selectedCategory;
      return matchesSearch && matchesCat;
    }).toList();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Text('Catálogo', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (val) => setState(() => _searchQuery = val),
              decoration: InputDecoration(
                hintText: 'Buscar por título, categoría o autor',
                hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                prefixIcon: const Icon(Icons.search, size: 18, color: Colors.grey),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Colors.white12)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Colors.blueAccent)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 35,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildChip(null, 'Todas'),
                ...ResourceCategory.values.map((cat) => _buildChip(cat, cat.name[0].toUpperCase() + cat.name.substring(1)))
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('RESULTADOS (${filteredList.length})', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 0.5)),
          ),
          const SizedBox(height: 10),
          Expanded(
            // Uso de ListView.separated según los requerimientos (RF2)
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: filteredList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                return ResourceListCard(resource: filteredList[index]);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChip(ResourceCategory? cat, String label) {
    final isSelected = _selectedCategory == cat;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label, style: TextStyle(fontSize: 12, color: isSelected ? Colors.blue : Colors.white70)),
        selected: isSelected,
        onSelected: (val) => setState(() => _selectedCategory = val ? cat : null),
        backgroundColor: Colors.white10,
        selectedColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: isSelected ? Colors.white : Colors.white24)),
      ),
    );
  }
}