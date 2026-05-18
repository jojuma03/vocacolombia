// 📁 lib/models/pregunta.dart
// Modelo de pregunta para el test vocacional RIASEC - VocaColombia

class Pregunta {
  final String texto;
  final String riasec; // ✅ Clave: 'R', 'I', 'A', 'S', 'E' o 'C'
  final List<String> opciones;

  const Pregunta({
    required this.texto,
    required this.riasec,
    this.opciones = const [],
  });

  // Método helper para obtener nombre legible del perfil
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
}