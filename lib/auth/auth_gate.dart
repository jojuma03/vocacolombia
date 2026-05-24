// 📁 lib/auth/auth_gate.dart
// Controla acceso según autenticación y rol

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Dashboards
import '../dashboard/admin_dashboard.dart';
import '../dashboard/teacher_dashboard.dart';
import '../dashboard/student_dashboard.dart';

// Servicios
import '../services/user_role_service.dart';

// Pantallas
import 'login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),

      builder: (context, snapshot) {

        // =====================================================
        // 🔄 CARGANDO AUTENTICACIÓN
        // =====================================================

        if (snapshot.connectionState ==
            ConnectionState.waiting) {

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // =====================================================
        // 🚪 SIN USUARIO → LOGIN
        // =====================================================

        if (!snapshot.hasData) {
          return const LoginScreen();
        }

        // =====================================================
        // ✅ USUARIO AUTENTICADO
        // → VERIFICAR ROL
        // =====================================================

        return FutureBuilder<String>(
          future: UserRoleService().getRole(),

          builder: (context, roleSnapshot) {

            // 🔄 Cargando rol
            if (roleSnapshot.connectionState ==
                ConnectionState.waiting) {

              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            // ❌ Error obteniendo rol
            if (roleSnapshot.hasError) {

              return Scaffold(
                body: Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      '❌ Error obteniendo rol:\n\n${roleSnapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }

            // =====================================================
            // 🎭 ROL DEL USUARIO
            // =====================================================

            final role = roleSnapshot.data ?? '';

            // 👑 ADMIN
            if (role == 'admin') {
              return const AdminDashboard();
            }

            // 👨‍🏫 DOCENTE
            if (role == 'teacher') {
              return const TeacherDashboard();
            }

            // 👨‍🎓 ESTUDIANTE
            if (role == 'student') {
              return const StudentDashboard();
            }

            // =====================================================
            // ⚠️ ROL NO RECONOCIDO
            // =====================================================

            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),

                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,

                    children: [

                      const Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.orange,
                        size: 80,
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Rol no reconocido',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Rol detectado: "$role"',
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 30),

                      ElevatedButton.icon(
                        onPressed: () async {
                          await FirebaseAuth.instance
                              .signOut();
                        },

                        icon: const Icon(Icons.logout),

                        label: const Text(
                          'Cerrar sesión',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}