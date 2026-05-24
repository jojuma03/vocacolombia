import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ======================================================
  // 🔥 TOTAL RESULTADOS
  // ======================================================
  Future<int> totalResultados() async {
    try {
      final snapshot = await _db.collection('registros').get();
      return snapshot.docs.length;
    } catch (_) {
      return 0;
    }
  }

  // ======================================================
  // 🔥 TOTAL ESTUDIANTES
  // ======================================================
  Future<int> totalEstudiantes() async {
    try {
      final snapshot = await _db.collection('students').get();
      return snapshot.docs.length;
    } catch (_) {
      return 0;
    }
  }

  // ======================================================
  // 🔥 PERFIL MÁS COMÚN
  // ======================================================
  Future<String> perfilMasComun() async {
    try {
      final snapshot = await _db.collection('registros').get();

      if (snapshot.docs.isEmpty) {
        return 'Sin datos';
      }

      final Map<String, int> contador = {};

      for (final doc in snapshot.docs) {
        final data = doc.data();

        final resultados = data['resultados'];

        if (resultados is! Map) continue;

        final perfil = resultados['perfil'];

        if (perfil == null) continue;

        final String perfilStr = perfil.toString();

        contador[perfilStr] = (contador[perfilStr] ?? 0) + 1;
      }

      if (contador.isEmpty) {
        return 'Sin datos';
      }

      String ganador = '';
      int mayor = 0;

      contador.forEach((perfil, cantidad) {
        if (cantidad > mayor) {
          mayor = cantidad;
          ganador = perfil;
        }
      });

      return ganador.isEmpty ? 'Sin datos' : ganador;

    } catch (_) {
      return 'Error';
    }
  }
}