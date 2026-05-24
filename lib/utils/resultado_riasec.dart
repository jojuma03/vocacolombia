// 📁 lib/utils/resultado_riasec.dart
// Motor inteligente de interpretación vocacional VocaColombia
// Basado en Holland RIASEC + Inteligencias Múltiples

class ResultadoRIASEC {
  final String codigoPrincipal;
  final String codigoSecundario;

  final String perfil;
  final String descripcion;
  final String fortalezas;
  final String recomendaciones;
  final String inteligenciasMultiples;
  final String estiloAprendizaje;
  final String posiblesRiesgos;
  final List<String> carrerasSugeridas;

  ResultadoRIASEC({
    required this.codigoPrincipal,
    required this.codigoSecundario,
    required this.perfil,
    required this.descripcion,
    required this.fortalezas,
    required this.recomendaciones,
    required this.inteligenciasMultiples,
    required this.estiloAprendizaje,
    required this.posiblesRiesgos,
    required this.carrerasSugeridas,
  });
}

// ─────────────────────────────────────────────
// ✅ GENERADOR PRINCIPAL DE RESULTADOS
// ─────────────────────────────────────────────

ResultadoRIASEC generarResultadoVocacional({
  required String principal,
  required String secundario,
}) {
  final codigo = principal.toUpperCase();

  switch (codigo) {

  // 🔧 REALISTA
    case 'R':
      return ResultadoRIASEC(
        codigoPrincipal: principal,
        codigoSecundario: secundario,
        perfil: 'Perfil Realista',
        descripcion:
        'Eres una persona práctica, dinámica y orientada a la acción. Disfrutas trabajar con herramientas, tecnología, maquinaria o actividades concretas donde puedas observar resultados tangibles.',

        fortalezas:
        'Capacidad técnica, pensamiento práctico, disciplina, trabajo físico y resolución concreta de problemas.',

        recomendaciones:
        'Busca espacios donde puedas aprender haciendo. Las carreras técnicas, ingenierías y tecnologías pueden darte grandes oportunidades de crecimiento.',

        inteligenciasMultiples:
        'Predomina la inteligencia lógico-matemática, espacial y corporal-kinestésica.',

        estiloAprendizaje:
        'Aprendes mejor mediante experiencias prácticas, demostraciones y trabajo aplicado.',

        posiblesRiesgos:
        'Podrías aburrirte en ambientes demasiado teóricos o repetitivos.',

        carrerasSugeridas: [
          'Ingeniería Mecánica',
          'Ingeniería Civil',
          'Ingeniería Electrónica',
          'Mantenimiento Industrial',
          'Topografía',
          'Automatización',
          'Energías Renovables',
          'Logística Industrial',
        ],
      );

  // 🔬 INVESTIGADOR
    case 'I':
      return ResultadoRIASEC(
        codigoPrincipal: principal,
        codigoSecundario: secundario,
        perfil: 'Perfil Investigador',
        descripcion:
        'Eres una persona curiosa, analítica y orientada al conocimiento. Te gusta comprender cómo funcionan las cosas y resolver problemas complejos.',

        fortalezas:
        'Pensamiento crítico, análisis profundo, curiosidad científica y capacidad investigativa.',

        recomendaciones:
        'Explora áreas científicas, tecnológicas o médicas donde puedas investigar, innovar y desarrollar conocimiento.',

        inteligenciasMultiples:
        'Predomina la inteligencia lógico-matemática e intrapersonal.',

        estiloAprendizaje:
        'Aprendes mejor investigando, analizando y comprendiendo conceptos profundos.',

        posiblesRiesgos:
        'Podrías frustrarte en ambientes muy desorganizados o con poca profundidad intelectual.',

        carrerasSugeridas: [
          'Medicina',
          'Ingeniería de Sistemas',
          'Biología',
          'Matemáticas',
          'Química',
          'Ciberseguridad',
          'Investigación Científica',
          'Ingeniería Biomédica',
        ],
      );

  // 🎨 ARTÍSTICO
    case 'A':
      return ResultadoRIASEC(
        codigoPrincipal: principal,
        codigoSecundario: secundario,
        perfil: 'Perfil Artístico',
        descripcion:
        'Eres creativo, expresivo y sensible a la estética. Te gusta comunicar ideas mediante el arte, el diseño o la creatividad.',

        fortalezas:
        'Creatividad, imaginación, sensibilidad estética y pensamiento innovador.',

        recomendaciones:
        'Busca espacios donde puedas expresarte libremente y desarrollar proyectos creativos.',

        inteligenciasMultiples:
        'Predomina la inteligencia visual-espacial, musical y lingüística.',

        estiloAprendizaje:
        'Aprendes mejor creando, diseñando y explorando nuevas ideas.',

        posiblesRiesgos:
        'Podrías sentir limitación en ambientes excesivamente rígidos o normativos.',

        carrerasSugeridas: [
          'Diseño Gráfico',
          'Arquitectura',
          'Publicidad',
          'Música',
          'Diseño de Modas',
          'Producción Audiovisual',
          'Artes Plásticas',
          'Animación Digital',
        ],
      );

  // 🤝 SOCIAL
    case 'S':
      return ResultadoRIASEC(
        codigoPrincipal: principal,
        codigoSecundario: secundario,
        perfil: 'Perfil Social',
        descripcion:
        'Te motiva ayudar, acompañar y orientar a otras personas. Eres empático y disfrutas trabajar en equipo.',

        fortalezas:
        'Empatía, comunicación, escucha activa y trabajo colaborativo.',

        recomendaciones:
        'Explora profesiones orientadas al servicio, educación, salud o acompañamiento humano.',

        inteligenciasMultiples:
        'Predomina la inteligencia interpersonal y lingüística.',

        estiloAprendizaje:
        'Aprendes mejor interactuando, dialogando y trabajando con otras personas.',

        posiblesRiesgos:
        'Podrías agotarte emocionalmente si no estableces límites saludables.',

        carrerasSugeridas: [
          'Psicología',
          'Trabajo Social',
          'Enfermería',
          'Licenciatura',
          'Pedagogía Infantil',
          'Fonoaudiología',
          'Terapia Ocupacional',
          'Orientación Escolar',
        ],
      );

  // 💼 EMPRENDEDOR
    case 'E':
      return ResultadoRIASEC(
        codigoPrincipal: principal,
        codigoSecundario: secundario,
        perfil: 'Perfil Emprendedor',
        descripcion:
        'Eres una persona líder, dinámica y orientada a metas. Disfrutas persuadir, dirigir proyectos y generar oportunidades.',

        fortalezas:
        'Liderazgo, comunicación, iniciativa y visión estratégica.',

        recomendaciones:
        'Busca espacios donde puedas liderar, emprender y desarrollar proyectos innovadores.',

        inteligenciasMultiples:
        'Predomina la inteligencia interpersonal y estratégica.',

        estiloAprendizaje:
        'Aprendes mejor liderando proyectos y enfrentando retos reales.',

        posiblesRiesgos:
        'Podrías frustrarte en ambientes muy limitantes o con poca autonomía.',

        carrerasSugeridas: [
          'Administración de Empresas',
          'Marketing',
          'Negocios Internacionales',
          'Emprendimiento',
          'Gestión Comercial',
          'Relaciones Internacionales',
          'Turismo',
          'Comercio Exterior',
        ],
      );

  // 📋 CONVENCIONAL
    case 'C':
      return ResultadoRIASEC(
        codigoPrincipal: principal,
        codigoSecundario: secundario,
        perfil: 'Perfil Convencional',
        descripcion:
        'Eres organizado, metódico y responsable. Prefieres trabajar con estructuras claras y procedimientos definidos.',

        fortalezas:
        'Organización, precisión, disciplina y atención al detalle.',

        recomendaciones:
        'Explora áreas administrativas, financieras o legales donde puedas aplicar orden y análisis.',

        inteligenciasMultiples:
        'Predomina la inteligencia lógico-matemática y organizacional.',

        estiloAprendizaje:
        'Aprendes mejor siguiendo procesos estructurados y planificados.',

        posiblesRiesgos:
        'Podrías sentir incomodidad en ambientes demasiado impredecibles o caóticos.',

        carrerasSugeridas: [
          'Contaduría',
          'Derecho',
          'Gestión Administrativa',
          'Auditoría',
          'Finanzas',
          'Logística',
          'Gestión Documental',
          'Administración Pública',
        ],
      );

  // ⚠️ DEFAULT
    default:
      return ResultadoRIASEC(
        codigoPrincipal: principal,
        codigoSecundario: secundario,
        perfil: 'Perfil General',
        descripcion: 'Perfil vocacional en construcción.',
        fortalezas: 'Fortalezas por definir.',
        recomendaciones: 'Continúa explorando tus intereses.',
        inteligenciasMultiples: 'Pendiente.',
        estiloAprendizaje: 'Pendiente.',
        posiblesRiesgos: 'Pendiente.',
        carrerasSugeridas: [],
      );
  }
}