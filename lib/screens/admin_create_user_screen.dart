// 📁 lib/screens/admin_create_user_screen.dart
// Panel exclusivo para Administradores: Crear usuarios con rol específico

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AdminCreateUserScreen extends StatefulWidget {
  const AdminCreateUserScreen({super.key});

  @override
  State<AdminCreateUserScreen> createState() => _AdminCreateUserScreenState();
}

class _AdminCreateUserScreenState extends State<AdminCreateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  String _selectedRole = 'student';
  bool _isLoading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _createUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // 🔑 Llama al nuevo método que acepta rol dinámico
    final error = await AuthService().registerWithRole(
      email: _emailCtrl.text.trim(),
      password: _passCtrl.text.trim(),
      role: _selectedRole,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (error == null) {
      // ✅ Éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Usuario creado exitosamente'),
          backgroundColor: Colors.green,
        ),
      );
      // Limpiar formulario
      _emailCtrl.clear();
      _passCtrl.clear();
      setState(() => _selectedRole = 'student');

      // 🔐 NOTA: Firebase cambia la sesión al usuario creado.
      // Cerramos sesión para que el Admin pueda volver a entrar fácilmente.
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      // ❌ Error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Error: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('👥 Crear Usuario'),
        backgroundColor: Colors.red[800], // Color Admin
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Registra un nuevo Teacher o Student',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'El usuario deberá iniciar sesión con estos datos',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 30),

              // 📧 Campo Email
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Campo requerido';
                  if (!v.contains('@')) return 'Correo inválido';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 🔐 Campo Contraseña
              TextFormField(
                controller: _passCtrl,
                decoration: const InputDecoration(
                  labelText: 'Contraseña temporal',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Campo requerido';
                  if (v.length < 6) return 'Mínimo 6 caracteres';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 🎭 Selector de Rol
              DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: const InputDecoration(
                  labelText: 'Rol del usuario',
                  prefixIcon: Icon(Icons.badge),
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'student', child: Text('🎓 Student (Estudiante)')),
                  DropdownMenuItem(value: 'teacher', child: Text('👨‍🏫 Teacher (Docente)')),
                ],
                onChanged: (val) => setState(() => _selectedRole = val!),
              ),
              const SizedBox(height: 30),

              // 🔘 Botón Crear
              ElevatedButton(
                onPressed: _isLoading ? null : _createUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Crear Usuario', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Volver al Dashboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}