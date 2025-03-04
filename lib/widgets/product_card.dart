import 'package:ar_app/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:ar_app/constants/app_colors.dart';
import 'package:ar_app/constants/text_styles.dart';
import 'package:ar_app/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isHorizontal;
  final VoidCallback onTryOn;

  const ProductCard({
    super.key,
    required this.product,
    this.isHorizontal = false,
    required this.onTryOn,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  // Product image
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      image: DecorationImage(
                        image: AssetImage(product.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // New badge
                  if (product.isNew)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'NEW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  // Try on button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      onPressed: onTryOn,
                      icon: const Icon(
                        Icons.face,
                        color: AppColors.primary,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Product details - Fixed height with padding to prevent overflow
            Container(
              height: isHorizontal
                  ? 95
                  : 100, // Slightly increased height for horizontal layout
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.name,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: isHorizontal
                          ? 12
                          : 14, // Smaller font for horizontal layout
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.category,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: isHorizontal
                          ? 10
                          : 12, // Smaller font for horizontal layout
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  // Price and add button row with padding to prevent overflow
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 4), // Increased bottom padding
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${product.price.toStringAsFixed(2)} DT',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            fontSize: isHorizontal
                                ? 11
                                : 13, // Smaller font for horizontal layout
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(
                              5), // Slightly smaller padding
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 14, // Smaller icon size
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
