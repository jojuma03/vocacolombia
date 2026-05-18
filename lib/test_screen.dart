// 📁 lib/test_screen.dart
import 'package:flutter/material.dart';
import 'data/preguntas_data.dart';
import 'data/carreras_data.dart';
import 'pdf_generator.dart';
import 'services.dart';
import 'services/scoring_service.dart';

class TestScreen extends StatefulWidget {
  final Map<String, String> estudiante;

  const TestScreen({
    super.key,
    required this.estudiante,
  });

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int preguntaActual = 0;

  Map<String, int> puntajes = {
    'R': 0,
    'I': 0,
    'A': 0,
    'S': 0,
    'E': 0,
    'C': 0,
  };

  bool _isLoading = false;
  bool _isAuthorized = false;

  @override
  void initState() {
    super.initState();
    _validarAcceso();
  }

  void _validarAcceso() {
    final nombre = widget.estudiante['nombre']?.trim();
    final correo = widget.estudiante['correo']?.trim();

    if (nombre != null &&
        nombre.isNotEmpty &&
        correo != null &&
        correo.isNotEmpty &&
        RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$').hasMatch(correo)) {
      setState(() {
        _isAuthorized = true;
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('⚠️ Datos incompletos. Por favor, regístrate nuevamente.'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      });
    }
  }

  void responder(int puntos) {
    if (!_isAuthorized) return;
    if (preguntaActual >= preguntasBase.length) return;

    String riasec = preguntasBase[preguntaActual].riasec;

    setState(() {
      puntajes[riasec] = (puntajes[riasec] ?? 0) + puntos;

      if (preguntaActual < preguntasBase.length - 1) {
        preguntaActual++;
      } else {
        mostrarResultados();
      }
    });
  }

    void mostrarResultados() {
    if (!_isAuthorized) return;

    final scoring = ScoringService();
    final resultado = scoring.calcularResultados(puntajes);

    final recomendadas = resultado.carrerasTop.map((r) => r.carrera).toList();
    final descripcionPerfil = resultado.descripcionPerfil;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _ResultadoDialog(
        nombre: widget.estudiante['nombre'] ?? 'Anonimo',
        institucion: widget.estudiante['institucion'] ?? 'Institucion',
        correo: widget.estudiante['correo'] ?? 'correo@ejemplo.com',
        perfilGanador: resultado.perfilPrimario,
        nombrePerfil: '${_nombrePerfil(resultado.perfilPrimario)} + ${_nombrePerfil(resultado.perfilSecundario)}',
        descripcionPerfil: descripcionPerfil,
        recomendadas: recomendadas,
        puntajes: puntajes,
        onRepetir: () {
          setState(() {
            preguntaActual = 0;
            puntajes.updateAll((key, value) => 0);
          });
          Navigator.pop(context);
        },
        onInicio: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }



  String _nombrePerfil(String codigo) {
    const mapas = {
      'R': 'Realista',
      'I': 'Investigador',
      'A': 'Artístico',
      'S': 'Social',
      'E': 'Emprendedor',
      'C': 'Convencional',
    };
    return mapas[codigo] ?? codigo;
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAuthorized) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('🔐 Verificando acceso...'),
            ],
          ),
        ),
      );
    }

    if (preguntasBase.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("Cargando preguntas...")),
      );
    }

    final pregunta = preguntasBase[preguntaActual];

    return Scaffold(
      appBar: AppBar(
        title: Text('Pregunta ${preguntaActual + 1}/${preguntasBase.length}'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearProgressIndicator(
                value: (preguntaActual + 1) / preguntasBase.length,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              const SizedBox(height: 50),
              Text(
                pregunta.texto,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              _buildRespuestaButton('Poco', 1, Colors.orange),
              const SizedBox(height: 10),
              _buildRespuestaButton('Regular', 2, Colors.blue),
              const SizedBox(height: 10),
              _buildRespuestaButton('Mucho', 3, Colors.green),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRespuestaButton(String texto, int valor, Color color) {
    return ElevatedButton(
      onPressed: _isAuthorized ? () => responder(valor) : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}

// ✅ Dialog extraído como StatefulWidget propio para manejar su estado correctamente
class _ResultadoDialog extends StatefulWidget {
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

  const _ResultadoDialog({
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
  State<_ResultadoDialog> createState() => _ResultadoDialogState();
}

class _ResultadoDialogState extends State<_ResultadoDialog> {
  bool _isLoading = false;

  Future<void> _generarReporte() async {
    setState(() => _isLoading = true);

    try {
      await generarPDF(
        nombre: widget.nombre,
        institucion: widget.institucion,
        correo: widget.correo,
        areaGanadora: '${widget.nombrePerfil} (${widget.perfilGanador})',
        carreras: widget.recomendadas.map((c) => c.nombre).toList(),
      );

      final db = DatabaseService();
      final exito = await db.guardarRegistro(
        datosPersonales: {
          'nombre': widget.nombre,
          'institucion': widget.institucion,
          'correo': widget.correo,
        },
        resultados: {
          'perfil_riasec': widget.perfilGanador,
          'perfil_nombre': widget.nombrePerfil,
          'puntajes': widget.puntajes,
          'carreras_sugeridas':
          widget.recomendadas.map((c) => c.nombre).toList(),
        },
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              exito
                  ? '✅ Reporte generado y guardado en la nube'
                  : '⚠️ PDF generado, pero no se guardó en la nube',
            ),
            backgroundColor: exito ? Colors.green : Colors.orange,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('🎓 ¡Felicidades!'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Estudiante: ${widget.nombre}'),
            const Divider(),
            const Text(
              'Tu perfil predominante es:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              '${widget.nombrePerfil} (${widget.perfilGanador})',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.descripcionPerfil,
              style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            const Text(
              'Carreras sugeridas según SNIES:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            if (widget.recomendadas.isNotEmpty)
              ...widget.recomendadas.take(5).map((c) => Text('- ${c.nombre}'))
            else
              const Text(
                '⚠️ Sin carreras registradas para este perfil',
                style: TextStyle(color: Colors.orange),
              ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _generarReporte,
              icon: _isLoading
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Icon(Icons.picture_as_pdf),
              label: Text(_isLoading ? 'Procesando...' : 'Descargar Reporte PDF'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: widget.onRepetir, child: const Text('Repetir')),
        TextButton(onPressed: widget.onInicio, child: const Text('Inicio')),
      ],
    );
  }
}