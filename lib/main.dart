import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ambient/screens/homescreen.dart'; // Your HomeScreen
import 'package:ambient/models/state_models.dart'; // Your state management
import 'package:ambient/screens/Login.dart';
import 'package:ambient/screens/Signup.dart';
import 'package:ambient/screens/splash.dart'; // Import your SplashScreen

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreenWrapper(), // Show the splash screen first
      routes: {
        '/homeTab': (context) => const HomeScreen(),
        '/login': (context) => LoginPage(),
        // Other routes
      },
    );
  }
}

class SplashScreenWrapper extends StatefulWidget {
  const SplashScreenWrapper({super.key});
  @override
  _SplashScreenWrapperState createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  _navigateToNext() async {
    await Future.delayed(Duration(seconds: 2), () {}); // Simulate loading time
    Navigator.pushReplacementNamed(context, '/login'); // Navigate to login page
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen(); // Display your splash screen
  }
}
