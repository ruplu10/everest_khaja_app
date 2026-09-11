import 'package:flutter/material.dart';
import '../theme.dart';
import 'login_screen.dart';

/// Screen 1 of the Figma prototype. Presentational - links to Login.
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.landscape, size: 64, color: AppColors.brandRed),
              const SizedBox(height: 16),
              const Text('Everest Khaja',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600, color: AppColors.brandRed)),
              const SizedBox(height: 6),
              const Text('Himalayan flavours, delivered fast',
                  style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 20, height: 6, margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(color: AppColors.brandRed, borderRadius: BorderRadius.circular(3))),
                  Container(width: 6, height: 6, margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(3))),
                  Container(width: 6, height: 6, margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(3))),
                ],
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                  child: const Text('Get started'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
