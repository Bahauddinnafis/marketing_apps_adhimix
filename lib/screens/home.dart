import 'package:flutter/material.dart';
import 'package:marketing_apps/screens/marketing_main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
      ),
      body: Column(
        children: [
          const Text('HomeScreen'),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MarketingMain(),
                  ),
                );
              },
              child: const Text('Marketing'),
            ),
          )
        ],
      ),
    );
  }
}
