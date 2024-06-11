

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen 1'),
      ),
      body: const Center(
        child: Text('Welcome to Home Screen 2'),
      ),
    );

  }
}