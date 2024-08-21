//import 'package:ambient/screens/Signup.dart';

import 'package:ambient/screens/Login.dart';
import 'package:ambient/screens/Signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ambient/screens/homescreen.dart'; // Your HomeScreen
import 'package:ambient/models/state_models.dart'; // Your state management

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      initialRoute: '/homeTab',
      routes: {
        '/homeTab': (context) => LoginPage(),
        // Other routes
      },
    );
  }
}
