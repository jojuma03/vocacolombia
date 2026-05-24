// 📁 lib/test_screen.dart

import 'package:flutter/material.dart';

import 'data/carreras_data.dart';
import 'data/preguntas_data.dart';
import 'pdf_generator.dart';
import 'results_history_screen.dart';
import 'services.dart';
import 'utils/resultado_riasec.dart';

class TestScreen extends StatefulWidget {
  final Map<String, String> estudiante;

  const TestScreen({
    super.key,
    required this.estudiante,
  });

  @override
  State<TestScreen> createState() =>
      _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int preguntaActual = 0;

  final Map<String, int> puntajes = {
    'R': 0,
    'I': 0,
    'A': 0,
    'S': 0,
    'E': 0,
    'C': 0,
  };

  bool _isAuthorized = false;

  // ======================================================
  // 🔥 INIT
  // ======================================================

  @override
  void initState() {
    super.initState();
    _validarAcceso();
  }

  // ======================================================
  // 🔥 VALIDAR ACCESO
  // ======================================================

  void _validarAcceso() {
    final nombre =
    widget.estudiante['nombre']?.trim();

    final correo =
    widget.estudiante['correo']?.trim();

    if (nombre != null &&
        nombre.isNotEmpty &&
        correo != null &&
        correo.isNotEmpty &&
        RegExp(
          r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$',
        ).hasMatch(correo)) {
      setState(() {
        _isAuthorized = true;
      });
    } else {
      WidgetsBinding.instance
          .addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            const SnackBar(
              content: Text(
                '⚠️ Datos incompletos. Regístrate nuevamente.',
              ),
              backgroundColor: Colors.red,
            ),
          );

          Navigator.of(context)
              .popUntil(
                (route) => route.isFirst,
          );
        }
      });
    }
  }

  // ======================================================
  // 🔥 RESPONDER
  // ======================================================

  void responder(int puntos) {
    if (!_isAuthorized) return;

    final riasec =
        preguntasBase[preguntaActual].riasec;

    setState(() {
      puntajes[riasec] =
          (puntajes[riasec] ?? 0) + puntos;

      if (preguntaActual <
          preguntasBase.length - 1) {
        preguntaActual++;
      } else {
        mostrarResultados();
      }
    });
  }

  // ======================================================
  // 🔥 MOSTRAR RESULTADOS
  // ======================================================

  void mostrarResultados() {
    final ordenados =
    puntajes.entries.toList()
      ..sort(
            (a, b) =>
            b.value.compareTo(a.value),
      );

    final perfilPrimario =
        ordenados[0].key;

    final perfilSecundario =
        ordenados[1].key;

    final resultado =
    generarResultadoVocacional(
      principal: perfilPrimario,
      secundario: perfilSecundario,
    );

    final descripcionPerfil =
        resultado.descripcion;

    final recomendadas =
    getCarrerasPorRiasec(
      perfilPrimario,
    );

    showDialog(
      context: context,
      barrierDismissible: false,

      builder: (context) => ResultadoDialog(
        nombre:
        widget.estudiante['nombre'] ??
            'Anónimo',

        institucion:
        widget.estudiante[
        'institucion'] ??
            'Institución',

        correo:
        widget.estudiante['correo'] ??
            'correo@ejemplo.com',

        perfilGanador: perfilPrimario,

        nombrePerfil:
        '${_nombrePerfil(perfilPrimario)} + ${_nombrePerfil(perfilSecundario)}',

        descripcionPerfil:
        descripcionPerfil,

        recomendadas: recomendadas,

        puntajes: puntajes,

        onRepetir: () {
          setState(() {
            preguntaActual = 0;

            puntajes.updateAll(
                  (key, value) => 0,
            );
          });

          Navigator.pop(context);
        },

        onInicio: () {
          Navigator.of(context).popUntil(
                (route) => route.isFirst,
          );
        },
      ),
    );
  }

  // ======================================================
  // 🔥 NOMBRE PERFIL
  // ======================================================

  String _nombrePerfil(String codigo) {
    const perfiles = {
      'R': 'Realista',
      'I': 'Investigador',
      'A': 'Artístico',
      'S': 'Social',
      'E': 'Emprendedor',
      'C': 'Convencional',
    };

    return perfiles[codigo] ?? codigo;
  }

  // ======================================================
  // 🔥 BOTÓN RESPUESTA
  // ======================================================

  Widget _buildRespuestaButton(
      String texto,
      int valor,
      Color color,
      ) {
    return ElevatedButton(
      onPressed: () => responder(valor),

      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        minimumSize:
        const Size(double.infinity, 55),
      ),

      child: Text(
        texto,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ======================================================
  // 🔥 UI PRINCIPAL
  // ======================================================

  @override
  Widget build(BuildContext context) {
    if (!_isAuthorized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final pregunta =
    preguntasBase[preguntaActual];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pregunta ${preguntaActual + 1}/${preguntasBase.length}',
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            LinearProgressIndicator(
              value:
              (preguntaActual + 1) /
                  preguntasBase.length,
            ),

            const SizedBox(height: 40),

            Text(
              pregunta.texto,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            _buildRespuestaButton(
              'Poco',
              1,
              Colors.orange,
            ),

            const SizedBox(height: 15),

            _buildRespuestaButton(
              'Regular',
              2,
              Colors.blue,
            ),

            const SizedBox(height: 15),

            _buildRespuestaButton(
              'Mucho',
              3,
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// 🔥 DIALOG RESULTADO
// ======================================================

class ResultadoDialog
    extends StatefulWidget {
  final String nombre;
  final String institucion;
  final String correo;
  final String perfilGanador;
  final String nombrePerfil;
  final String descripcionPerfil;
  final List<Carrera> recomendadas;
  final Map<String, int> puntajes;
  final VoidCallback onRepetir;
  final VoidCallback onInicio;

  const ResultadoDialog({
    super.key,
    required this.nombre,
    required this.institucion,
    required this.correo,
    required this.perfilGanador,
    required this.nombrePerfil,
    required this.descripcionPerfil,
    required this.recomendadas,
    required this.puntajes,
    required this.onRepetir,
    required this.onInicio,
  });

  @override
  State<ResultadoDialog> createState() =>
      _ResultadoDialogState();
}

class _ResultadoDialogState
    extends State<ResultadoDialog> {
  bool isLoading = false;

  // ======================================================
  // 🔥 GENERAR REPORTE
  // ======================================================

  Future<void> _generarReporte() async {
    setState(() {
      isLoading = true;
    });

    try {
      await generarPDF(
        nombre: widget.nombre,
        institucion: widget.institucion,
        correo: widget.correo,
        areaGanadora:
        '${widget.nombrePerfil} (${widget.perfilGanador})',
        carreras: widget.recomendadas
            .map((e) => e.nombre)
            .toList(),
      );

      final db = DatabaseService();

      await db.guardarRegistro(
        datosPersonales: {
          'nombre': widget.nombre,
          'institucion':
          widget.institucion,
          'correo': widget.correo,
        },

        resultados: {
          'perfil':
          widget.perfilGanador,
          'perfil_nombre':
          widget.nombrePerfil,
          'puntajes':
          widget.puntajes,
        },
      );

      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              '✅ Reporte generado correctamente',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content: Text(
              '❌ Error: $e',
            ),
          ),
        );
      }
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  // ======================================================
  // 🔥 UI RESULTADO
  // ======================================================

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        '🎓 Resultado Vocacional',
      ),

      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Text(widget.nombre),

            const SizedBox(height: 10),

            Text(
              widget.nombrePerfil,
              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              widget.descripcionPerfil,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            const Text(
              'Carreras sugeridas:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            ...widget.recomendadas
                .take(5)
                .map(
                  (carrera) => Padding(
                padding:
                const EdgeInsets.symmetric(
                  vertical: 2,
                ),

                child: Text(
                  '• ${carrera.nombre}',
                ),
              ),
            ),
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: widget.onInicio,
          child: const Text('Inicio'),
        ),

        TextButton(
          onPressed: widget.onRepetir,
          child: const Text('Repetir'),
        ),

        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                const ResultsHistoryScreen(),
              ),
            );
          },
          child: const Text('Historial'),
        ),

        ElevatedButton.icon(
          onPressed:
          isLoading ? null : _generarReporte,

          icon: isLoading
              ? const SizedBox(
            width: 18,
            height: 18,
            child:
            CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
              : const Icon(
            Icons.picture_as_pdf,
          ),

          label: Text(
            isLoading
                ? 'Generando...'
                : 'PDF',
          ),
        ),
      ],
    );
  }
}