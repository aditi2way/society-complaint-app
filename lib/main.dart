import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Society Complaint App',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.apartment_rounded, size: 80, color: AppTheme.primary),
              SizedBox(height: 16),
              Text(
                'Society Complaint App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primary,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Setup complete! 🎉',
                style: TextStyle(color: Color(0xFF64748B)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}