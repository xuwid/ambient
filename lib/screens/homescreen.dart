import 'package:flutter/material.dart';
import 'package:ambient/screens/timeZone.dart';
import 'package:ambient/widgets/background_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TimezoneScreen()),
              );
            },
            child: const Text('Go to Timezone Selector'),
          ),
        ),
      ),
    );
  }
}
