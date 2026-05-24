// 📁 lib/dashboard/dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'analytics_screen.dart';
import 'dashboard_service.dart';

import '../screens/institutions_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/students_screen.dart';
import '../test_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardService _service = DashboardService();

  int totalEstudiantes = 0;
  int totalResultados = 0;
  String perfilMasComun = '...';

  bool loading = true;

  @override
  void initState() {
    super.initState();
    cargarDashboard();
  }

  Future<void> cargarDashboard() async {
    final estudiantes = await _service.totalEstudiantes();
    final resultados = await _service.totalResultados();
    final perfil = await _service.perfilMasComun();

    if (!mounted) return;

    setState(() {
      totalEstudiantes = estudiantes;
      totalResultados = resultados;
      perfilMasComun = perfil;
      loading = false;
    });
  }

  Future<void> cerrarSesion() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('📊 Dashboard Administrativo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics),
            tooltip: 'Analytics',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AnalyticsScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: cerrarSesion,
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            DashboardCard(
              titulo: 'Estudiantes',
              valor: totalEstudiantes.toString(),
              icono: Icons.people,
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const StudentsScreen(),
                  ),
                );
              },
            ),

            DashboardCard(
              titulo: 'Tests Realizados',
              valor: totalResultados.toString(),
              icono: Icons.assignment,
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TestScreen(
                      estudiante: const {
                        'nombre': 'Estudiante Demo',
                        'correo': 'demo@vocacolombia.com',
                        'institucion': 'VocaColombia',
                      },
                    ),
                  ),
                );
              },
            ),

            DashboardCard(
              titulo: 'Perfil Más Común',
              valor: perfilMasComun,
              icono: Icons.psychology,
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfileScreen(),
                  ),
                );
              },
            ),

            DashboardCard(
              titulo: 'Instituciones',
              valor: 'Activas',
              icono: Icons.school,
              color: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const InstitutionsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// 🔥 DASHBOARD CARD
// ======================================================

class DashboardCard extends StatelessWidget {
  final String titulo;
  final String valor;
  final IconData icono;
  final Color color;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.titulo,
    required this.valor,
    required this.icono,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icono, size: 50, color: color),
              const SizedBox(height: 15),
              Text(
                valor,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                titulo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}