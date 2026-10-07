import 'package:flutter/material.dart';
import 'screens/auth/splash_screen.dart';
import 'constants/app_colors.dart';

void main() {
  // Simple initialization without Firebase
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uni Blood Donor',
      
      theme: ThemeData(
        primaryColor: AppColors.primaryRed,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryRed),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}