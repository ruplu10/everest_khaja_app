import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/onboarding_screen.dart';
import 'state/cart_state.dart';
import 'theme.dart';

void main() {
  runApp(const EverestKhajaApp());
}

class EverestKhajaApp extends StatelessWidget {
  const EverestKhajaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartState()),
        ChangeNotifierProvider(create: (_) => ReservationState()),
      ],
      child: MaterialApp(
        title: 'Everest Khaja',
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(),
        home: const OnboardingScreen(),
      ),
    );
  }
}
