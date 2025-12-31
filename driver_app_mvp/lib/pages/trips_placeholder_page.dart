import 'package:flutter/material.dart';

class TripsPlaceholderPage extends StatelessWidget {
  const TripsPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Viagens')),
      body: const Center(child: Text('Em breve')),
    );
  }
}
