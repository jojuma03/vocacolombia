// 📁 lib/services/firestore_service.dart
// Servicio de Firestore para VocaColombia

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/institution_model.dart';
import '../models/student_model.dart';

class FirestoreService {
  final FirebaseFirestore _db =
      FirebaseFirestore.instance;

  // ======================================================
  // 👨‍🎓 ESTUDIANTES
  // ======================================================

  Future<void> addStudent(
      StudentModel student,
      ) async {
    await _db
        .collection('students')
        .add(student.toMap());
  }

  Stream<List<StudentModel>> getStudents() {
    return _db
        .collection('students')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return StudentModel.fromMap(
          doc.data(),
          doc.id,
        );
      }).toList();
    });
  }

  Future<void> deleteStudent(String id) async {
    await _db
        .collection('students')
        .doc(id)
        .delete();
  }

  // ======================================================
  // 🔥 ACTUALIZAR PERFIL VOCACIONAL
  // ======================================================

  Future<void> updateStudentProfile(
      String id,
      String perfil,
      ) async {
    await _db
        .collection('students')
        .doc(id)
        .update({
      'perfilVocacional': perfil,
    });
  }

  // ======================================================
  // 🏫 INSTITUCIONES
  // ======================================================

  Future<void> addInstitution(
      InstitutionModel institution,
      ) async {
    await _db
        .collection('institutions')
        .add(institution.toMap());
  }

  Stream<List<InstitutionModel>>
  getInstitutions() {
    return _db
        .collection('institutions')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return InstitutionModel.fromMap(
          doc.data(),
          doc.id,
        );
      }).toList();
    });
  }

  Future<void> deleteInstitution(
      String id,
      ) async {
    await _db
        .collection('institutions')
        .doc(id)
        .delete();
  }
}