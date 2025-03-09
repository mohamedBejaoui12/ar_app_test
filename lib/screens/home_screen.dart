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

  // Demo products with updated AR filter paths
  final List<Product> _featuredProducts = [
    Product(
      id: 1, // Changed from String to int
      name: 'Classic Aviator',
      description: 'Timeless aviator sunglasses with polarized lenses',
      price: 129.99,
      imageUrl: 'assets/products/oakley_holbrook.png',
      arFilterPath: 'sunglasses1.deepar',
      isNew: true,
      colors: ['Black', 'Gold'], // Added required colors parameter
      category: 'Sunglasses', // Added required category parameter
    ),
    Product(
      id: 2, // Changed from String to int
      name: 'Modern Wayfarer',
      description: 'Contemporary take on the classic wayfarer design',
      price: 149.99,
      imageUrl: 'assets/products/gucci_gg0396s.png',
      arFilterPath: 'sunglasses2.deepar',
      isNew: true,
      colors: ['Black', 'Tortoise'], // Added required colors parameter
      category: 'Sunglasses', // Added required category parameter
    ),
    Product(
      id: 3, // Changed from String to int
      name: 'warby Classic',
      description: 'Timeless aviator sunglasses with polarized lenses',
      price: 39.99,
      imageUrl: 'assets/products/warby_harper.png',
      arFilterPath: 'sunglasses1.deepar',
      isNew: true,
      colors: ['Black', 'Gold'], // Added required colors parameter
      category: 'Sunglasses', // Added required category parameter
    ),
    Product(
      id: 4, // Changed from String to int
      name: 'Rayban Classic',
      description: 'Contemporary take on the classic wayfarer design',
      price: 99.99,
      imageUrl: 'assets/products/rayban_wayfarer.png',
      arFilterPath: 'sunglasses2.deepar',
      isNew: true,
      colors: ['Black', 'Tortoise'], // Added required colors parameter
      category: 'Sunglasses', // Added required category parameter
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Loca Eye Wear',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: Colors.black,
            ),
            onPressed: () {},
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
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for eyewear...',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey[600],
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
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
                      builder: (context) => const ArTryOnScreen(
                        filterPath: 'sunglasses2.deepar',
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -20,
                        bottom: -20,
                        child: Icon(
                          Icons.face,
                          size: 150,
                          color: Colors.grey[300],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Virtual Try-On',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'See how glasses look on you',
                              style: TextStyle(
                                color: Colors.grey[600],
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
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Try Now',
                                style: TextStyle(
                                  color: Colors.white,
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
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
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
                    isHorizontal: false,
                  );
                },
              ),
              const SizedBox(height: 24),
              // New Arrivals
              Text(
                'New Arrivals',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // New Arrivals Horizontal List
              SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _featuredProducts.where((p) => p.isNew).length,
                  itemBuilder: (context, index) {
                    final newProducts =
                        _featuredProducts.where((p) => p.isNew).toList();
                    return Container(
                      width: 180,
                      margin: const EdgeInsets.only(right: 16),
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
        backgroundColor: Colors.black,
        child: const Icon(Icons.camera_alt, color: Colors.white),
        onPressed: () {
          // AR Quick Try-On functionality
        },
      ),
    );
  }
}
