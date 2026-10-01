import 'package:flutter/material.dart';
import '../main.dart';
import '../data/mock_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _getLifecycleMessage(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed: return 'La app está activa y visible';
      case AppLifecycleState.inactive: return 'La app está inactiva';
      case AppLifecycleState.paused: return 'La app está en segundo plano';
      case AppLifecycleState.detached: return 'La app está desvinculada';
      case AppLifecycleState.hidden: return 'La app está oculta';
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('BIENVENIDO A', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1, color: Colors.grey)),
            const Text('ExRE', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 28),

            // Tarjeta de Ciclo de Vida
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white12)),
              child: Row(
                children: [
                  Container(
                    width: 38, height: 38,
                    decoration: BoxDecoration(color: Colors.blue.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.local_activity, color: Colors.blueAccent, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Estado del ciclo de vida', style: TextStyle(fontSize: 11, color: Colors.grey)),
                        Text('${appState.lifecycleState.name} · ${_getLifecycleMessage(appState.lifecycleState)}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Contadores
            Row(
              children: [
                _buildStatCard(context, '${mockResources.length}', 'Disponibles'),
                const SizedBox(width: 12),
                _buildStatCard(context, '${appState.favoriteIds.length}', 'Favoritos'),
                const SizedBox(width: 12),
                _buildStatCard(context, '${appState.completedIds.length}', 'Completados'),
              ],
            ),
            const SizedBox(height: 28),

            const Text('Accesos rápidos', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 12),

            // Botones de Acceso Rápido simulados visualmente (la navegación real está en el BottomNav, pero ilustramos como pide el PDF)
            Row(
              children: [
                Expanded(child: _buildQuickAccessCard('Catálogo', Icons.menu_book, const Color(0xFF0EA5E9))),
                const SizedBox(width: 12),
                Expanded(child: _buildQuickAccessCard('Galería', Icons.grid_view, const Color(0xFFE91E63))),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildQuickAccessCard('Favoritos', Icons.favorite, Colors.pinkAccent)),
                const SizedBox(width: 12),
                Expanded(child: _buildQuickAccessCard('Progreso', Icons.trending_up, Colors.green)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white12)),
        child: Column(
          children: [
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessCard(String title, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const Icon(Icons.arrow_outward, color: Colors.white70, size: 18),
            ],
          ),
          const SizedBox(height: 20),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}