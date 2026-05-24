import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _loading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _register() async {
    // ✅ Validar formulario
    if (!_formKey.currentState!.validate()) return;

    // ✅ Validar que las contraseñas coincidan
    if (_passCtrl.text != _confirmCtrl.text) {
      setState(() {
        _errorMessage = 'Las contraseñas no coinciden';
      });
      return;
    }

    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    // ✅ Llamar al servicio de registro
    final error = await AuthService().register(
      email: _emailCtrl.text.trim(),
      password: _passCtrl.text.trim(),
    );

    setState(() => _loading = false);

    if (error == null && mounted) {
      // ✅ Éxito: AuthGate detectará el nuevo usuario y lo redirigirá al StudentDashboard
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Registro exitoso. Bienvenido como estudiante.'),
          backgroundColor: Colors.green,
        ),
      );
      // Regresar al flujo principal (AuthGate manejará la redirección)
      Navigator.pop(context);
    } else {
      // ❌ Mostrar error
      setState(() {
        _errorMessage = error ?? 'Error al registrar. Intenta con otro correo.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Cuenta'),
        backgroundColor: Colors.green[900],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 🎓 Ícono y título
                const Icon(
                  Icons.menu_book,
                  size: 80,
                  color: Colors.green,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Registro de Estudiante',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tu cuenta se creará con rol de estudiante',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 32),

                // 📧 Campo Email
                TextFormField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa tu correo';
                    }
                    if (!value.contains('@')) {
                      return 'Correo inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 🔐 Campo Contraseña
                TextFormField(
                  controller: _passCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa una contraseña';
                    }
                    if (value.length < 6) {
                      return 'Mínimo 6 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 🔐 Confirmar Contraseña
                TextFormField(
                  controller: _confirmCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Confirmar contraseña',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirma tu contraseña';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // ❌ Mensaje de error (si existe)
                if (_errorMessage != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red[900], fontSize: 14),
                    ),
                  ),
                if (_errorMessage != null) const SizedBox(height: 16),

                // 🔄 Loading o Botón de registro
                _loading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton.icon(
                  onPressed: _register,
                  icon: const Icon(Icons.person_add),
                  label: const Text('Registrarme como Estudiante'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[900],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 24),

                // 🔙 Botón para volver al login
                TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, size: 18),
                  label: const Text('Ya tengo cuenta → Iniciar sesión'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}