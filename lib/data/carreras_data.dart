// 📁 lib/data/carreras_data.dart
// Carreras colombianas clasificadas por código RIASEC + SNIES
// ✅ Autocontenido: sin dependencias externas de modelos

// ─────────────────────────────────────────────────────────────
// ✅ MODELO CARRERA (definido aquí para evitar errores de import)
// ─────────────────────────────────────────────────────────────
class Carrera {
  final String nombre;
  final String riasec; // Código Holland: 'R','I','A','S','E','C'
  final String areaSnies;
  final String nivel;
  final String modalidad;

  const Carrera({
    required this.nombre,
    required this.riasec,
    required this.areaSnies,
    required this.nivel,
    this.modalidad = 'Presencial',
  });

  String get nombrePerfil {
    const mapas = {
      'R': 'Realista', 'I': 'Investigador', 'A': 'Artístico',
      'S': 'Social', 'E': 'Emprendedor', 'C': 'Convencional',
    };
    return mapas[riasec] ?? riasec;
  }

  bool coincideCon(String codigo) {
    return riasec.toLowerCase() == codigo.toLowerCase();
  }
}

// ─────────────────────────────────────────────────────────────
// ✅ DATASET: 50 CARRERAS COLOMBIANAS EQUILIBRADAS POR RIASEC
// ─────────────────────────────────────────────────────────────
final List<Carrera> carrerasBase = [
  // 🔧 REALISTA (R)
  const Carrera(nombre: 'Tecnología en Mantenimiento de Aeronaves', riasec: 'R', areaSnies: 'Ingenierías', nivel: 'Tecnológico'),
  const Carrera(nombre: 'Técnico en Soldadura', riasec: 'R', areaSnies: 'Industrias', nivel: 'Técnico'),
  const Carrera(nombre: 'Ingeniería Agronómica', riasec: 'R', areaSnies: 'Ciencias Agrícolas', nivel: 'Profesional'),
  const Carrera(nombre: 'Tecnología en Topografía', riasec: 'R', areaSnies: 'Ingenierías', nivel: 'Tecnológico'),
  const Carrera(nombre: 'Ingeniería Mecánica', riasec: 'R', areaSnies: 'Ingenierías', nivel: 'Profesional'),
  const Carrera(nombre: 'Técnico en Electricidad Industrial', riasec: 'R', areaSnies: 'Industrias', nivel: 'Técnico'),
  const Carrera(nombre: 'Ingeniería de Minas', riasec: 'R', areaSnies: 'Ingenierías', nivel: 'Profesional'),
  const Carrera(nombre: 'Tecnología en Gestión de Redes', riasec: 'R', areaSnies: 'Tecnologías', nivel: 'Tecnológico'),
  const Carrera(nombre: 'Ingeniería Forestal', riasec: 'R', areaSnies: 'Ciencias Agrícolas', nivel: 'Profesional'),

  // 🔬 INVESTIGADOR (I)
  const Carrera(nombre: 'Ingeniería de Sistemas', riasec: 'I', areaSnies: 'Tecnologías de la Información', nivel: 'Profesional'),
  const Carrera(nombre: 'Medicina', riasec: 'I', areaSnies: 'Ciencias de la Salud', nivel: 'Profesional'),
  const Carrera(nombre: 'Biología', riasec: 'I', areaSnies: 'Ciencias Naturales', nivel: 'Profesional'),
  const Carrera(nombre: 'Ingeniería Biomédica', riasec: 'I', areaSnies: 'Ingenierías', nivel: 'Profesional'),
  const Carrera(nombre: 'Matemáticas', riasec: 'I', areaSnies: 'Ciencias Naturales', nivel: 'Profesional'),
  const Carrera(nombre: 'Química', riasec: 'I', areaSnies: 'Ciencias Naturales', nivel: 'Profesional'),
  const Carrera(nombre: 'Ingeniería Ambiental', riasec: 'I', areaSnies: 'Ingenierías', nivel: 'Profesional'),
  const Carrera(nombre: 'Microbiología', riasec: 'I', areaSnies: 'Ciencias de la Salud', nivel: 'Profesional'),
  const Carrera(nombre: 'Ingeniería Electrónica', riasec: 'I', areaSnies: 'Ingenierías', nivel: 'Profesional'),

  // 🎨 ARTÍSTICO (A)
  const Carrera(nombre: 'Diseño Gráfico', riasec: 'A', areaSnies: 'Artes', nivel: 'Profesional'),
  const Carrera(nombre: 'Música', riasec: 'A', areaSnies: 'Artes', nivel: 'Profesional'),
  const Carrera(nombre: 'Artes Plásticas', riasec: 'A', areaSnies: 'Artes', nivel: 'Profesional'),
  const Carrera(nombre: 'Diseño de Modas', riasec: 'A', areaSnies: 'Artes', nivel: 'Profesional'),
  const Carrera(nombre: 'Cine y Televisión', riasec: 'A', areaSnies: 'Artes', nivel: 'Profesional'),
  const Carrera(nombre: 'Diseño Industrial', riasec: 'A', areaSnies: 'Artes', nivel: 'Profesional'),
  const Carrera(nombre: 'Arquitectura', riasec: 'A', areaSnies: 'Arquitectura', nivel: 'Profesional'),
  const Carrera(nombre: 'Publicidad', riasec: 'A', areaSnies: 'Ciencias Administrativas', nivel: 'Profesional'),

  // 🤝 SOCIAL (S)
  const Carrera(nombre: 'Psicología', riasec: 'S', areaSnies: 'Ciencias Sociales', nivel: 'Profesional'),
  const Carrera(nombre: 'Enfermería', riasec: 'S', areaSnies: 'Ciencias de la Salud', nivel: 'Profesional'),
  const Carrera(nombre: 'Trabajo Social', riasec: 'S', areaSnies: 'Ciencias Sociales', nivel: 'Profesional'),
  const Carrera(nombre: 'Licenciatura en Educación', riasec: 'S', areaSnies: 'Educación', nivel: 'Profesional'),
  const Carrera(nombre: 'Terapia Ocupacional', riasec: 'S', areaSnies: 'Ciencias de la Salud', nivel: 'Profesional'),
  const Carrera(nombre: 'Fonoaudiología', riasec: 'S', areaSnies: 'Ciencias de la Salud', nivel: 'Profesional'),
  const Carrera(nombre: 'Nutrición y Dietética', riasec: 'S', areaSnies: 'Ciencias de la Salud', nivel: 'Profesional'),
  const Carrera(nombre: 'Pedagogía Infantil', riasec: 'S', areaSnies: 'Educación', nivel: 'Profesional'),

  // 💼 EMPRENDEDOR (E)
  const Carrera(nombre: 'Administración de Empresas', riasec: 'E', areaSnies: 'Ciencias Administrativas', nivel: 'Profesional'),
  const Carrera(nombre: 'Negocios Internacionales', riasec: 'E', areaSnies: 'Ciencias Administrativas', nivel: 'Profesional'),
  const Carrera(nombre: 'Marketing Digital', riasec: 'E', areaSnies: 'Ciencias Administrativas', nivel: 'Tecnológico'),
  const Carrera(nombre: 'Gestión Turística', riasec: 'E', areaSnies: 'Ciencias Administrativas', nivel: 'Tecnológico'),
  const Carrera(nombre: 'Comercio Exterior', riasec: 'E', areaSnies: 'Ciencias Administrativas', nivel: 'Profesional'),
  const Carrera(nombre: 'Relaciones Internacionales', riasec: 'E', areaSnies: 'Ciencias Políticas', nivel: 'Profesional'),
  const Carrera(nombre: 'Gestión Deportiva', riasec: 'E', areaSnies: 'Ciencias Administrativas', nivel: 'Tecnológico'),
  const Carrera(nombre: 'Emprendimiento', riasec: 'E', areaSnies: 'Ciencias Administrativas', nivel: 'Tecnológico'),

  // 📋 CONVENCIONAL (C)
  const Carrera(nombre: 'Contaduría Pública', riasec: 'C', areaSnies: 'Ciencias Administrativas', nivel: 'Profesional'),
  const Carrera(nombre: 'Tecnología en Gestión Administrativa', riasec: 'C', areaSnies: 'Ciencias Administrativas', nivel: 'Tecnológico'),
  const Carrera(nombre: 'Derecho', riasec: 'C', areaSnies: 'Ciencias Jurídicas', nivel: 'Profesional'),
  const Carrera(nombre: 'Tecnología en Gestión Documental', riasec: 'C', areaSnies: 'Ciencias Administrativas', nivel: 'Tecnológico'),
  const Carrera(nombre: 'Auditoría de Sistemas', riasec: 'C', areaSnies: 'Tecnologías', nivel: 'Tecnológico'),
  const Carrera(nombre: 'Secretariado Ejecutivo', riasec: 'C', areaSnies: 'Ciencias Administrativas', nivel: 'Técnico'),
  const Carrera(nombre: 'Gestión Logística', riasec: 'C', areaSnies: 'Ciencias Administrativas', nivel: 'Tecnológico'),
  const Carrera(nombre: 'Análisis Financiero', riasec: 'C', areaSnies: 'Ciencias Administrativas', nivel: 'Tecnológico'),
];

// ─────────────────────────────────────────────────────────────
// ✅ FUNCIONES AUXILIARES EXPORTABLES
// ─────────────────────────────────────────────────────────────

/// Filtra carreras por código RIASEC (case-insensitive)
List<Carrera> getCarrerasPorRiasec(String codigo) {
  return carrerasBase.where((c) => c.coincideCon(codigo)).toList();
}