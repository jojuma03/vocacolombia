import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/riasec_result_model.dart';

class TestService {
  final FirebaseFirestore _db =
      FirebaseFirestore.instance;

  // ======================================================
  // 🔥 GUARDAR RESULTADO
  // ======================================================

  Future<void> saveResult(
      RiasecResultModel result,
      ) async {
    await _db
        .collection('riasec_results')
        .add(result.toMap());
  }

  // ======================================================
  // 🔥 OBTENER RESULTADOS
  // ======================================================

  Stream<List<RiasecResultModel>>
  getResults() {
    return _db
        .collection('riasec_results')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return RiasecResultModel.fromMap(
          doc.data(),
          doc.id,
        );
      }).toList();
    });
  }
}