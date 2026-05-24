// 📁 lib/data/preguntas_data.dart
// BANCO PROFESIONAL RIASEC + INTELIGENCIAS MÚLTIPLES
// VocaColombia 2026
// Versión fortalecida y equilibrada psicométricamente

import '../models_pregunta.dart';

// ─────────────────────────────────────────────
// ✅ BANCO DE PREGUNTAS PROFESIONAL
// 120 preguntas equilibradas
//
// 20 REALISTA
// 20 INVESTIGADOR
// 20 ARTÍSTICO
// 20 SOCIAL
// 20 EMPRENDEDOR
// 20 CONVENCIONAL
//
// Incluye:
// ✅ Inteligencias múltiples
// ✅ Intereses
// ✅ Habilidades
// ✅ Creatividad
// ✅ Liderazgo
// ✅ Pensamiento lógico
// ✅ Sensibilidad social
// ✅ Organización
// ─────────────────────────────────────────────

final List<Pregunta> preguntasBase = [

  // ═══════════════════════════════════════════
  // 🔧 REALISTA (R) - 20
  // ═══════════════════════════════════════════

  const Pregunta(
    texto: '¿Disfrutas reparar aparatos electrónicos o mecánicos?',
    riasec: 'R',
  ),
  const Pregunta(
    texto: '¿Te gusta trabajar con herramientas manuales o eléctricas?',
    riasec: 'R',
  ),
  const Pregunta(
    texto: '¿Prefieres actividades prácticas antes que teóricas?',
    riasec: 'R',
  ),
  const Pregunta(
    texto: '¿Te interesa entender cómo funcionan las máquinas?',
    riasec: 'R',
  ),
  const Pregunta(
    texto: '¿Disfrutas construir objetos o estructuras con tus manos?',
    riasec: 'R',
  ),
  const Pregunta(
    texto: '¿Te gustaría trabajar en ingeniería, construcción o mecánica?',
    riasec: 'R',
  ),
  const Pregunta(
    texto: '¿Te atraen los trabajos de campo y actividades al aire libre?',
    riasec: 'R',
  ),
  const Pregunta(
    texto: '¿Te interesa la robótica o automatización industrial?',
    riasec: 'R',
  ),
  const Pregunta(
    texto: '¿Te gustaría trabajar con motores, vehículos o maquinaria?',
    riasec: 'R',
  ),
  const Pregunta(
    texto: '¿Te gusta resolver problemas técnicos concretos?',
    riasec: 'R',
  ),
  const Pregunta(
    texto: '¿Te interesa la energía solar, eólica o tecnologías sostenibles?',
    riasec: 'R',
  ),
  const Pregunta(
    texto: '¿Prefieres aprender haciendo en lugar de solo leer?',
    riasec: 'R',
  ),
  const Pregunta(
    texto: '¿Te atraen los laboratorios técnicos y talleres prácticos?',
    riasec: 'R',
  ),
  const Pregunta(
    texto: '¿Te gustaría participar en proyectos de infraestructura?',
    riasec: 'R',
  ),
  const Pregunta(
    texto: '¿Te interesa el mantenimiento de sistemas eléctricos?',
    riasec: 'R',
  ),
  const Pregunta(
    texto: '¿Disfrutas actividades relacionadas con agricultura o naturaleza?',
    riasec: 'R',
  ),
  const Pregunta(
    texto: '¿Te consideras una persona práctica y resolutiva?',
    riasec: 'R',
  ),
  const Pregunta(
    texto: '¿Te gusta seguir procesos técnicos paso a paso?',
    riasec: 'R',
  ),
  const Pregunta(
    texto: '¿Te atrae el diseño y ensamblaje de dispositivos?',
    riasec: 'R',
  ),
  const Pregunta(
    texto: '¿Te gustaría trabajar en aviación, mecánica o electrónica?',
    riasec: 'R',
  ),

  // ═══════════════════════════════════════════
  // 🔬 INVESTIGADOR (I) - 20
  // ═══════════════════════════════════════════

  const Pregunta(
    texto: '¿Te gusta investigar temas complejos por curiosidad?',
    riasec: 'I',
  ),
  const Pregunta(
    texto: '¿Disfrutas resolver problemas matemáticos o lógicos?',
    riasec: 'I',
  ),
  const Pregunta(
    texto: '¿Te interesa la ciencia y los descubrimientos científicos?',
    riasec: 'I',
  ),
  const Pregunta(
    texto: '¿Te gustaría desarrollar software o inteligencia artificial?',
    riasec: 'I',
  ),
  const Pregunta(
    texto: '¿Disfrutas analizar datos y estadísticas?',
    riasec: 'I',
  ),
  const Pregunta(
    texto: '¿Te interesa comprender cómo funciona el cuerpo humano?',
    riasec: 'I',
  ),
  const Pregunta(
    texto: '¿Te atrae la investigación médica o biotecnológica?',
    riasec: 'I',
  ),
  const Pregunta(
    texto: '¿Te gusta formular hipótesis y buscar respuestas?',
    riasec: 'I',
  ),
  const Pregunta(
    texto: '¿Te interesa la astronomía o el universo?',
    riasec: 'I',
  ),
  const Pregunta(
    texto: '¿Disfrutas aprendiendo conceptos nuevos constantemente?',
    riasec: 'I',
  ),
  const Pregunta(
    texto: '¿Te interesa la programación y desarrollo tecnológico?',
    riasec: 'I',
  ),
  const Pregunta(
    texto: '¿Prefieres comprender profundamente antes de actuar?',
    riasec: 'I',
  ),
  const Pregunta(
    texto: '¿Te atraen los laboratorios científicos?',
    riasec: 'I',
  ),
  const Pregunta(
    texto: '¿Te gusta investigar el comportamiento humano?',
    riasec: 'I',
  ),
  const Pregunta(
    texto: '¿Te interesan las teorías filosóficas o científicas?',
    riasec: 'I',
  ),
  const Pregunta(
    texto: '¿Te atrae la ciberseguridad o criptografía?',
    riasec: 'I',
  ),
  const Pregunta(
    texto: '¿Disfrutas identificar patrones o relaciones complejas?',
    riasec: 'I',
  ),
  const Pregunta(
    texto: '¿Te interesa descubrir cómo mejorar procesos o sistemas?',
    riasec: 'I',
  ),
  const Pregunta(
    texto: '¿Te gustaría participar en investigaciones universitarias?',
    riasec: 'I',
  ),
  const Pregunta(
    texto: '¿Te consideras analítico y observador?',
    riasec: 'I',
  ),

  // ═══════════════════════════════════════════
  // 🎨 ARTÍSTICO (A) - 20
  // ═══════════════════════════════════════════

  const Pregunta(
    texto: '¿Disfrutas expresarte mediante dibujo, música o escritura?',
    riasec: 'A',
  ),
  const Pregunta(
    texto: '¿Te gusta crear ideas originales o innovadoras?',
    riasec: 'A',
  ),
  const Pregunta(
    texto: '¿Te interesa el diseño gráfico o audiovisual?',
    riasec: 'A',
  ),
  const Pregunta(
    texto: '¿Te gusta escribir historias, poesía o contenido creativo?',
    riasec: 'A',
  ),
  const Pregunta(
    texto: '¿Te atrae la fotografía, cine o producción audiovisual?',
    riasec: 'A',
  ),
  const Pregunta(
    texto: '¿Disfrutas tocar instrumentos o producir música?',
    riasec: 'A',
  ),
  const Pregunta(
    texto: '¿Te interesa el teatro, danza o actuación?',
    riasec: 'A',
  ),
  const Pregunta(
    texto: '¿Prefieres ambientes flexibles y creativos?',
    riasec: 'A',
  ),
  const Pregunta(
    texto: '¿Te atrae la arquitectura o diseño de espacios?',
    riasec: 'A',
  ),
  const Pregunta(
    texto: '¿Te gusta experimentar nuevas formas de expresión?',
    riasec: 'A',
  ),
  const Pregunta(
    texto: '¿Te consideras imaginativo y creativo?',
    riasec: 'A',
  ),
  const Pregunta(
    texto: '¿Te interesa la moda y tendencias estéticas?',
    riasec: 'A',
  ),
  const Pregunta(
    texto: '¿Disfrutas observar colores, texturas y detalles visuales?',
    riasec: 'A',
  ),
  const Pregunta(
    texto: '¿Te gustaría trabajar en publicidad o storytelling?',
    riasec: 'A',
  ),
  const Pregunta(
    texto: '¿Te atrae el diseño de videojuegos o animación?',
    riasec: 'A',
  ),
  const Pregunta(
    texto: '¿Te gusta improvisar o crear nuevas posibilidades?',
    riasec: 'A',
  ),
  const Pregunta(
    texto: '¿Te interesa el arte digital y contenidos interactivos?',
    riasec: 'A',
  ),
  const Pregunta(
    texto: '¿Disfrutas asistir a eventos culturales o artísticos?',
    riasec: 'A',
  ),
  const Pregunta(
    texto: '¿Te gusta expresar emociones mediante el arte?',
    riasec: 'A',
  ),
  const Pregunta(
    texto: '¿Te gustaría trabajar en industrias creativas?',
    riasec: 'A',
  ),

  // ═══════════════════════════════════════════
  // 🤝 SOCIAL (S) - 20
  // ═══════════════════════════════════════════

  const Pregunta(
    texto: '¿Te gusta ayudar a las personas cuando tienen dificultades?',
    riasec: 'S',
  ),
  const Pregunta(
    texto: '¿Disfrutas enseñar o explicar temas a otros?',
    riasec: 'S',
  ),
  const Pregunta(
    texto: '¿Te interesa la psicología o comportamiento humano?',
    riasec: 'S',
  ),
  const Pregunta(
    texto: '¿Te gustaría trabajar en educación o salud?',
    riasec: 'S',
  ),
  const Pregunta(
    texto: '¿Te consideras empático y buen oyente?',
    riasec: 'S',
  ),
  const Pregunta(
    texto: '¿Te gusta trabajar en equipo y cooperar?',
    riasec: 'S',
  ),
  const Pregunta(
    texto: '¿Te interesa mejorar la calidad de vida de otros?',
    riasec: 'S',
  ),
  const Pregunta(
    texto: '¿Te gustaría participar en proyectos comunitarios?',
    riasec: 'S',
  ),
  const Pregunta(
    texto: '¿Disfrutas motivar y apoyar a otras personas?',
    riasec: 'S',
  ),
  const Pregunta(
    texto: '¿Te atrae el trabajo social o comunitario?',
    riasec: 'S',
  ),
  const Pregunta(
    texto: '¿Te interesa orientar o aconsejar personas?',
    riasec: 'S',
  ),
  const Pregunta(
    texto: '¿Te gustaría trabajar con niños o adultos mayores?',
    riasec: 'S',
  ),
  const Pregunta(
    texto: '¿Te interesa la salud mental y emocional?',
    riasec: 'S',
  ),
  const Pregunta(
    texto: '¿Te gusta escuchar activamente a los demás?',
    riasec: 'S',
  ),
  const Pregunta(
    texto: '¿Te consideras paciente y comprensivo?',
    riasec: 'S',
  ),
  const Pregunta(
    texto: '¿Te interesa promover la inclusión y diversidad?',
    riasec: 'S',
  ),
  const Pregunta(
    texto: '¿Te gustaría trabajar en fundaciones o ONG?',
    riasec: 'S',
  ),
  const Pregunta(
    texto: '¿Te interesa la orientación vocacional o educativa?',
    riasec: 'S',
  ),
  const Pregunta(
    texto: '¿Disfrutas mediar conflictos o apoyar acuerdos?',
    riasec: 'S',
  ),
  const Pregunta(
    texto: '¿Te motiva generar impacto positivo en la sociedad?',
    riasec: 'S',
  ),

  // ═══════════════════════════════════════════
  // 💼 EMPRENDEDOR (E) - 20
  // ═══════════════════════════════════════════

  const Pregunta(
    texto: '¿Te gusta liderar grupos o proyectos?',
    riasec: 'E',
  ),
  const Pregunta(
    texto: '¿Te interesa crear empresas o emprendimientos?',
    riasec: 'E',
  ),
  const Pregunta(
    texto: '¿Te gusta persuadir o convencer a otras personas?',
    riasec: 'E',
  ),
  const Pregunta(
    texto: '¿Te atraen las ventas y el marketing?',
    riasec: 'E',
  ),
  const Pregunta(
    texto: '¿Disfrutas asumir retos y tomar decisiones rápidas?',
    riasec: 'E',
  ),
  const Pregunta(
    texto: '¿Te interesa el mundo financiero y empresarial?',
    riasec: 'E',
  ),
  const Pregunta(
    texto: '¿Te gustaría dirigir equipos de trabajo?',
    riasec: 'E',
  ),
  const Pregunta(
    texto: '¿Te motiva alcanzar metas ambiciosas?',
    riasec: 'E',
  ),
  const Pregunta(
    texto: '¿Te interesa negociar y cerrar acuerdos?',
    riasec: 'E',
  ),
  const Pregunta(
    texto: '¿Te gustaría trabajar en comercio internacional?',
    riasec: 'E',
  ),
  const Pregunta(
    texto: '¿Te gusta identificar oportunidades de negocio?',
    riasec: 'E',
  ),
  const Pregunta(
    texto: '¿Te consideras competitivo y orientado al logro?',
    riasec: 'E',
  ),
  const Pregunta(
    texto: '¿Te interesa la administración de empresas?',
    riasec: 'E',
  ),
  const Pregunta(
    texto: '¿Disfrutas hablar en público o presentar ideas?',
    riasec: 'E',
  ),
  const Pregunta(
    texto: '¿Te gustaría liderar iniciativas innovadoras?',
    riasec: 'E',
  ),
  const Pregunta(
    texto: '¿Te atraen las startups y nuevos negocios?',
    riasec: 'E',
  ),
  const Pregunta(
    texto: '¿Te interesa la gerencia y dirección organizacional?',
    riasec: 'E',
  ),
  const Pregunta(
    texto: '¿Te gusta motivar personas hacia objetivos?',
    riasec: 'E',
  ),
  const Pregunta(
    texto: '¿Te gustaría trabajar en política o liderazgo social?',
    riasec: 'E',
  ),
  const Pregunta(
    texto: '¿Te motiva transformar ideas en proyectos reales?',
    riasec: 'E',
  ),

  // ═══════════════════════════════════════════
  // 📋 CONVENCIONAL (C) - 20
  // ═══════════════════════════════════════════

  const Pregunta(
    texto: '¿Te gusta organizar documentos y archivos?',
    riasec: 'C',
  ),
  const Pregunta(
    texto: '¿Prefieres seguir procedimientos claros y ordenados?',
    riasec: 'C',
  ),
  const Pregunta(
    texto: '¿Te interesa trabajar con datos y números?',
    riasec: 'C',
  ),
  const Pregunta(
    texto: '¿Disfrutas planificar actividades y horarios?',
    riasec: 'C',
  ),
  const Pregunta(
    texto: '¿Te consideras detallista y organizado?',
    riasec: 'C',
  ),
  const Pregunta(
    texto: '¿Te interesa la contabilidad o auditoría?',
    riasec: 'C',
  ),
  const Pregunta(
    texto: '¿Te gusta verificar información cuidadosamente?',
    riasec: 'C',
  ),
  const Pregunta(
    texto: '¿Te atrae la administración y gestión documental?',
    riasec: 'C',
  ),
  const Pregunta(
    texto: '¿Te gusta mantener el orden y la estructura?',
    riasec: 'C',
  ),
  const Pregunta(
    texto: '¿Te interesa la logística y procesos administrativos?',
    riasec: 'C',
  ),
  const Pregunta(
    texto: '¿Te gusta trabajar con cronogramas y presupuestos?',
    riasec: 'C',
  ),
  const Pregunta(
    texto: '¿Te atrae el control de calidad y normas?',
    riasec: 'C',
  ),
  const Pregunta(
    texto: '¿Te gusta revisar errores y corregir detalles?',
    riasec: 'C',
  ),
  const Pregunta(
    texto: '¿Te interesa la gestión pública o institucional?',
    riasec: 'C',
  ),
  const Pregunta(
    texto: '¿Disfrutas llevar registros y estadísticas?',
    riasec: 'C',
  ),
  const Pregunta(
    texto: '¿Te gusta trabajar en ambientes organizados?',
    riasec: 'C',
  ),
  const Pregunta(
    texto: '¿Prefieres tareas estructuradas y previsibles?',
    riasec: 'C',
  ),
  const Pregunta(
    texto: '¿Te interesa el cumplimiento de normas y procesos?',
    riasec: 'C',
  ),
  const Pregunta(
    texto: '¿Te gusta administrar recursos y materiales?',
    riasec: 'C',
  ),
  const Pregunta(
    texto: '¿Te consideras disciplinado y metódico?',
    riasec: 'C',
  ),
];

// ─────────────────────────────────────────────
// ✅ DESCRIPCIONES RIASEC
// ─────────────────────────────────────────────

String getDescripcionRIASEC(String codigo) {
  const descripciones = {
    'R':
    'Realista: Perfil práctico, técnico y orientado a la acción concreta.',
    'I':
    'Investigador: Perfil analítico, científico y orientado al conocimiento.',
    'A':
    'Artístico: Perfil creativo, expresivo e innovador.',
    'S':
    'Social: Perfil empático, colaborativo y orientado al servicio.',
    'E':
    'Emprendedor: Perfil líder, persuasivo y orientado a metas.',
    'C':
    'Convencional: Perfil organizado, estructurado y metódico.',
  };

  return descripciones[codigo] ?? 'Perfil vocacional';
}