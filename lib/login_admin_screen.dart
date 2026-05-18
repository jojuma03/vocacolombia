// 📁 lib/login_admin_screen.dart
import 'package:flutter/material.dart';
import 'admin_screen.dart';

class LoginAdminScreen extends StatefulWidget {
  const LoginAdminScreen({super.key});

  @override
  State<LoginAdminScreen> createState() => _LoginAdminScreenState();
}

class _LoginAdminScreenState extends State<LoginAdminScreen> {
  final _passwordController = TextEditingController();
  bool _error = false;
  bool _visible = false;

  // ✅ Cambia esta contraseña por la que quieras
  static const String _claveAdmin = 'voca2026';

  void _validar() {
    if (_passwordController.text.trim() == _claveAdmin) {
      setState(() => _error = false);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AdminScreen()),
      );
    } else {
      setState(() => _error = true);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acceso Administrador'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.admin_panel_settings,
              size: 80,
              color: Colors.blue[800],
            ),
            const SizedBox(height: 24),
            const Text(
              'Ingresa la contraseña de administrador',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _passwordController,
              obscureText: !_visible,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: const OutlineInputBorder(),
                errorText: _error ? 'Contraseña incorrecta' : null,
                suffixIcon: IconButton(
                  icon: Icon(
                    _visible ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () => setState(() => _visible = !_visible),
                ),
              ),
              onSubmitted: (_) => _validar(),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _validar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Entrar',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}