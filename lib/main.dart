import 'package:ar_app/constants/app_colors.dart';
import 'package:ar_app/screens/home_screen.dart';
import 'package:ar_app/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Check if onboarding has been completed
  final prefs = await SharedPreferences.getInstance();
  final showOnboarding = prefs.getBool('onboarding_complete') != true;
  
  runApp(MyApp(showOnboarding: showOnboarding));
}

class MyApp extends StatelessWidget {
  final bool showOnboarding;
  
  const MyApp({
    super.key,
    required this.showOnboarding,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loca Eye Wear',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
      ),
      home: showOnboarding ? const OnboardingScreen() : const HomeScreen(),
    );
  }
}