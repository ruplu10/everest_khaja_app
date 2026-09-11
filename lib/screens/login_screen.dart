import 'package:flutter/material.dart';
import '../theme.dart';
import 'home_screen.dart';

/// Screen 2 of the Figma prototype. Presentational form fields with basic
/// validation - links through to Home. No real authentication/backend yet.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text('Welcome back', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              const Text('Log in to order or book a table', style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 20),
              const Text('Email', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              TextField(controller: _emailController, decoration: const InputDecoration(hintText: 'name@email.com')),
              const SizedBox(height: 12),
              const Text('Password', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              TextField(controller: _passwordController, obscureText: true,
                  decoration: const InputDecoration(hintText: '••••••••')),
              if (_error != null) ...[
                const SizedBox(height: 8),
                Text(_error!, style: const TextStyle(color: Colors.red, fontSize: 12)),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_emailController.text.trim().isEmpty || _passwordController.text.isEmpty) {
                    setState(() => _error = 'Please enter an email and password');
                    return;
                  }
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                },
                child: const Text('Log in'),
              ),
              const SizedBox(height: 12),
              const Center(child: Text('Create an account', style: TextStyle(color: AppColors.brandRed))),
            ],
          ),
        ),
      ),
    );
  }
}
