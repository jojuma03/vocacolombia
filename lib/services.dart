// 📁 lib/services.dart
// Servicio de persistencia para VocaColombia
// ✅ Firebase Firestore activado

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Guarda el registro del estudiante y sus resultados en Firestore
  Future<bool> guardarRegistro({
    required Map<String, String> datosPersonales,
    required Map<String, dynamic> resultados,
  }) async {
    try {
      await _db.collection('estudiantes').add({
        'datos_personales': datosPersonales,
        'resultados': resultados,
        'fecha_registro': FieldValue.serverTimestamp(),
        'version_app': '1.0.0',
      });

      print('✅ Registro guardado en Firestore');
      return true;
    } catch (e) {
      print('❌ Error al guardar en Firestore: $e');
      return false;
    }
  }

  /// Obtiene todos los registros para estadísticas
  Future<List<Map<String, dynamic>>> obtenerRegistros() async {
    try {
      final snapshot = await _db
          .collection('estudiantes')
          .orderBy('fecha_registro', descending: false)
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('❌ Error al leer registros: $e');
      return [];
    }
  }
}
