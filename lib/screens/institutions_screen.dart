import 'package:flutter/material.dart';

class InstitutionsScreen extends StatelessWidget {
  const InstitutionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Instituciones")),
      body: const Center(
        child: Text("Módulo de Instituciones"),
      ),
    );
  }
}