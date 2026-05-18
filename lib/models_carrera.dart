// 📁 lib/models/carrera.dart
// Modelo de carrera profesional - VocaColombia

class Carrera {
  final String nombre;
  final String area; // ✅ Área RIASEC: 'R', 'I', 'A', 'S', 'E', 'C'
  final String descripcion;
  final String? duracion;
  final String? modalidad;

  const Carrera({
    required this.nombre,
    required this.area,
    this.descripcion = '',
    this.duracion,
    this.modalidad,
  });

  // Método helper para filtrar por área
  bool perteneceA(String areaBuscada) {
    return area.toLowerCase() == areaBuscada.toLowerCase();
  }
}