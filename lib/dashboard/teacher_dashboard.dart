// 📁 lib/dashboard/teacher_dashboard.dart
// Panel exclusivo para Docentes

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/teacher_students_screen.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.blue.shade50,

      appBar: AppBar(
        title: const Text('🧑‍🏫 Panel Docente'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        elevation: 0,

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // ✅ ICONO PRINCIPAL
                const Icon(
                  Icons.school,
                  size: 100,
                  color: Colors.blue,
                ),

                const SizedBox(height: 20),

                // ✅ TÍTULO
                const Text(
                  '¡Hola, Docente!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 10),

                // ✅ EMAIL DEL USUARIO
                Text(
                  user?.email ?? 'Sin correo registrado',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // =====================================================
                // ✅ BOTÓN: VER ESTUDIANTES
                // =====================================================

                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const TeacherStudentsScreen(),
                        ),
                      );
                    },

                    icon: const Icon(Icons.people),

                    label: const Text(
                      'Ver Estudiantes y Resultados',
                      style: TextStyle(fontSize: 16),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // =====================================================
                // ✅ BOTÓN: ESTADÍSTICAS
                // =====================================================

                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            '🚧 Estadísticas en desarrollo',
                          ),
                        ),
                      );
                    },

                    icon: const Icon(Icons.bar_chart),

                    label: const Text(
                      'Estadísticas del Grupo',
                      style: TextStyle(fontSize: 16),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}