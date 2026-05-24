// 📁 lib/models/institution_model.dart
// Modelo de datos para instituciones en VocaColombia

class InstitutionModel {
  final String id;
  final String nombre;
  final String ciudad;
  final String direccion;
  final int numeroEstudiantes;

  InstitutionModel({
    required this.id,
    required this.nombre,
    required this.ciudad,
    required this.direccion,
    required this.numeroEstudiantes,
  });

  // 🔥 Convertir desde Firebase / Map
  factory InstitutionModel.fromMap(Map<String, dynamic> map, String id) {
    return InstitutionModel(
      id: id,
      nombre: map['nombre'] ?? '',
      ciudad: map['ciudad'] ?? '',
      direccion: map['direccion'] ?? '',
      numeroEstudiantes: map['numeroEstudiantes'] ?? 0,
    );
  }

  // 🔥 Convertir a Map (para guardar en Firebase)
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'ciudad': ciudad,
      'direccion': direccion,
      'numeroEstudiantes': numeroEstudiantes,
    };
  }
}