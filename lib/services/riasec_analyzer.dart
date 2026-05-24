// 📁 lib/services/riasec_analyzer.dart

class RiasecAnalyzer {
  // ======================================================
  // 🔥 OBTENER RANKING COMPLETO
  // ======================================================

  static List<MapEntry<String, int>> getRanking({
    required int realista,
    required int investigador,
    required int artistico,
    required int social,
    required int emprendedor,
    required int convencional,
  }) {
    final scores = {
      'Realista': realista,
      'Investigador': investigador,
      'Artístico': artistico,
      'Social': social,
      'Emprendedor': emprendedor,
      'Convencional': convencional,
    };

    final ranking = scores.entries.toList();

    ranking.sort((a, b) => b.value.compareTo(a.value));

    return ranking;
  }

  // ======================================================
  // 🔥 PERFIL PRINCIPAL
  // ======================================================

  static String getDominantProfile({
    required int realista,
    required int investigador,
    required int artistico,
    required int social,
    required int emprendedor,
    required int convencional,
  }) {
    final ranking = getRanking(
      realista: realista,
      investigador: investigador,
      artistico: artistico,
      social: social,
      emprendedor: emprendedor,
      convencional: convencional,
    );

    return ranking.first.key;
  }

  // ======================================================
  // 🔥 DESCRIPCIÓN PERFIL
  // ======================================================

  static String getDescription(String profile) {
    switch (profile) {
      case 'Realista':
        return 'Te gustan las actividades prácticas, técnicas y manuales.';

      case 'Investigador':
        return 'Te interesa analizar, investigar y resolver problemas.';

      case 'Artístico':
        return 'Tienes creatividad, imaginación y expresión artística.';

      case 'Social':
        return 'Te gusta ayudar, enseñar y trabajar con personas.';

      case 'Emprendedor':
        return 'Te orientas al liderazgo, negocios y toma de decisiones.';

      case 'Convencional':
        return 'Prefieres el orden, la organización y procesos estructurados.';

      default:
        return '';
    }
  }

  // ======================================================
  // 🔥 RECOMENDACIONES VOCACIONALES
  // ======================================================

  static List<String> getCareers(String profile) {
    switch (profile) {
      case 'Realista':
        return [
          'Ingeniería',
          'Arquitectura',
          'Mecánica',
          'Electrónica',
        ];

      case 'Investigador':
        return [
          'Medicina',
          'Biología',
          'Investigación',
          'Ciencias',
        ];

      case 'Artístico':
        return [
          'Diseño Gráfico',
          'Música',
          'Artes Visuales',
          'Publicidad',
        ];

      case 'Social':
        return [
          'Psicología',
          'Trabajo Social',
          'Docencia',
          'Enfermería',
        ];

      case 'Emprendedor':
        return [
          'Administración',
          'Marketing',
          'Negocios',
          'Finanzas',
        ];

      case 'Convencional':
        return [
          'Contabilidad',
          'Gestión Administrativa',
          'Archivo',
          'Logística',
        ];

      default:
        return [];
    }
  }
}