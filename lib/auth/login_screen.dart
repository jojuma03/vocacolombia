import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ✅ Import para la pantalla de registro (misma carpeta auth/)
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ======================================================
  // 🔐 LOGIN FIREBASE DIRECTO
  // ======================================================
  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Completa todos los campos'),
        ),
      );
      return;
    }

    setState(() => loading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // ✅ AuthGate se encarga de redirigir automáticamente según el rol

    } on FirebaseAuthException catch (e) {
      String msg;

      switch (e.code) {
        case 'user-not-found':
          msg = '❌ Usuario no encontrado';
          break;
        case 'wrong-password':
          msg = '❌ Contraseña incorrecta';
          break;
        case 'invalid-email':
          msg = '❌ Correo inválido';
          break;
        case 'user-disabled':
          msg = '⚠️ Usuario deshabilitado';
          break;
        default:
          msg = '❌ Error de autenticación';
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    if (mounted) {
      setState(() => loading = false);
    }
  }

  // ======================================================
  // 🔥 UI
  // ======================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 🎓 Logo
                    const Icon(
                      Icons.school,
                      size: 90,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 20),

                    // 🏷️ Título
                    const Text(
                      'VocaColombia',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Ingreso Administrativo',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 35),

                    // 📧 Campo Email
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Correo',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 🔐 Campo Contraseña
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // 🔘 Botón Ingresar
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: loading ? null : login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        child: loading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                          'Ingresar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // ✅ BOTÓN DE REGISTRO (NUEVO - Opción 3)
                    const SizedBox(height: 16),
                    TextButton.icon(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      ),
                      icon: const Icon(Icons.person_add, size: 18),
                      label: const Text('¿No tienes cuenta? Regístrate como estudiante'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}