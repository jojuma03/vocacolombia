// 📁 lib/models/riasec_result_model.dart
// Resultado del test vocacional RIASEC

class RiasecResultModel {
  final String id;
  final String studentName;
  final int realista;
  final int investigador;
  final int artistico;
  final int social;
  final int emprendedor;
  final int convencional;

  RiasecResultModel({
    required this.id,
    required this.studentName,
    required this.realista,
    required this.investigador,
    required this.artistico,
    required this.social,
    required this.emprendedor,
    required this.convencional,
  });

  Map<String, dynamic> toMap() {
    return {
      'studentName': studentName,
      'realista': realista,
      'investigador': investigador,
      'artistico': artistico,
      'social': social,
      'emprendedor': emprendedor,
      'convencional': convencional,
    };
  }

  factory RiasecResultModel.fromMap(Map<String, dynamic> map, String id) {
    return RiasecResultModel(
      id: id,
      studentName: map['studentName'] ?? '',
      realista: map['realista'] ?? 0,
      investigador: map['investigador'] ?? 0,
      artistico: map['artistico'] ?? 0,
      social: map['social'] ?? 0,
      emprendedor: map['emprendedor'] ?? 0,
      convencional: map['convencional'] ?? 0,
    );
  }
}