import 'dart:io';
import 'package:flutter/material.dart';
import 'package:deepar_flutter/deepar_flutter.dart';
import 'package:ar_app/constants/app_colors.dart';
import 'package:ar_app/constants/text_styles.dart';
import 'package:ar_app/data/filter_data.dart';
import 'package:ar_app/models/filter.dart';

class ArTryOnScreen extends StatefulWidget {
  final String? filterPath;

  const ArTryOnScreen({
    super.key,
    this.filterPath,
  });

  @override
  State<ArTryOnScreen> createState() => _ArTryOnScreenState();
}

class _ArTryOnScreenState extends State<ArTryOnScreen> with WidgetsBindingObserver {
  late DeepArController deepArController;
  bool _isInitialized = false;
  String? _currentFilter;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    deepArController = DeepArController();
    _initializeDeepAr();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle app lifecycle changes to properly manage camera resources
    if (state == AppLifecycleState.resumed) {
      if (_isInitialized && !_isDisposed) {
        // Reinitialize when app is resumed
        deepArController = DeepArController();
        _initializeDeepAr();
      }
    } else if (state == AppLifecycleState.inactive || 
              state == AppLifecycleState.paused || 
              state == AppLifecycleState.detached) {
      // Mark as not initialized when app is inactive/paused/detached
      _isInitialized = false;
    }
  }
  @override
  void dispose() {
    _isDisposed = true;
    _isInitialized = false;
    WidgetsBinding.instance.removeObserver(this);
    
    // CORRECTED: Use destroy() instead of dispose()
    if (deepArController.isInitialized) {
      deepArController.destroy();
    }
    
    super.dispose();
  }
  Future<void> _initializeDeepAr() async {
    if (_isDisposed || deepArController.isInitialized) return;
    
    // Add delay to ensure previous resources are released
    await Future.delayed(const Duration(milliseconds: 500));
    
    try {
      await deepArController.initialize(
        androidLicenseKey:
            '857c882cc9a07fc046954191c74eccc0aeec497ba89e7be338ec2f620c96615d68f2495447c0a8d6',
        iosLicenseKey:
            '99e9502b20748e09932cdfcb467c89a73cbfbbdefca6143abb612d6a248058f460d858858000ea93',
        resolution: Resolution.high,
      );

      if (_isDisposed) return;

      setState(() {
        _isInitialized = true;
      });

      // If a specific filter was passed, apply it
      if (widget.filterPath != null) {
        _applyFilter(widget.filterPath!);
      } else if (filters.isNotEmpty) {
        // Otherwise apply the first filter
        _applyFilter(filters.first.filterPath);
      }
    } catch (e) {
      print('DeepAR initialization error: $e');
      // Show a user-friendly error message
      if (!_isDisposed && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('AR initialization error: $e'),
            duration: const Duration(seconds: 3),
          ),
        );
        // Navigate back if AR is not supported
        Future.delayed(const Duration(seconds: 1), () {
          if (!_isDisposed && mounted) {
            Navigator.pop(context);
          }
        });
      }
    }
  }

  void _applyFilter(String filterPath) {
    if (!_isInitialized || _isDisposed) return;
    
    try {
      // Use proper asset path format - this is critical for release mode
      final effectFile = 'assets/filters/$filterPath';
      print('Applying filter: $effectFile');
      deepArController.switchEffect(effectFile);
      
      if (!_isDisposed) {
        setState(() {
          _currentFilter = filterPath;
        });
      }
    } catch (e) {
      print('Error applying filter: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to apply filter: $e')),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Virtual Try-On',
          style: AppTextStyles.heading3,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.textPrimary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _isInitialized
          ? Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildCameraPreview(),
                  ),
                ),
                _buildFilterSelector(),
                _buildControls(),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
    );
  }
  Widget _buildCameraPreview() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: DeepArPreview(deepArController),
      ),
    );
  }
  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildControlButton(
            icon: Icons.flip_camera_ios_outlined,
            label: 'Flip',
            onTap: deepArController.flipCamera,
          ),
          _buildControlButton(
            icon: Icons.camera,
            label: 'Capture',
            onTap: () async {
              await deepArController.takeScreenshot();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Screenshot saved to gallery'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            isPrimary: true,
          ),
          _buildControlButton(
            icon: Icons.flash_on,
            label: 'Flash',
            onTap: deepArController.toggleFlash,
          ),
        ],
      ),
    );
  }
  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(isPrimary ? 16 : 12),
            decoration: BoxDecoration(
              color: isPrimary ? AppColors.primary : Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isPrimary ? Colors.white : AppColors.textPrimary,
              size: isPrimary ? 30 : 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: isPrimary ? AppColors.primary : AppColors.textSecondary,
              fontWeight: isPrimary ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildFilterSelector() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = filter.filterPath == _currentFilter;

          return GestureDetector(
            onTap: () => _applyFilter(filter.filterPath),
            child: Container(
              width: 80,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image:
                            AssetImage('assets/previews/${filter.imagePath}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getFilterName(filter.filterPath),
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 12,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  // Helper method to get a user-friendly name from the filter path
  String _getFilterName(String filterPath) {
    // Remove file extension and replace underscores with spaces
    final name = filterPath.split('.').first.replaceAll('_', ' ');

    // Capitalize each word
    final words = name.split(' ');
    final capitalizedWords = words.map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    });

    return capitalizedWords.join(' ');
  }
}
