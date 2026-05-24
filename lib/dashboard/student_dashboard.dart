import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ✅ IMPORTACIÓN CORREGIDA
import '../screens/test_screen.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎓 Mi Panel'),
        backgroundColor: Colors.lightGreen[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.green[50],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.menu_book,
                size: 100,
                color: Colors.green,
              ),
              const SizedBox(height: 20),
              Text(
                '¡Hola, Estudiante! 👋',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                user?.email ?? '',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 40),

              // 🔘 Botón: Mis Cursos
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('🚧 Función en desarrollo')),
                  );
                },
                icon: const Icon(Icons.class_),
                label: const Text('Mis Cursos'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen[600],
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
              const SizedBox(height: 15),

              // 🔘 Botón: Realizar Test Vocacional ✅ CON DATOS REALES
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TestScreen(
                        estudiante: {
                          'nombre': user?.email?.split('@')[0] ?? 'Estudiante',
                          'correo': user?.email ?? '',
                          'institucion': 'VocaColombia',
                        },
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.quiz),
                label: const Text('Realizar Test Vocacional'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen[600],
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}