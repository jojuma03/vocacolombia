// 📁 lib/pantalla_introduccion.dart
import 'package:flutter/material.dart';
import 'consentimiento_screen.dart';
import 'test_screen.dart';
import 'login_admin_screen.dart'; // ✅ NUEVO

class PantallaIntroduccion extends StatefulWidget {
  const PantallaIntroduccion({super.key});

  @override
  State<PantallaIntroduccion> createState() => _PantallaIntroduccionState();
}

class _PantallaIntroduccionState extends State<PantallaIntroduccion> {
  bool _aceptoHonestidad = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // ✅ Botón admin discreto arriba a la derecha
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginAdminScreen(),
                      ),
                    ),
                    child: const Text(
                      'Admin',
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),

                const Icon(Icons.school, size: 80, color: Colors.white),
                const SizedBox(height: 20),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'Bienvenido a tu\nOrientación Vocacional',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1565C0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        _buildSeccion(
                          Icons.favorite,
                          'Responde con honestidad',
                          'No existen respuestas correctas o incorrectas. Lo importante es responder con sinceridad.',
                        ),
                        const SizedBox(height: 18),
                        _buildSeccion(
                          Icons.psychology,
                          'Sin presión',
                          'Este test no decide por ti. Te ayuda a descubrir áreas compatibles contigo.',
                        ),
                        const SizedBox(height: 18),
                        _buildSeccion(
                          Icons.access_time,
                          'Duración aproximada',
                          '100 preguntas · 10 a 15 minutos.',
                        ),
                        const SizedBox(height: 25),
                        const Divider(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: _aceptoHonestidad,
                              activeColor: const Color(0xFF1565C0),
                              onChanged: (v) {
                                setState(() {
                                  _aceptoHonestidad = v ?? false;
                                });
                              },
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: 12),
                                child: Text(
                                  'Me comprometo a responder con honestidad.',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _aceptoHonestidad
                                ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ConsentimientoScreen(
                                        onAceptar: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                              const TestScreen(
                                                estudiante: {},
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                ),
                              );
                            }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1565C0),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text(
                              'CONTINUAR',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildSeccion(IconData icono, String titulo, String contenido) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icono, color: const Color(0xFF1565C0)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                ),
              ),
              const SizedBox(height: 4),
              Text(contenido),
            ],
          ),
        ),
      ],
    );
  }
}