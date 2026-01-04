import 'package:flutter/material.dart';
import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:ios26_testing/widgets/featured_card.dart';
import 'package:ios26_testing/screens/new_arrival_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ios26_testing/widgets/video_player_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedQuickActionIndex = 0;

  final List<Map<String, String>> _featured = const [
    {
      'title': 'New Arrival',
      'description': 'Vision Pro accessories just dropped',
      'color': '0xFFC46131',
      'imageUrl':
          'https://www.apple.com/v/iphone-17-pro/d/images/overview/cameras/intro/camera_hero_endframe__eap4grnpqa2q_xlarge_2x.jpg',
    },
    {
      'title': 'Limited Bundle',
      'description': 'Mac + Studio Display savings',
      'color': '0xFF2E4A62',
    },
    {
      'title': 'Member Perks',
      'description': 'Early access to spring releases',
      'color': '0xFF304D30',
    },
  ];

  final List<String> _categories = const [
    'Phones',
    'Audio',
    'Wearables',
    'Laptops',
    'Tablets',
    'Smart Home',
    'Accessories',
    'Services',
  ];

  final List<Map<String, dynamic>> _newProducts = const [
    {
      'name': 'iPhone 17 Pro',
      'price': 1199.0,
      'tag': 'NEW',
      'icon': Icons.phone_iphone,
      'description': 'Latest camera technology',
      'imageUrl':
          'https://www.apple.com/v/iphone-17-pro/d/images/overview/welcome/hero_endframe__xdzisdq1ppem_xlarge_2x.jpg',
    },
    {
      'name': 'MacBook Pro M4',
      'price': 2499.0,
      'tag': 'NEW',
      'icon': Icons.laptop_mac,
      'description': 'Revolutionary performance',
    },
    {
      'name': 'AirPods Max 2',
      'price': 599.0,
      'tag': 'NEW',
      'icon': Icons.headset,
      'description': 'Premium audio experience',
    },
    {
      'name': 'Apple Watch Ultra 3',
      'price': 899.0,
      'tag': 'NEW',
      'icon': Icons.watch,
      'description': 'Ultimate adventure companion',
    },
    {
      'name': 'iPad Pro M4',
      'price': 1299.0,
      'tag': 'NEW',
      'icon': Icons.tablet,
      'description': 'Thinnest Apple device ever',
    },
    {
      'name': 'Vision Pro 2',
      'price': 3999.0,
      'tag': 'NEW',
      'icon': Icons.visibility,
      'description': 'Next-gen spatial computing',
    },
  ];

  final List<Map<String, dynamic>> _recommended = const [
    {
      'name': 'iPhone 15 Pro',
      'price': 999.0,
      'tag': 'Ships today',
      'icon': Icons.phone_iphone,
    },
    {
      'name': 'AirPods Pro',
      'price': 249.0,
      'tag': 'Noise canceling',
      'icon': Icons.headphones,
      'imageUrl':
          'https://www.apple.com/v/airpods-4/g/images/overview/bento-gallery/bento_case_open__63kccmu775u6_xlarge_2x.jpg',
    },
    {
      'name': 'Apple Watch 9',
      'price': 399.0,
      'tag': 'Health ready',
      'icon': Icons.watch,
    },
    {
      'name': 'iPad Air',
      'price': 599.0,
      'tag': 'M2 power',
      'icon': Icons.tablet,
    },
  ];

  final List<Map<String, dynamic>> _bundles = const [
    {
      'title': 'Work Anywhere',
      'items': 'MacBook Air + Magic Mouse',
      'price': 'Save 12%',
      'icon': Icons.work_outline,
    },
    {
      'title': 'Fitness Kit',
      'items': 'Watch + Fitness+ 6 mo',
      'price': 'From \$19/mo',
      'icon': Icons.fitness_center,
    },
    {
      'title': 'Creator Pack',
      'items': 'iPad + Pencil + Logic',
      'price': 'Bonus storage',
      'icon': Icons.brush,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeroBanner(theme),
          const SizedBox(height: 16),
          // iPhone 17 Pro Video
          const VideoPlayerWidget(
            videoUrl:
                'https://www.apple.com/105/media/ww/iphone-17-pro/2025/4f5fca2d-1134-4e84-b303-42adf2581cf8/anim/highlights-design/large_2x.mp4',
            height: 250,
            autoPlay: true,
            loop: true,
          ),
          const SizedBox(height: 16),
          _buildSearchRow(context),
          const SizedBox(height: 12),
          _buildQuickActions(),
          const SizedBox(height: 16),

          // Show different content based on selected tab
          if (_selectedQuickActionIndex == 1) ...[
            // New Products Section
            _buildNewProductsSection(),
          ] else ...[
            // Default content (Deals, Pickup, Support)
            _buildDefaultContent(),
          ],
        ],
      ),
    );
  }

  Widget _buildNewProductsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('New Products'),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _newProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final product = _newProducts[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewArrivalScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // New Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC46131),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        product['tag'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Image or Icon
                    if (product['imageUrl'] != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: product['imageUrl'] as String,
                          height: 80,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            height: 80,
                            color: Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (context, url, error) => Center(
                            child: Icon(
                              product['icon'] as IconData,
                              size: 48,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      )
                    else
                      Center(
                        child: Icon(
                          product['icon'] as IconData,
                          size: 48,
                          color: Colors.black87,
                        ),
                      ),
                    const Spacer(),
                    // Product name
                    Text(
                      product['name'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Description
                    Text(
                      product['description'] as String,
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Price
                    Text(
                      '\$${product['price']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFFC46131),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDefaultContent() {
    return Column(
      children: [
        _sectionHeader('Featured drops'),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _featured.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final card = _featured[index];
              return GestureDetector(
                onTap: () {
                  if (index == 0) {
                    // Navigate to New Arrival Screen when tapping first card
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewArrivalScreen(),
                      ),
                    );
                  }
                },
                child: SizedBox(
                  width: 240,
                  child: FeaturedCard(
                    title: card['title']!,
                    description: card['description']!,
                    color: Color(int.parse(card['color']!)),
                    imageUrl: card['imageUrl'],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        _sectionHeader('Top categories'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _categories
              .map(
                (category) => Chip(
                  label: Text(category),
                  backgroundColor: Colors.grey[200],
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 20),
        _sectionHeader('Recommended for you'),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _recommended.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final item = _recommended[index];
            return _ProductCard(
              name: item['name'] as String,
              price: item['price'] as double,
              tag: item['tag'] as String,
              icon: item['icon'] as IconData,
              imageUrl: item['imageUrl'] as String?,
            );
          },
        ),
        const SizedBox(height: 20),
        _sectionHeader('Curated bundles'),
        const SizedBox(height: 12),
        Column(
          children: _bundles
              .map(
                (bundle) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(bundle['icon'] as IconData, color: Colors.black87),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bundle['title'] as String,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              bundle['items'] as String,
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        bundle['price'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFC46131),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildHeroBanner(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFC46131), Color(0xFFB24C1F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Build your setup with curated picks and fresh drops.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFFC46131),
                      ),
                      onPressed: () {},
                      child: const Text('Start shopping'),
                    ),
                    const SizedBox(width: 12),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Track orders'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.store_mall_directory, color: Colors.white, size: 54),
        ],
      ),
    );
  }

  Widget _buildSearchRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search devices, accessories, services',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 52,
          width: 52,
          decoration: BoxDecoration(
            color: const Color(0xFFC46131),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.tune, color: Colors.white),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return AdaptiveSegmentedControl(
      labels: const ['Deals', 'New', 'Pickup', 'Support'],
      selectedIndex: _selectedQuickActionIndex,
      onValueChanged: (index) {
        setState(() {
          _selectedQuickActionIndex = index;
        });
        debugPrint(
          'Selected quick action: ${["Deals", "New", "Pickup", "Support"][index]}',
        );
      },
    );
  }

  Widget _sectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(onPressed: () {}, child: const Text('See all')),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String name;
  final double price;
  final String tag;
  final IconData icon;
  final String? imageUrl;

  const _ProductCard({
    required this.name,
    required this.price,
    required this.tag,
    required this.icon,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFC46131).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                tag,
                style: const TextStyle(
                  color: Color(0xFFC46131),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: imageUrl!,
                height: 60,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 60,
                  color: Colors.grey[200],
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) => CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white,
                  child: Icon(icon, color: Colors.black87),
                ),
              ),
            )
          else
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              child: Icon(icon, color: Colors.black87),
            ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            '\$${price.toStringAsFixed(0)}',
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC46131),
                foregroundColor: Colors.white,
              ),
              onPressed: () {},
              child: const Text('Add'),
            ),
          ),
        ],
      ),
    );
  }
}
