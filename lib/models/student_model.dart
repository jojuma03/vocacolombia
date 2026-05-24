// 📁 lib/models/student_model.dart

class StudentModel {
  final String id;
  final String nombre;
  final int edad;
  final String grado;
  final String institucion;
  final String perfilVocacional;

  StudentModel({
    required this.id,
    required this.nombre,
    required this.edad,
    required this.grado,
    required this.institucion,
    required this.perfilVocacional,
  });

  // ======================================================
  // 🔥 DESDE FIREBASE
  // ======================================================

  factory StudentModel.fromMap(
      Map<String, dynamic> map,
      String id,
      ) {
    return StudentModel(
      id: id,
      nombre: map['nombre'] ?? '',
      edad: map['edad'] ?? 0,
      grado: map['grado'] ?? '',
      institucion: map['institucion'] ?? '',
      perfilVocacional:
      map['perfilVocacional'] ?? 'Sin definir',
    );
  }

  // ======================================================
  // 🔥 HACIA FIREBASE
  // ======================================================

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'edad': edad,
      'grado': grado,
      'institucion': institucion,
      'perfilVocacional': perfilVocacional,
    };
  }

  // ======================================================
  // 🔥 COPIAR Y ACTUALIZAR
  // ======================================================

  StudentModel copyWith({
    String? id,
    String? nombre,
    int? edad,
    String? grado,
    String? institucion,
    String? perfilVocacional,
  }) {
    return StudentModel(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      edad: edad ?? this.edad,
      grado: grado ?? this.grado,
      institucion:
      institucion ?? this.institucion,
      perfilVocacional:
      perfilVocacional ??
          this.perfilVocacional,
    );
  }
}