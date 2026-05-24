import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 🔐 LISTA DE ADMINS PERMITIDOS (tu lógica original)
  final List<String> admins = [
    'admin@voca.com',
  ];

  // 🔐 LOGIN CON EMAIL Y PASSWORD
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // ✅ Login exitoso en Auth, el rol se valida en AuthGate vía Firestore
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'Error inesperado: $e';
    }
  }

  // 📝 REGISTRO AUTOMÁTICO CON ROL "student" (Público - Sin cambios)
  Future<String?> register({
    required String email,
    required String password,
  }) async {
    try {
      // 1️⃣ Crear usuario en Firebase Authentication
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 2️⃣ 🟢 CREAR DOCUMENTO AUTOMÁTICO EN FIRESTORE (Siempre como student)
      await _db.collection('users').doc(credential.user!.uid).set({
        'email': email,
        'role': 'student',
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': FieldValue.serverTimestamp(),
      });

      return null; // ✅ Éxito
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'Error al registrar: $e';
    }
  }

  // 👑 NUEVO: REGISTRO CON ROL PERSONALIZADO (Solo para Admin)
  Future<String?> registerWithRole({
    required String email,
    required String password,
    required String role, // 'student' o 'teacher'
  }) async {
    try {
      // 1️⃣ Crear usuario en Firebase Authentication
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 2️⃣ 🟢 CREAR DOCUMENTO EN FIRESTORE CON EL ROL ELEGIDO
      await _db.collection('users').doc(credential.user!.uid).set({
        'email': email,
        'role': role, // <--- Aquí se asigna el rol dinámicamente
        'createdAt': FieldValue.serverTimestamp(),
        'createdBy': 'admin',
      });

      return null; // ✅ Éxito
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'Error al crear usuario: $e';
    }
  }

  // 🔒 VALIDAR SI EL USUARIO ACTUAL ES ADMIN (helper útil)
  bool isAdmin(String? email) {
    return email != null && admins.contains(email);
  }

  // 🚪 CERRAR SESIÓN
  Future<void> logout() async {
    await _auth.signOut();
  }

  // 👤 OBTENER USUARIO ACTUAL
  User? get currentUser => _auth.currentUser;

  // 📡 STREAM DE CAMBIOS DE AUTH
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // 🎯 OBTENER ROLE DESDE FIRESTORE
  Future<String?> getUserRole() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _db.collection('users').doc(user.uid).get();
    if (!doc.exists) return null;

    return doc.data()?['role'] as String?;
  }
}