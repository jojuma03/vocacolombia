// 📁 lib/data/preguntas_data.dart
// Banco de preguntas RIASEC - VocaColombia
// ✅ Autocontenido: sin dependencias externas de modelos

// ─────────────────────────────────────────────────────────────
// ✅ MODELO PREGUNTA (definido aquí para evitar errores de import)
// ─────────────────────────────────────────────────────────────
class Pregunta {
  final String texto;
  final String riasec; // 'R', 'I', 'A', 'S', 'E', 'C'

  const Pregunta({
    required this.texto,
    required this.riasec,
  });
}

// ─────────────────────────────────────────────────────────────
// ✅ BANCO DE 100 PREGUNTAS EQUILIBRADAS POR DIMENSIÓN RIASEC
// ─────────────────────────────────────────────────────────────
final List<Pregunta> preguntasBase = [
  // 🔧 REALISTA (R) - 17 preguntas
  const Pregunta(texto: '¿Disfrutas armar o reparar computadoras y aparatos?', riasec: 'R'),
  const Pregunta(texto: '¿Te gusta trabajar con herramientas manuales o eléctricas?', riasec: 'R'),
  const Pregunta(texto: '¿Prefieres actividades al aire libre o en entornos naturales?', riasec: 'R'),
  const Pregunta(texto: '¿Te interesa la mecánica de vehículos o maquinaria pesada?', riasec: 'R'),
  const Pregunta(texto: '¿Disfrutas construyendo cosas con tus manos (madera, metal, etc.)?', riasec: 'R'),
  const Pregunta(texto: '¿Te gustaría trabajar en agricultura, ganadería o recursos naturales?', riasec: 'R'),
  const Pregunta(texto: '¿Te atrae la ingeniería civil o la construcción de infraestructuras?', riasec: 'R'),
  const Pregunta(texto: '¿Te interesa la instrumentación quirúrgica o equipos médicos?', riasec: 'R'),
  const Pregunta(texto: '¿Te gusta la física aplicada y entender cómo funcionan las máquinas?', riasec: 'R'),
  const Pregunta(texto: '¿Te ves trabajando en mantenimiento industrial o técnico?', riasec: 'R'),
  const Pregunta(texto: '¿Te interesa la automatización de procesos con robots o PLCs?', riasec: 'R'),
  const Pregunta(texto: '¿Te gustaría especializarte en energías renovables o instalaciones?', riasec: 'R'),
  const Pregunta(texto: '¿Disfrutas leyendo manuales técnicos o diagramas de instalación?', riasec: 'R'),
  const Pregunta(texto: '¿Te atrae la ingeniería aeroespacial o la mecánica de vuelo?', riasec: 'R'),
  const Pregunta(texto: '¿Te interesa la topografía, cartografía o trabajos de campo?', riasec: 'R'),
  const Pregunta(texto: '¿Te gustaría trabajar en seguridad industrial o prevención de riesgos?', riasec: 'R'),
  const Pregunta(texto: '¿Prefieres soluciones concretas y prácticas antes que teorías abstractas?', riasec: 'R'),

  // 🔬 INVESTIGADOR (I) - 17 preguntas
  const Pregunta(texto: '¿Te gusta resolver acertijos lógicos o problemas matemáticos complejos?', riasec: 'I'),
  const Pregunta(texto: '¿Te interesa saber cómo funcionan las aplicaciones y sistemas por dentro?', riasec: 'I'),
  const Pregunta(texto: '¿Pasas tiempo investigando sobre ciencia, tecnología o descubrimientos?', riasec: 'I'),
  const Pregunta(texto: '¿Te gustaría aprender a programar software, algoritmos o inteligencia artificial?', riasec: 'I'),
  const Pregunta(texto: '¿Disfrutas analizando por qué las cosas fallan y cómo mejorarlas?', riasec: 'I'),
  const Pregunta(texto: '¿Te interesa la seguridad informática, criptografía o ciberseguridad?', riasec: 'I'),
  const Pregunta(texto: '¿Te atrae la investigación científica en laboratorios o universidades?', riasec: 'I'),
  const Pregunta(texto: '¿Te gustaría trabajar en biotecnología, genética o ciencias biomédicas?', riasec: 'I'),
  const Pregunta(texto: '¿Te interesa la astronomía, física teórica o ciencias del universo?', riasec: 'I'),
  const Pregunta(texto: '¿Disfrutas estudiando anatomía, fisiología o procesos biológicos?', riasec: 'I'),
  const Pregunta(texto: '¿Te interesa la farmacología y el mecanismo de acción de los medicamentos?', riasec: 'I'),
  const Pregunta(texto: '¿Te gustaría investigar curas para enfermedades o nuevos tratamientos?', riasec: 'I'),
  const Pregunta(texto: '¿Te atrae la sociología, antropología o investigación del comportamiento?', riasec: 'I'),
  const Pregunta(texto: '¿Te interesa la filosofía, epistemología o las grandes preguntas del conocimiento?', riasec: 'I'),
  const Pregunta(texto: '¿Disfrutas analizando datos, estadísticas o gráficos de rendimiento?', riasec: 'I'),
  const Pregunta(texto: '¿Te gustaría trabajar en arqueología, paleontología o ciencias históricas?', riasec: 'I'),
  const Pregunta(texto: '¿Prefieres entender las causas profundas antes de actuar?', riasec: 'I'),

  // 🎨 ARTÍSTICO (A) - 17 preguntas
  const Pregunta(texto: '¿Pasas tiempo dibujando, pintando, diseñando o creando arte visual?', riasec: 'A'),
  const Pregunta(texto: '¿Te gusta expresar tus ideas de forma visual, musical o escrita?', riasec: 'A'),
  const Pregunta(texto: '¿Te interesa la fotografía, el video, el cine o la producción audiovisual?', riasec: 'A'),
  const Pregunta(texto: '¿Prefieres proyectos donde puedas innovar libremente sin reglas estrictas?', riasec: 'A'),
  const Pregunta(texto: '¿Te gustaría diseñar ropa, accesorios, moda o tendencias estilísticas?', riasec: 'A'),
  const Pregunta(texto: '¿Te atrae la arquitectura, diseño de interiores o decoración de espacios?', riasec: 'A'),
  const Pregunta(texto: '¿Te gusta tocar un instrumento, componer canciones o producir música?', riasec: 'A'),
  const Pregunta(texto: '¿Te interesa el diseño gráfico, branding o comunicación visual?', riasec: 'A'),
  const Pregunta(texto: '¿Te gustaría crear animaciones, efectos visuales o mundos virtuales?', riasec: 'A'),
  const Pregunta(texto: '¿Eres sensible a los colores, las formas, las texturas y la estética?', riasec: 'A'),
  const Pregunta(texto: '¿Te interesa el teatro, la actuación, la danza o las artes escénicas?', riasec: 'A'),
  const Pregunta(texto: '¿Te gustaría diseñar videojuegos, experiencias interactivas o narrativa digital?', riasec: 'A'),
  const Pregunta(texto: '¿Disfrutas visitando museos, galerías, conciertos o eventos culturales?', riasec: 'A'),
  const Pregunta(texto: '¿Te interesa la publicidad creativa, storytelling o marketing de contenidos?', riasec: 'A'),
  const Pregunta(texto: '¿Te gustaría restaurar obras de arte, patrimonio cultural o artesanías?', riasec: 'A'),
  const Pregunta(texto: '¿Eres imaginativo, sueñas despierto y tienes ideas originales frecuentemente?', riasec: 'A'),
  const Pregunta(texto: '¿Disfrutas escribiendo cuentos, poesía, guiones o contenido creativo?', riasec: 'A'),

  // 🤝 SOCIAL (S) - 17 preguntas
  const Pregunta(texto: '¿Sientes empatía cuando alguien te cuenta que está pasando por una dificultad?', riasec: 'S'),
  const Pregunta(texto: '¿Te gustaría ayudar a las personas a mejorar su salud, bienestar o calidad de vida?', riasec: 'S'),
  const Pregunta(texto: '¿Podrías manejar situaciones de estrés emocional o urgencia con calma y paciencia?', riasec: 'S'),
  const Pregunta(texto: '¿Te interesa la psicología, salud mental o el comportamiento humano?', riasec: 'S'),
  const Pregunta(texto: '¿No te asusta trabajar en contacto directo con pacientes o personas vulnerables?', riasec: 'S'),
  const Pregunta(texto: '¿Te interesa la nutrición comunitaria y cómo los hábitos afectan la salud colectiva?', riasec: 'S'),
  const Pregunta(texto: '¿Te gusta cuidar, educar o acompañar a niños, adultos mayores o animales?', riasec: 'S'),
  const Pregunta(texto: '¿Eres paciente al explicar, enseñar o guiar a otras personas en su aprendizaje?', riasec: 'S'),
  const Pregunta(texto: '¿Te gustaría trabajar en hospitales, clínicas, colegios o centros comunitarios?', riasec: 'S'),
  const Pregunta(texto: '¿Te atrae la odontología, enfermería, terapia ocupacional o profesiones de cuidado?', riasec: 'S'),
  const Pregunta(texto: '¿Te gustaría ayudar en rehabilitación física, emocional o social de personas?', riasec: 'S'),
  const Pregunta(texto: '¿Te interesa trabajar en prevención de enfermedades o promoción de salud pública?', riasec: 'S'),
  const Pregunta(texto: '¿Te gustaría ayudar a personas en situaciones de vulnerabilidad o exclusión social?', riasec: 'S'),
  const Pregunta(texto: '¿Eres bueno escuchando activamente y dando consejos empáticos a tus amigos?', riasec: 'S'),
  const Pregunta(texto: '¿Te interesa la sociología, trabajo social o intervención comunitaria?', riasec: 'S'),
  const Pregunta(texto: '¿Te gustaría ser profesor, educador, orientador o formador de personas?', riasec: 'S'),
  const Pregunta(texto: '¿Te ves liderando o participando en movimientos sociales, comunitarios o de ayuda?', riasec: 'S'),

  // 💼 EMPRENDEDOR (E) - 16 preguntas
  const Pregunta(texto: '¿Te gusta organizar eventos, liderar grupos o coordinar equipos de trabajo?', riasec: 'E'),
  const Pregunta(texto: '¿Te interesa el dinero, las ventas, el emprendimiento o la economía global?', riasec: 'E'),
  const Pregunta(texto: '¿Te ves emprendiendo, creando o manejando tu propia empresa o proyecto?', riasec: 'E'),
  const Pregunta(texto: '¿Eres bueno negociando, persuadiendo o convenciendo a otros para lograr objetivos?', riasec: 'E'),
  const Pregunta(texto: '¿Te gusta establecer metas ambiciosas y competir para alcanzarlas?', riasec: 'E'),
  const Pregunta(texto: '¿Te interesa el marketing digital, ventas o estrategias de crecimiento de negocios?', riasec: 'E'),
  const Pregunta(texto: '¿Te atrae el mundo de la bolsa, las inversiones, finanzas corporativas o capital de riesgo?', riasec: 'E'),
  const Pregunta(texto: '¿Te gustaría trabajar en gestión comercial, desarrollo de negocios o expansión de mercados?', riasec: 'E'),
  const Pregunta(texto: '¿Eres ambicioso, te gusta tomar decisiones rápidas y asumir riesgos calculados?', riasec: 'E'),
  const Pregunta(texto: '¿Te gustaría trabajar en una multinacional, banco, consultora o startup?', riasec: 'E'),
  const Pregunta(texto: '¿Te interesa el comercio internacional, importación/exportación o negocios globales?', riasec: 'E'),
  const Pregunta(texto: '¿Te interesa la gerencia de proyectos, liderazgo organizacional o gestión de equipos?', riasec: 'E'),
  const Pregunta(texto: '¿Te gustaría mejorar procesos empresariales para aumentar eficiencia y rentabilidad?', riasec: 'E'),
  const Pregunta(texto: '¿Te ves dando charlas motivacionales, capacitaciones o formando líderes?', riasec: 'E'),
  const Pregunta(texto: '¿Te interesa la administración de hoteles, turismo, eventos o servicios?', riasec: 'E'),
  const Pregunta(texto: '¿Te gusta identificar oportunidades de negocio donde otros no las ven?', riasec: 'E'),

  // 📋 CONVENCIONAL (C) - 16 preguntas
  const Pregunta(texto: '¿Prefieres trabajar con datos, números, registros y información sistemática?', riasec: 'C'),
  const Pregunta(texto: '¿Eres bueno organizando información, archivos o bases de datos de manera ordenada?', riasec: 'C'),
  const Pregunta(texto: '¿Te gusta seguir procedimientos, protocolos o manuales de forma meticulosa?', riasec: 'C'),
  const Pregunta(texto: '¿Te interesa la contabilidad, impuestos, auditoría o control financiero?', riasec: 'C'),
  const Pregunta(texto: '¿Eres detallista al revisar errores en textos, códigos, informes o documentos?', riasec: 'C'),
  const Pregunta(texto: '¿Te gusta llevar el control de gastos, presupuestos, inventarios o cronogramas?', riasec: 'C'),
  const Pregunta(texto: '¿Te interesa la logística, cadena de suministro, operaciones o procesos administrativos?', riasec: 'C'),
  const Pregunta(texto: '¿Te atrae el derecho, normas, regulaciones o aspectos legales de las organizaciones?', riasec: 'C'),
  const Pregunta(texto: '¿Eres organizado con los horarios, rutinas, agendas y planificación a largo plazo?', riasec: 'C'),
  const Pregunta(texto: '¿Te gustaría trabajar en oficinas, instituciones públicas, juzgados o entidades reguladoras?', riasec: 'C'),
  const Pregunta(texto: '¿Te interesa la gestión documental, archivo, bibliotecología o sistemas de información?', riasec: 'C'),
  const Pregunta(texto: '¿Te gusta analizar gráficos, reportes, KPIs o indicadores de gestión?', riasec: 'C'),
  const Pregunta(texto: '¿Te interesa la administración pública, gestión estatal o políticas institucionales?', riasec: 'C'),
  const Pregunta(texto: '¿Te atrae el secretariado ejecutivo, asistencia administrativa o soporte organizacional?', riasec: 'C'),
  const Pregunta(texto: '¿Eres preciso, metódico y prefieres claridad antes que ambigüedad en tus tareas?', riasec: 'C'),
  const Pregunta(texto: '¿Te gustaría especializarte en control de calidad, cumplimiento normativo o auditoría?', riasec: 'C'),
];

// ─────────────────────────────────────────────────────────────
// ✅ FUNCIÓN AUXILIAR: Descripción de perfiles RIASEC
// ─────────────────────────────────────────────────────────────
String getDescripcionRIASEC(String codigo) {
  const descripciones = {
    'R': 'Realista: Te gusta trabajar con herramientas, máquinas o al aire libre. Eres práctico y prefieres resultados tangibles.',
    'I': 'Investigador: Disfrutas investigar, analizar y resolver problemas complejos. Eres curioso y orientado al conocimiento.',
    'A': 'Artístico: Te expresas con creatividad. Valoras la originalidad, el arte y la libertad de expresión.',
    'S': 'Social: Te motiva ayudar, enseñar o servir a otros. Eres empático y colaborativo.',
    'E': 'Emprendedor: Te ves liderando, persuadiendo o emprendiendo proyectos. Eres competitivo y orientado a metas.',
    'C': 'Convencional: Prefieres estructuras claras y procedimientos definidos. Eres detallista y metódico.',
  };
  return descripciones[codigo] ?? 'Perfil en construcción';
}