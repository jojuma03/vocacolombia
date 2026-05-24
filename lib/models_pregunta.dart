// 📁 lib/models_pregunta.dart
// Modelo profesional de preguntas VocaColombia

class Pregunta {
  final String texto;

  // Perfil principal (compatibilidad hacia atrás)
  final String riasec;

  // Nuevo sistema híbrido
  final Map<String, double> riasecPesos;

  // Peso predictivo de la pregunta
  final double pesoVocacional;

  final List<String> opciones;

  const Pregunta({
    required this.texto,
    required this.riasec,
    Map<String, double>? riasecPesos,
    this.pesoVocacional = 1.0,
    this.opciones = const [],
  }) : riasecPesos = riasecPesos ??
      const {
        'R': 0,
        'I': 0,
        'A': 0,
        'S': 0,
        'E': 0,
        'C': 0,
      };

  String get nombrePerfil {
    const mapas = {
      'R': 'Realista',
      'I': 'Investigador',
      'A': 'Artístico',
      'S': 'Social',
      'E': 'Emprendedor',
      'C': 'Convencional',
    };

    return mapas[riasec] ?? riasec;
  }

  bool get esHibrida =>
      riasecPesos.values.where((v) => v > 0).length > 1;
}