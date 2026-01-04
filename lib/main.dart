import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ios26_testing/screens/home_screen.dart';
import 'package:ios26_testing/screens/search_screen.dart';
import 'package:ios26_testing/screens/cart_screen.dart';
import 'package:ios26_testing/screens/orders_screen.dart';
import 'package:ios26_testing/screens/profile_screen.dart';
import 'package:ios26_testing/screens/admin_screen.dart';
import 'package:ios26_testing/screens/db_test_screen.dart';
import 'package:ios26_testing/services/mongodb_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize MongoDB connection
  try {
    await MongoDBService.instance.connect();
  } catch (e) {
    debugPrint('Failed to connect to MongoDB: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive UI Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFC46131),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(
        title: 'My App',
        actions: [
          AdaptiveAppBarAction(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DbTestScreen()),
              );
            },
            iosSymbol: 'antenna.radiowaves.left.and.right',
            icon: Icons.storage,
          ),
          AdaptiveAppBarAction(
            onPressed: () {},
            iosSymbol: 'gear',
            icon: Icons.settings,
          ),
        ],
      ),
      bottomNavigationBar: AdaptiveBottomNavigationBar(
        items: [
          AdaptiveNavigationDestination(icon: 'house.fill', label: 'Home'),
          AdaptiveNavigationDestination(
            icon: 'magnifyingglass',
            label: 'Search',
          ),
          AdaptiveNavigationDestination(icon: 'bag.fill', label: 'Cart'),
          AdaptiveNavigationDestination(
            icon: 'list.bullet.rectangle',
            label: 'Orders',
          ),
          AdaptiveNavigationDestination(icon: 'person.fill', label: 'Profile'),
          AdaptiveNavigationDestination(
            icon: 'rectangle.3.group.bubble.left',
            label: 'Admin',
          ),
        ],
        selectedIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFC46131),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const SearchScreen();
      case 2:
        return const CartScreen();
      case 3:
        return const OrdersScreen();
      case 4:
        return const ProfileScreen();
      case 5:
        return const AdminScreen();
      default:
        return const Center(child: Text('Unknown Screen'));
    }
  }
}
