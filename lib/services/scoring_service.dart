// 📁 lib/services/scoring_service.dart
// Servicio de scoring mejorado para VocaColombia
// ✅ No modifica carreras_data.dart ni preguntas_data.dart

import '../data/carreras_data.dart';
import '../data/preguntas_data.dart';

// =========================================================
// 1. MODELO DE RESULTADO
// =========================================================

class ResultadoCarrera {
  final Carrera carrera;
  final double puntaje;
  final double compatibilidad;
  final String razonMatch;

  const ResultadoCarrera({
    required this.carrera,
    required this.puntaje,
    required this.compatibilidad,
    required this.razonMatch,
  });
}

class ResultadoTest {
  final String perfilPrimario;
  final String perfilSecundario;
  final Map<String, int> puntajesRaw;
  final List<ResultadoCarrera> carrerasTop;
  final String descripcionPerfil;

  const ResultadoTest({
    required this.perfilPrimario,
    required this.perfilSecundario,
    required this.puntajesRaw,
    required this.carrerasTop,
    required this.descripcionPerfil,
  });
}

// =========================================================
// 2. MATRIZ DE AFINIDAD: Carrera → RIASEC combinado
// =========================================================

final Map<String, Map<String, double>> _matrizAfinidad = {
  'Tecnología en Mantenimiento de Aeronaves': {'R': 0.85, 'I': 0.15},
  'Técnico en Soldadura': {'R': 0.90, 'C': 0.10},
  'Ingeniería Agronómica': {'R': 0.60, 'I': 0.30, 'E': 0.10},
  'Tecnología en Topografía': {'R': 0.70, 'I': 0.20, 'C': 0.10},
  'Ingeniería Mecánica': {'R': 0.70, 'I': 0.25, 'C': 0.05},
  'Técnico en Electricidad Industrial': {'R': 0.75, 'I': 0.20, 'C': 0.05},
  'Ingeniería de Minas': {'R': 0.60, 'I': 0.30, 'E': 0.10},
  'Tecnología en Gestión de Redes': {'R': 0.50, 'I': 0.40, 'C': 0.10},
  'Ingeniería Forestal': {'R': 0.65, 'I': 0.25, 'S': 0.10},
  'Ingeniería de Sistemas': {'I': 0.60, 'R': 0.20, 'C': 0.20},
  'Medicina': {'I': 0.55, 'S': 0.35, 'R': 0.10},
  'Biología': {'I': 0.70, 'R': 0.20, 'S': 0.10},
  'Ingeniería Biomédica': {'I': 0.60, 'R': 0.25, 'S': 0.15},
  'Matemáticas': {'I': 0.85, 'C': 0.15},
  'Química': {'I': 0.75, 'R': 0.20, 'C': 0.05},
  'Ingeniería Ambiental': {'I': 0.50, 'R': 0.30, 'S': 0.20},
  'Microbiología': {'I': 0.80, 'S': 0.15, 'R': 0.05},
  'Ingeniería Electrónica': {'I': 0.65, 'R': 0.25, 'C': 0.10},
  'Diseño Gráfico': {'A': 0.70, 'I': 0.20, 'E': 0.10},
  'Música': {'A': 0.85, 'S': 0.15},
  'Artes Plásticas': {'A': 0.90, 'S': 0.10},
  'Diseño de Modas': {'A': 0.75, 'E': 0.20, 'R': 0.05},
  'Cine y Televisión': {'A': 0.70, 'E': 0.20, 'I': 0.10},
  'Diseño Industrial': {'A': 0.60, 'R': 0.30, 'I': 0.10},
  'Arquitectura': {'A': 0.60, 'R': 0.30, 'I': 0.10},
  'Publicidad': {'A': 0.60, 'E': 0.35, 'I': 0.05},
  'Psicología': {'S': 0.70, 'I': 0.25, 'A': 0.05},
  'Enfermería': {'S': 0.75, 'I': 0.20, 'R': 0.05},
  'Trabajo Social': {'S': 0.85, 'E': 0.15},
  'Licenciatura en Educación': {'S': 0.80, 'A': 0.15, 'C': 0.05},
  'Terapia Ocupacional': {'S': 0.70, 'R': 0.20, 'I': 0.10},
  'Fonoaudiología': {'S': 0.75, 'I': 0.20, 'R': 0.05},
  'Nutrición y Dietética': {'S': 0.60, 'I': 0.30, 'C': 0.10},
  'Pedagogía Infantil': {'S': 0.85, 'A': 0.15},
  'Administración de Empresas': {'E': 0.60, 'C': 0.30, 'I': 0.10},
  'Negocios Internacionales': {'E': 0.65, 'C': 0.25, 'I': 0.10},
  'Marketing Digital': {'E': 0.70, 'A': 0.20, 'I': 0.10},
  'Gestión Turística': {'E': 0.70, 'S': 0.20, 'C': 0.10},
  'Comercio Exterior': {'E': 0.65, 'C': 0.30, 'I': 0.05},
  'Relaciones Internacionales': {'E': 0.50, 'S': 0.30, 'I': 0.20},
  'Gestión Deportiva': {'E': 0.70, 'S': 0.20, 'R': 0.10},
  'Emprendimiento': {'E': 0.80, 'C': 0.15, 'I': 0.05},
  'Contaduría Pública': {'C': 0.75, 'E': 0.20, 'I': 0.05},
  'Tecnología en Gestión Administrativa': {'C': 0.70, 'E': 0.20, 'S': 0.10},
  'Derecho': {'C': 0.60, 'S': 0.25, 'E': 0.15},
  'Tecnología en Gestión Documental': {'C': 0.80, 'I': 0.15, 'S': 0.05},
  'Auditoría de Sistemas': {'C': 0.60, 'I': 0.35, 'E': 0.05},
  'Secretariado Ejecutivo': {'C': 0.75, 'S': 0.20, 'E': 0.05},
  'Gestión Logística': {'C': 0.60, 'E': 0.25, 'R': 0.15},
  'Análisis Financiero': {'C': 0.70, 'I': 0.25, 'E': 0.05},
};

// =========================================================
// 3. DESCRIPCIONES POR COMBINACION
// =========================================================

String _getDescripcionCombinada(String primario, String secundario) {
  final combos = {
    'R+I': 'Tienes un perfil tecnico-analitico. Disfrutas construir y entender como funcionan las cosas.',
    'R+A': 'Eres un creador manual. Disfrutas crear cosas tangibles con estetica y funcionalidad.',
    'R+S': 'Tienes un perfil de servicio tecnico. Te gusta ayudar a otros usando herramientas.',
    'I+S': 'Eres un investigador humanista. Te motiva entender a las personas y mejorar vidas.',
    'I+A': 'Tienes un perfil innovador. Disfrutas crear soluciones originales con conocimiento profundo.',
    'I+E': 'Eres un emprendedor tecnico. Combinas conocimiento especializado con vision de negocio.',
    'A+S': 'Eres un comunicador creativo. Te expresas artisticamente para conectar con otros.',
    'A+E': 'Tienes un perfil de creador de negocios. Transformas ideas creativas en proyectos viables.',
    'S+E': 'Eres un lider social. Te motiva organizar personas y recursos para causas importantes.',
    'S+C': 'Tienes un perfil de gestor social. Eres organizado y te importa el bienestar colectivo.',
    'E+C': 'Eres un administrador eficiente. Combinas ambicion con metodologia y estructura.',
    'C+I': 'Tienes un perfil analitico-estructurado. Eres metodico y disfrutas resolver problemas con datos.',
    'C+R': 'Eres un operador preciso. Te gusta seguir procedimientos con exactitud tecnica.',
  };
  
  final key1 = '$primario+$secundario';
  final key2 = '$secundario+$primario';
  return combos[key1] ?? combos[key2] ?? 'Tienes un perfil equilibrado y versatil.';
}

// =========================================================
// 4. ALGORITMO PRINCIPAL
// =========================================================

class ScoringService {
  
  ResultadoTest calcularResultados(Map<String, int> puntajesRaw) {
    
    // 4.1 Normalizar puntajes a porcentajes
    final totalPuntos = puntajesRaw.values.reduce((a, b) => a + b);
    final porcentajes = <String, double>{};
    
    for (final entry in puntajesRaw.entries) {
      porcentajes[entry.key] = totalPuntos > 0 
          ? (entry.value / totalPuntos) * 100 
          : 0.0;
    }
    
    // 4.2 Identificar primario y secundario
    final ordenados = porcentajes.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    final primario = ordenados[0].key;
    final secundario = ordenados.length > 1 ? ordenados[1].key : primario;
    
    // 4.3 Calcular afinidad con CADA carrera
    final resultados = <ResultadoCarrera>[];
    
    for (final carrera in carrerasBase) {
      final afinidad = _matrizAfinidad[carrera.nombre];
      if (afinidad == null) continue;
      
      double puntaje = 0;
      
      for (final riasec in ['R', 'I', 'A', 'S', 'E', 'C']) {
        final pesoCarrera = afinidad[riasec] ?? 0.0;
        final porcentajeUsuario = porcentajes[riasec] ?? 0.0;
        puntaje += pesoCarrera * porcentajeUsuario;
      }
      
      // Penalizacion si el RIASEC mas bajo del usuario coincide fuertemente
      final riasecMinimo = ordenados.last.key;
      final pesoMinimoEnCarrera = afinidad[riasecMinimo] ?? 0.0;
      if (pesoMinimoEnCarrera > 0.3) {
        puntaje *= 0.7;
      }
      
      final razon = _generarRazon(carrera.nombre, afinidad, primario, secundario, puntaje);
      
      resultados.add(ResultadoCarrera(
        carrera: carrera,
        puntaje: puntaje,
        compatibilidad: puntaje,
        razonMatch: razon,
      ));
    }
    
    // 4.4 Ordenar por puntaje
    resultados.sort((a, b) => b.puntaje.compareTo(a.puntaje));
    
    // 4.5 Filtrar: maximo 3, diversidad por area, umbral
    final carrerasFiltradas = _filtrarCarreras(resultados);
    
    // 4.6 Descripcion del perfil
    final descripcion = primario == secundario 
        ? getDescripcionRIASEC(primario)
        : '${getDescripcionRIASEC(primario)} ${_getDescripcionCombinada(primario, secundario)}';
    
    return ResultadoTest(
      perfilPrimario: primario,
      perfilSecundario: secundario,
      puntajesRaw: puntajesRaw,
      carrerasTop: carrerasFiltradas,
      descripcionPerfil: descripcion,
    );
  }
  
  // =========================================================
  // 5. FILTRADO INTELIGENTE
  // =========================================================
  
  List<ResultadoCarrera> _filtrarCarreras(List<ResultadoCarrera> todas) {
    if (todas.isEmpty) return [];
    
    final seleccionadas = <ResultadoCarrera>[];
    final areasUsadas = <String>{};
    
    // Carrera #1: siempre la de mayor puntaje
    seleccionadas.add(todas[0]);
    areasUsadas.add(todas[0].carrera.areaSnies);
    
    // Carrera #2: >= 75% del puntaje #1 Y area diferente
    for (int i = 1; i < todas.length && seleccionadas.length < 2; i++) {
      final candidata = todas[i];
      final umbral = todas[0].puntaje * 0.75;
      
      if (candidata.puntaje >= umbral && !areasUsadas.contains(candidata.carrera.areaSnies)) {
        seleccionadas.add(candidata);
        areasUsadas.add(candidata.carrera.areaSnies);
      }
    }
    
    // Si no encontro #2 con area diferente, buscar sin umbral estricto
    if (seleccionadas.length < 2) {
      for (int i = 1; i < todas.length && seleccionadas.length < 2; i++) {
        final candidata = todas[i];
        if (!areasUsadas.contains(candidata.carrera.areaSnies)) {
          seleccionadas.add(candidata);
          areasUsadas.add(candidata.carrera.areaSnies);
          break;
        }
      }
    }
    
    // Carrera #3: >= 70% del puntaje #1 Y area diferente
    for (int i = 1; i < todas.length && seleccionadas.length < 3; i++) {
      final candidata = todas[i];
      final umbral = todas[0].puntaje * 0.70;
      
      if (candidata.puntaje >= umbral && !areasUsadas.contains(candidata.carrera.areaSnies)) {
        seleccionadas.add(candidata);
        areasUsadas.add(candidata.carrera.areaSnies);
      }
    }
    
    // Completar con mejor disponible de area diferente
    if (seleccionadas.length < 3) {
      for (int i = 1; i < todas.length && seleccionadas.length < 3; i++) {
        final candidata = todas[i];
        if (!areasUsadas.contains(candidata.carrera.areaSnies)) {
          seleccionadas.add(candidata);
          areasUsadas.add(candidata.carrera.areaSnies);
          break;
        }
      }
    }
    
    return seleccionadas;
  }
  
  // =========================================================
  // 6. GENERAR EXPLICACION DEL MATCH
  // =========================================================
  
  String _generarRazon(
    String nombreCarrera,
    Map<String, double> afinidad,
    String primarioUsuario,
    String secundarioUsuario,
    double puntaje,
  ) {
    final riasecPrincipalCarrera = afinidad.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
    
    final coincidePrimario = riasecPrincipalCarrera == primarioUsuario;
    final coincideSecundario = afinidad[secundarioUsuario] != null && 
                                (afinidad[secundarioUsuario]! > 0.15);
    
    if (coincidePrimario && coincideSecundario) {
      return 'Excelente match: tu perfil $primarioUsuario+$secundarioUsuario se alinea perfectamente.';
    } else if (coincidePrimario) {
      return 'Buen match: tu perfil principal $primarioUsuario es el eje de esta carrera.';
    } else if (coincideSecundario) {
      return 'Match por complementariedad: tu perfil $secundarioUsuario aporta una dimension clave.';
    } else if (puntaje > 50) {
      return 'Match equilibrado: esta carrera valora diversas habilidades que posees.';
    } else {
      return 'Match moderado: podrias desarrollar nuevas habilidades en esta area.';
    }
  }
}
