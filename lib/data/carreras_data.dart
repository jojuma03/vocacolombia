// 📁 lib/data/carreras_data.dart
// VocaColombia 2026
// Sistema profesional de carreras RIASEC + SNIES
// Compatible con Firebase + Flutter + PDF

// ─────────────────────────────────────────────
// ✅ MODELO PROFESIONAL DE CARRERA
// ─────────────────────────────────────────────

class Carrera {
  final String nombre;

  // Código RIASEC principal
  final String riasec;

  // Área académica SNIES
  final String areaSnies;

  // Técnico / Tecnológico / Profesional
  final String nivel;

  // Presencial / Virtual / Híbrida
  final String modalidad;

  // Descripción corta
  final String descripcion;

  // Habilidades relacionadas
  final List<String> habilidades;

  // Inteligencias múltiples
  final List<String> inteligencias;

  // Campos laborales
  final List<String> camposLaborales;

  // Nivel de demanda laboral
  final String demanda;

  const Carrera({
    required this.nombre,
    required this.riasec,
    required this.areaSnies,
    required this.nivel,
    required this.descripcion,
    required this.habilidades,
    required this.inteligencias,
    required this.camposLaborales,
    required this.demanda,
    this.modalidad = 'Presencial',
  });

  String get nombrePerfil {
    const perfiles = {
      'R': 'Realista',
      'I': 'Investigador',
      'A': 'Artístico',
      'S': 'Social',
      'E': 'Emprendedor',
      'C': 'Convencional',
    };

    return perfiles[riasec] ?? riasec;
  }

  bool coincideCon(String codigo) {
    return riasec.toUpperCase() == codigo.toUpperCase();
  }
}

// ─────────────────────────────────────────────
// ✅ BASE PROFESIONAL DE CARRERAS
// ─────────────────────────────────────────────

final List<Carrera> carrerasBase = [

  // ═══════════════════════════════════════════
  // 🔧 REALISTA (R)
  // ═══════════════════════════════════════════

  const Carrera(
    nombre: 'Ingeniería Mecánica',
    riasec: 'R',
    areaSnies: 'Ingenierías',
    nivel: 'Profesional',
    descripcion:
    'Carrera enfocada en diseño, fabricación y mantenimiento de sistemas mecánicos.',
    habilidades: [
      'Resolución de problemas',
      'Pensamiento técnico',
      'Manejo de herramientas',
    ],
    inteligencias: [
      'Lógico-Matemática',
      'Espacial',
      'Corporal',
    ],
    camposLaborales: [
      'Industria',
      'Automotriz',
      'Manufactura',
    ],
    demanda: 'Alta',
  ),

  const Carrera(
    nombre: 'Ingeniería Civil',
    riasec: 'R',
    areaSnies: 'Ingenierías',
    nivel: 'Profesional',
    descripcion:
    'Diseño y construcción de infraestructura y obras civiles.',
    habilidades: [
      'Cálculo',
      'Planificación',
      'Diseño estructural',
    ],
    inteligencias: [
      'Espacial',
      'Lógico-Matemática',
    ],
    camposLaborales: [
      'Construcción',
      'Infraestructura',
      'Consultoría',
    ],
    demanda: 'Alta',
  ),

  const Carrera(
    nombre: 'Ingeniería Agronómica',
    riasec: 'R',
    areaSnies: 'Ciencias Agrícolas',
    nivel: 'Profesional',
    descripcion:
    'Gestión y optimización de procesos agrícolas y producción sostenible.',
    habilidades: [
      'Trabajo de campo',
      'Observación',
      'Análisis ambiental',
    ],
    inteligencias: [
      'Naturalista',
      'Lógico-Matemática',
    ],
    camposLaborales: [
      'Agricultura',
      'Producción rural',
      'Agroindustria',
    ],
    demanda: 'Alta',
  ),

  const Carrera(
    nombre: 'Tecnología en Redes',
    riasec: 'R',
    areaSnies: 'Tecnologías',
    nivel: 'Tecnológico',
    descripcion:
    'Instalación y mantenimiento de redes informáticas y telecomunicaciones.',
    habilidades: [
      'Soporte técnico',
      'Diagnóstico',
      'Configuración',
    ],
    inteligencias: [
      'Lógico-Matemática',
      'Espacial',
    ],
    camposLaborales: [
      'Telecomunicaciones',
      'Soporte TI',
      'Infraestructura',
    ],
    demanda: 'Alta',
  ),

  // ═══════════════════════════════════════════
  // 🔬 INVESTIGADOR (I)
  // ═══════════════════════════════════════════

  const Carrera(
    nombre: 'Ingeniería de Sistemas',
    riasec: 'I',
    areaSnies: 'Tecnologías de la Información',
    nivel: 'Profesional',
    descripcion:
    'Desarrollo de software, sistemas inteligentes y soluciones digitales.',
    habilidades: [
      'Programación',
      'Análisis lógico',
      'Resolución de problemas',
    ],
    inteligencias: [
      'Lógico-Matemática',
      'Tecnológica',
    ],
    camposLaborales: [
      'Software',
      'IA',
      'Ciberseguridad',
    ],
    demanda: 'Muy Alta',
  ),

  const Carrera(
    nombre: 'Medicina',
    riasec: 'I',
    areaSnies: 'Ciencias de la Salud',
    nivel: 'Profesional',
    descripcion:
    'Diagnóstico, tratamiento y prevención de enfermedades.',
    habilidades: [
      'Análisis',
      'Empatía',
      'Investigación',
    ],
    inteligencias: [
      'Lógico-Matemática',
      'Interpersonal',
    ],
    camposLaborales: [
      'Hospitales',
      'Investigación',
      'Clínicas',
    ],
    demanda: 'Muy Alta',
  ),

  const Carrera(
    nombre: 'Biología',
    riasec: 'I',
    areaSnies: 'Ciencias Naturales',
    nivel: 'Profesional',
    descripcion:
    'Estudio de los seres vivos y ecosistemas.',
    habilidades: [
      'Observación',
      'Investigación',
      'Análisis científico',
    ],
    inteligencias: [
      'Naturalista',
      'Lógico-Matemática',
    ],
    camposLaborales: [
      'Laboratorios',
      'Investigación',
      'Ambiente',
    ],
    demanda: 'Media',
  ),

  const Carrera(
    nombre: 'Ingeniería Biomédica',
    riasec: 'I',
    areaSnies: 'Ingenierías',
    nivel: 'Profesional',
    descripcion:
    'Integración de tecnología e ingeniería aplicada a la salud.',
    habilidades: [
      'Investigación',
      'Tecnología',
      'Innovación',
    ],
    inteligencias: [
      'Lógico-Matemática',
      'Espacial',
    ],
    camposLaborales: [
      'Hospitales',
      'Equipos médicos',
      'Innovación',
    ],
    demanda: 'Alta',
  ),

  // ═══════════════════════════════════════════
  // 🎨 ARTÍSTICO (A)
  // ═══════════════════════════════════════════

  const Carrera(
    nombre: 'Diseño Gráfico',
    riasec: 'A',
    areaSnies: 'Artes',
    nivel: 'Profesional',
    descripcion:
    'Creación visual y comunicación gráfica para medios digitales e impresos.',
    habilidades: [
      'Creatividad',
      'Diseño visual',
      'Comunicación',
    ],
    inteligencias: [
      'Espacial',
      'Visual',
    ],
    camposLaborales: [
      'Publicidad',
      'Branding',
      'Marketing',
    ],
    demanda: 'Alta',
  ),

  const Carrera(
    nombre: 'Arquitectura',
    riasec: 'A',
    areaSnies: 'Arquitectura',
    nivel: 'Profesional',
    descripcion:
    'Diseño de espacios arquitectónicos funcionales y creativos.',
    habilidades: [
      'Diseño',
      'Creatividad',
      'Visualización espacial',
    ],
    inteligencias: [
      'Espacial',
      'Creativa',
    ],
    camposLaborales: [
      'Construcción',
      'Urbanismo',
      'Diseño',
    ],
    demanda: 'Alta',
  ),

  const Carrera(
    nombre: 'Música',
    riasec: 'A',
    areaSnies: 'Artes',
    nivel: 'Profesional',
    descripcion:
    'Interpretación, composición y producción musical.',
    habilidades: [
      'Expresión artística',
      'Creatividad',
      'Escucha',
    ],
    inteligencias: [
      'Musical',
      'Creativa',
    ],
    camposLaborales: [
      'Producción musical',
      'Docencia',
      'Eventos',
    ],
    demanda: 'Media',
  ),

  const Carrera(
    nombre: 'Cine y Televisión',
    riasec: 'A',
    areaSnies: 'Artes',
    nivel: 'Profesional',
    descripcion:
    'Producción audiovisual, narrativa visual y contenidos digitales.',
    habilidades: [
      'Narrativa',
      'Creatividad',
      'Comunicación',
    ],
    inteligencias: [
      'Visual',
      'Lingüística',
    ],
    camposLaborales: [
      'Producción audiovisual',
      'Streaming',
      'Publicidad',
    ],
    demanda: 'Alta',
  ),

  // ═══════════════════════════════════════════
  // 🤝 SOCIAL (S)
  // ═══════════════════════════════════════════

  const Carrera(
    nombre: 'Psicología',
    riasec: 'S',
    areaSnies: 'Ciencias Sociales',
    nivel: 'Profesional',
    descripcion:
    'Comprensión y acompañamiento del comportamiento humano.',
    habilidades: [
      'Empatía',
      'Escucha activa',
      'Comunicación',
    ],
    inteligencias: [
      'Interpersonal',
      'Intrapersonal',
    ],
    camposLaborales: [
      'Clínica',
      'Educación',
      'Organizaciones',
    ],
    demanda: 'Alta',
  ),

  const Carrera(
    nombre: 'Enfermería',
    riasec: 'S',
    areaSnies: 'Ciencias de la Salud',
    nivel: 'Profesional',
    descripcion:
    'Atención integral y cuidado de pacientes.',
    habilidades: [
      'Servicio',
      'Empatía',
      'Trabajo bajo presión',
    ],
    inteligencias: [
      'Interpersonal',
      'Corporal',
    ],
    camposLaborales: [
      'Hospitales',
      'Clínicas',
      'Salud pública',
    ],
    demanda: 'Muy Alta',
  ),

  const Carrera(
    nombre: 'Trabajo Social',
    riasec: 'S',
    areaSnies: 'Ciencias Sociales',
    nivel: 'Profesional',
    descripcion:
    'Intervención social y fortalecimiento comunitario.',
    habilidades: [
      'Comunicación',
      'Empatía',
      'Liderazgo social',
    ],
    inteligencias: [
      'Interpersonal',
      'Lingüística',
    ],
    camposLaborales: [
      'Comunidades',
      'Fundaciones',
      'ONG',
    ],
    demanda: 'Alta',
  ),

  const Carrera(
    nombre: 'Licenciatura en Educación',
    riasec: 'S',
    areaSnies: 'Educación',
    nivel: 'Profesional',
    descripcion:
    'Formación y acompañamiento pedagógico de estudiantes.',
    habilidades: [
      'Enseñanza',
      'Comunicación',
      'Paciencia',
    ],
    inteligencias: [
      'Lingüística',
      'Interpersonal',
    ],
    camposLaborales: [
      'Colegios',
      'Universidades',
      'Educación virtual',
    ],
    demanda: 'Alta',
  ),

  // ═══════════════════════════════════════════
  // 💼 EMPRENDEDOR (E)
  // ═══════════════════════════════════════════

  const Carrera(
    nombre: 'Administración de Empresas',
    riasec: 'E',
    areaSnies: 'Ciencias Administrativas',
    nivel: 'Profesional',
    descripcion:
    'Gestión estratégica de organizaciones y negocios.',
    habilidades: [
      'Liderazgo',
      'Negociación',
      'Gestión',
    ],
    inteligencias: [
      'Interpersonal',
      'Lógico-Matemática',
    ],
    camposLaborales: [
      'Empresas',
      'Gerencia',
      'Consultoría',
    ],
    demanda: 'Muy Alta',
  ),

  const Carrera(
    nombre: 'Negocios Internacionales',
    riasec: 'E',
    areaSnies: 'Ciencias Administrativas',
    nivel: 'Profesional',
    descripcion:
    'Gestión comercial y económica en mercados globales.',
    habilidades: [
      'Negociación',
      'Comunicación',
      'Estrategia',
    ],
    inteligencias: [
      'Lingüística',
      'Interpersonal',
    ],
    camposLaborales: [
      'Importaciones',
      'Exportaciones',
      'Comercio global',
    ],
    demanda: 'Alta',
  ),

  const Carrera(
    nombre: 'Marketing Digital',
    riasec: 'E',
    areaSnies: 'Ciencias Administrativas',
    nivel: 'Tecnológico',
    descripcion:
    'Creación de estrategias digitales y posicionamiento de marcas.',
    habilidades: [
      'Ventas',
      'Comunicación',
      'Creatividad',
    ],
    inteligencias: [
      'Lingüística',
      'Creativa',
    ],
    camposLaborales: [
      'Publicidad',
      'Redes sociales',
      'Marketing',
    ],
    demanda: 'Muy Alta',
  ),

  const Carrera(
    nombre: 'Relaciones Internacionales',
    riasec: 'E',
    areaSnies: 'Ciencias Políticas',
    nivel: 'Profesional',
    descripcion:
    'Gestión diplomática y cooperación internacional.',
    habilidades: [
      'Comunicación',
      'Negociación',
      'Liderazgo',
    ],
    inteligencias: [
      'Lingüística',
      'Interpersonal',
    ],
    camposLaborales: [
      'Diplomacia',
      'Gobierno',
      'ONG',
    ],
    demanda: 'Media',
  ),

  // ═══════════════════════════════════════════
  // 📋 CONVENCIONAL (C)
  // ═══════════════════════════════════════════

  const Carrera(
    nombre: 'Contaduría Pública',
    riasec: 'C',
    areaSnies: 'Ciencias Administrativas',
    nivel: 'Profesional',
    descripcion:
    'Gestión financiera, tributaria y contable de organizaciones.',
    habilidades: [
      'Precisión',
      'Análisis numérico',
      'Organización',
    ],
    inteligencias: [
      'Lógico-Matemática',
      'Organizacional',
    ],
    camposLaborales: [
      'Finanzas',
      'Auditoría',
      'Empresas',
    ],
    demanda: 'Alta',
  ),

  const Carrera(
    nombre: 'Derecho',
    riasec: 'C',
    areaSnies: 'Ciencias Jurídicas',
    nivel: 'Profesional',
    descripcion:
    'Interpretación y aplicación de normas jurídicas.',
    habilidades: [
      'Argumentación',
      'Lectura crítica',
      'Análisis',
    ],
    inteligencias: [
      'Lingüística',
      'Lógico-Matemática',
    ],
    camposLaborales: [
      'Juzgados',
      'Empresas',
      'Litigio',
    ],
    demanda: 'Alta',
  ),

  const Carrera(
    nombre: 'Gestión Logística',
    riasec: 'C',
    areaSnies: 'Ciencias Administrativas',
    nivel: 'Tecnológico',
    descripcion:
    'Coordinación de inventarios, transporte y operaciones.',
    habilidades: [
      'Planificación',
      'Organización',
      'Control',
    ],
    inteligencias: [
      'Lógico-Matemática',
      'Organizacional',
    ],
    camposLaborales: [
      'Operaciones',
      'Distribución',
      'Logística',
    ],
    demanda: 'Alta',
  ),

  const Carrera(
    nombre: 'Gestión Documental',
    riasec: 'C',
    areaSnies: 'Ciencias Administrativas',
    nivel: 'Tecnológico',
    descripcion:
    'Administración y control de archivos e información.',
    habilidades: [
      'Orden',
      'Precisión',
      'Clasificación',
    ],
    inteligencias: [
      'Organizacional',
      'Lingüística',
    ],
    camposLaborales: [
      'Archivos',
      'Empresas',
      'Instituciones',
    ],
    demanda: 'Media',
  ),
];

// ─────────────────────────────────────────────
// ✅ FUNCIONES AUXILIARES
// ─────────────────────────────────────────────

List<Carrera> getCarrerasPorRiasec(String codigo) {
  return carrerasBase
      .where((c) => c.coincideCon(codigo))
      .toList();
}

List<Carrera> getTopCarreras(String codigo, {int limite = 5}) {
  return carrerasBase
      .where((c) => c.coincideCon(codigo))
      .take(limite)
      .toList();
}