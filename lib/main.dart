import 'package:flutter/material.dart';
import 'data/mock_data.dart';
import 'screens/home_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/gallery_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/progress_screen.dart';

void main() {
  runApp(const ExREApp());
}

// 1. Estado Global usando ChangeNotifier (100% nativo)
class AppState extends ChangeNotifier {
  final Set<String> favoriteIds = {};
  final Set<String> completedIds = {};
  AppLifecycleState lifecycleState = AppLifecycleState.resumed;
  List<String> lifecycleEvents = [];

  void toggleFavorite(String id) {
    if (favoriteIds.contains(id)) {
      favoriteIds.remove(id);
    } else {
      favoriteIds.add(id);
    }
    notifyListeners();
  }

  void toggleCompleted(String id) {
    if (completedIds.contains(id)) {
      completedIds.remove(id);
    } else {
      completedIds.add(id);
    }
    notifyListeners();
  }

  void updateLifecycle(AppLifecycleState state) {
    lifecycleState = state;
    lifecycleEvents.insert(0, '${DateTime.now().toLocal().toString().split('.')[0]} - ${state.name}');
    if (lifecycleEvents.length > 5) lifecycleEvents.removeLast();
    notifyListeners();
  }
}

// 2. InheritedNotifier para proveer el estado al árbol de widgets
class AppStateProvider extends InheritedNotifier<AppState> {
  const AppStateProvider({super.key, required AppState super.notifier, required super.child});

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppStateProvider>()!.notifier!;
  }
}

class ExREApp extends StatefulWidget {
  const ExREApp({super.key});

  @override
  State<ExREApp> createState() => _ExREAppState();
}

class _ExREAppState extends State<ExREApp> with WidgetsBindingObserver {
  final AppState _appState = AppState();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _appState.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _appState.updateLifecycle(state);
  }

  @override
  Widget build(BuildContext context) {
    return AppStateProvider(
      notifier: _appState,
      child: MaterialApp(
        title: 'ExRE',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF0F111A), // Fondo oscuro profundo
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF3B82F6),
            surface: Color(0xFF1E2032), // Tarjetas
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF0F111A),
            elevation: 0,
          ),
          fontFamily: 'Roboto', // Tipografía del sistema
        ),
        home: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CatalogScreen(),
    const GalleryScreen(),
    const FavoritesScreen(),
    const ProgressScreen(),
  ];

  void _onNavigate(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white12, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onNavigate,
          backgroundColor: const Color(0xFF0F111A),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Inicio'),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), activeIcon: Icon(Icons.menu_book), label: 'Catálogo'),
            BottomNavigationBarItem(icon: Icon(Icons.grid_view_outlined), activeIcon: Icon(Icons.grid_view), label: 'Galería'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), activeIcon: Icon(Icons.favorite), label: 'Favoritos'),
            BottomNavigationBarItem(icon: Icon(Icons.trending_up_outlined), activeIcon: Icon(Icons.trending_up), label: 'Progreso'),
          ],
        ),
      ),
    );
  }
}