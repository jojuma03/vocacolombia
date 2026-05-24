import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ✅ IMPORTACIÓN DE LA PANTALLA DE CREAR USUARIOS
import '../screens/admin_create_user_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('👑 Admin Dashboard'),
        backgroundColor: Colors.red[900],
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.admin_panel_settings,
              size: 100,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            const Text(
              'Panel de Administrador',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Usuario: ${user?.email}'),
            const SizedBox(height: 30),

            // ✅ BOTÓN 1: Gestionar Usuarios (FUNCIONAL - Navega a crear usuario)
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AdminCreateUserScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.person_add),
              label: const Text('Crear Usuario (Student/Teacher)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[900],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
            const SizedBox(height: 15),

            // 🔘 BOTÓN 2: Ver Estadísticas (Pendiente - tu código original)
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Ver estadísticas
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('🚧 Función en desarrollo')),
                );
              },
              icon: const Icon(Icons.analytics),
              label: const Text('Ver Estadísticas'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}