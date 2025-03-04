import 'package:flutter/material.dart';
import 'package:ar_app/constants/app_colors.dart';
import 'package:ar_app/constants/text_styles.dart';
import 'package:ar_app/widgets/product_card.dart';
import 'package:ar_app/widgets/custom_drawer.dart';
import 'package:ar_app/screens/ar_try_on_screen.dart';
import 'package:ar_app/models/product.dart';

class HomeScreen extends StatefulWidget {
  final bool isGuest;

  const HomeScreen({super.key, this.isGuest = false});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Demo products
  final List<Product> _featuredProducts = [
    Product(
      id: 1,
      name: 'Ray-Ban Wayfarer',
      description:
          'Classic design that never goes out of style. Perfect for any face shape.',
      price: 149.99,
      imageUrl: 'assets/products/rayban_wayfarer.png',
      colors: ['Black', 'Tortoise', 'Blue'],
      isNew: true,
      isFeatured: true,
      category: 'Sunglasses',
      arFilterPath: 'glasses_1.deepar',
    ),
    Product(
      id: 2,
      name: 'Oakley Holbrook',
      description:
          'Sporty design with premium polarized lenses for outdoor activities.',
      price: 189.99,
      imageUrl: 'assets/products/oakley_holbrook.png',
      colors: ['Matte Black', 'Silver', 'Red'],
      isFeatured: true,
      category: 'Sunglasses',
      arFilterPath: 'glasses_2.deepar',
    ),
    Product(
      id: 3,
      name: 'Warby Parker Harper',
      description:
          'Modern prescription glasses with blue light filtering technology.',
      price: 95.00,
      imageUrl: 'assets/products/warby_harper.png',
      colors: ['Crystal', 'Tortoise', 'Black'],
      isNew: true,
      category: 'Eyeglasses',
      arFilterPath: 'glasses_3.deepar',
    ),
    Product(
      id: 4,
      name: 'Gucci GG0396S',
      description: 'Luxury designer sunglasses with distinctive Gucci style.',
      price: 375.00,
      imageUrl: 'assets/products/gucci_gg0396s.png',
      colors: ['Gold', 'Black', 'Havana'],
      isFeatured: true,
      category: 'Sunglasses',
      arFilterPath: 'glasses_4.deepar',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Loca Eye Wear',
          style: AppTextStyles.heading3,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: AppColors.textPrimary,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: AppColors.textPrimary,
            ),
            onPressed: () {
              // Show notifications
            },
          ),
        ],
      ),
      drawer: CustomDrawer(isGuest: widget.isGuest),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for eyewear...',
                    hintStyle: AppTextStyles.bodySmall,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.textSecondary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // AR Try-On Banner
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ArTryOnScreen(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary,
                        AppColors.accent,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -20,
                        bottom: -20,
                        child: Opacity(
                          opacity: 0.2,
                          child: Icon(
                            Icons.face,
                            size: 150,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Virtual Try-On',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'See how our glasses look on you with AR technology',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Try Now',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Featured Products
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Products',
                    style: AppTextStyles.heading3,
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to all products
                    },
                    child: Text(
                      'See All',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Featured Products Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _featuredProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: _featuredProducts[index],
                    onTryOn: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArTryOnScreen(
                            filterPath: _featuredProducts[index].arFilterPath,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 24),

              // New Arrivals
              Text(
                'New Arrivals',
                style: AppTextStyles.heading3,
              ),
              const SizedBox(height: 16),

              // New Arrivals Horizontal List with improved layout
              SizedBox(
                height: 300, // Increased height to accommodate content
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(
                      bottom: 15), // Add bottom padding to prevent overflow
                  itemCount: _featuredProducts.where((p) => p.isNew).length,
                  itemBuilder: (context, index) {
                    final newProducts =
                        _featuredProducts.where((p) => p.isNew).toList();
                    return Container(
                      width: 160,
                      margin: const EdgeInsets.only(
                          right: 16, bottom: 5), // Added bottom margin
                      child: ProductCard(
                        product: newProducts[index],
                        isHorizontal: true,
                        onTryOn: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArTryOnScreen(
                                filterPath: newProducts[index].arFilterPath,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.support_agent),
        onPressed: () {
          // Show support chat
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Support chat is not available in demo mode'),
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }
}
