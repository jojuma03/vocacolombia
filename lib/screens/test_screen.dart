// 📁 lib/screens/test_screen.dart
// Test Vocacional RIASEC - VocaColombia 2026
// ✅ Versión blindada: validaciones, errores, UX y mantenimiento mejorados

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ✅ IMPORTACIONES CON RUTAS REALES (basadas en tu estructura)
import '../data/carreras_data.dart';
import '../data/preguntas_data.dart';
import '../pdf_generator.dart';
import 'results_history_screen.dart';
import '../services.dart'; // ✅ DatabaseService se exporta desde aquí
import '../utils/resultado_riasec.dart';

// ─────────────────────────────────────────────
// ✅ PANTALLA PRINCIPAL DEL TEST
// ─────────────────────────────────────────────

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

  final Map<String, int> puntajes = {
    'R': 0, 'I': 0, 'A': 0, 'S': 0, 'E': 0, 'C': 0,
  };

  bool _isAuthorized = false;
  bool _isNavigating = false;
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _validarAcceso();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _validarAcceso() {
    try {
      final nombre = widget.estudiante['nombre']?.trim() ??
          _currentUser?.email?.split('@')[0] ??
          'Estudiante';
      final correo = widget.estudiante['correo']?.trim() ??
          _currentUser?.email ??
          '';

      if (nombre.isNotEmpty && correo.isNotEmpty &&
          RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$').hasMatch(correo)) {
        if (mounted) setState(() => _isAuthorized = true);
      } else {
        _manejarErrorAcceso('Datos de usuario incompletos o inválidos');
      }
    } catch (e) {
      _manejarErrorAcceso('Error al validar acceso: $e');
    }
  }

  void _manejarErrorAcceso(String mensaje) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('⚠️ $mensaje'),
        backgroundColor: Colors.red[900],
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && Navigator.canPop(context)) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    });
  }

  void responder(int puntos) {
    if (!_isAuthorized || _isNavigating) return;
    try {
      if (preguntaActual < 0 || preguntaActual >= preguntasBase.length) {
        _mostrarError('Error de navegación en preguntas');
        return;
      }
      final riasec = preguntasBase[preguntaActual].riasec;
      setState(() {
        puntajes[riasec] = (puntajes[riasec] ?? 0) + puntos;
        if (preguntaActual < preguntasBase.length - 1) {
          preguntaActual++;
        } else {
          mostrarResultados();
        }
      });
    } catch (e) {
      _mostrarError('Error al procesar respuesta: $e');
    }
  }

  void _mostrarError(String mensaje) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('❌ $mensaje'),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void mostrarResultados() {
    if (_isNavigating) return;
    _isNavigating = true;
    try {
      if (puntajes.values.every((p) => p == 0)) {
        _mostrarError('No se registraron respuestas válidas');
        _isNavigating = false;
        return;
      }
      final ordenados = puntajes.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
      final perfilPrimario = ordenados.isNotEmpty ? ordenados[0].key : 'S';
      final perfilSecundario = ordenados.length > 1 ? ordenados[1].key : 'S';
      final resultado = generarResultadoVocacional(principal: perfilPrimario, secundario: perfilSecundario);
      final recomendadas = getCarrerasPorRiasec(perfilPrimario);
      final nombreReal = _currentUser?.email?.split('@')[0] ?? widget.estudiante['nombre'] ?? 'Estudiante';
      final correoReal = _currentUser?.email ?? widget.estudiante['correo'] ?? 'sin-correo@vocacolombia.com';
      final institucionReal = widget.estudiante['institucion'] ?? 'VocaColombia';

      if (!mounted) { _isNavigating = false; return; }

      showDialog(
        context: context,
        barrierDismissible: false, // ✅ Esto SÍ es válido aquí
        builder: (context) => ResultadoDialog(
          nombre: nombreReal,
          institucion: institucionReal,
          correo: correoReal,
          perfilGanador: perfilPrimario,
          nombrePerfil: '${_nombrePerfil(perfilPrimario)} + ${_nombrePerfil(perfilSecundario)}',
          descripcionPerfil: resultado.descripcion,
          recomendadas: recomendadas,
          puntajes: Map.from(puntajes),
          onRepetir: () {
            if (mounted) {
              setState(() { preguntaActual = 0; puntajes.updateAll((k, v) => 0); });
              Navigator.pop(context);
              _isNavigating = false;
            }
          },
          onInicio: () {
            if (mounted && Navigator.canPop(context)) {
              Navigator.of(context).popUntil((route) => route.isFirst);
              _isNavigating = false;
            }
          },
        ),
      );
    } catch (e) {
      _mostrarError('Error al generar resultados: $e');
      _isNavigating = false;
    }
  }

  String _nombrePerfil(String codigo) {
    const perfiles = {'R': 'Realista', 'I': 'Investigador', 'A': 'Artístico', 'S': 'Social', 'E': 'Emprendedor', 'C': 'Convencional'};
    return perfiles[codigo] ?? codigo;
  }

  Widget _buildRespuestaButton(String texto, int valor, Color color) {
    return Semantics(
      label: 'Opción de respuesta: $texto',
      button: true,
      child: ElevatedButton(
        onPressed: _isNavigating ? null : () => responder(valor),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 55),
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(texto, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAuthorized) {
      return Scaffold(
        appBar: AppBar(title: const Text('🔐 Verificando acceso...'), backgroundColor: Colors.blue, foregroundColor: Colors.white, automaticallyImplyLeading: false),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (preguntaActual < 0 || preguntaActual >= preguntasBase.length) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error'), backgroundColor: Colors.red),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Error de navegación en el test', textAlign: TextAlign.center),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst), child: const Text('Volver al inicio')),
            ],
          ),
        ),
      );
    }
    final pregunta = preguntasBase[preguntaActual];
    final progreso = (preguntaActual + 1) / preguntasBase.length;

    return WillPopScope(
      onWillPop: () async {
        if (_isNavigating) return false;
        final salir = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('¿Salir del test?'),
            content: const Text('Tu progreso no se guardará. ¿Estás seguro?'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
              ElevatedButton(onPressed: () => Navigator.pop(context, true), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text('Salir')),
            ],
          ),
        );
        return salir ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pregunta ${preguntaActual + 1}/${preguntasBase.length}'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          actions: [IconButton(icon: const Icon(Icons.help_outline), onPressed: () => _mostrarAyuda(), tooltip: '¿Cómo responder?')],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TweenAnimationBuilder<double>(tween: Tween(begin: 0, end: progreso), duration: const Duration(milliseconds: 300), builder: (context, value, child) => LinearProgressIndicator(value: value)),
                const SizedBox(height: 24),
                Semantics(label: 'Pregunta ${preguntaActual + 1}: ${pregunta.texto}', child: Text(pregunta.texto, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, height: 1.4))),
                const Spacer(),
                _buildRespuestaButton('Poco', 1, Colors.orange),
                const SizedBox(height: 12),
                _buildRespuestaButton('Regular', 2, Colors.blue),
                const SizedBox(height: 12),
                _buildRespuestaButton('Mucho', 3, Colors.green),
                const Spacer(),
                Text('Progreso: ${((progreso) * 100).toInt()}%', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _mostrarAyuda() {
    showDialog(context: context, builder: (_) => AlertDialog(title: const Text('¿Cómo responder?'), content: const Text('Selecciona la opción que mejor describa tu interés:\n\n• Poco: No me interesa o no me veo haciéndolo\n• Regular: Me interesa moderadamente\n• Mucho: Me apasiona y me veo desarrollándolo'), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Entendido'))]));
  }
}

// ─────────────────────────────────────────────
// ✅ DIÁLOGO DE RESULTADOS
// ─────────────────────────────────────────────

class ResultadoDialog extends StatefulWidget {
  final String nombre, institucion, correo, perfilGanador, nombrePerfil, descripcionPerfil;
  final List<Carrera> recomendadas;
  final Map<String, int> puntajes;
  final VoidCallback onRepetir, onInicio;

  const ResultadoDialog({
    super.key, required this.nombre, required this.institucion, required this.correo,
    required this.perfilGanador, required this.nombrePerfil, required this.descripcionPerfil,
    required this.recomendadas, required this.puntajes, required this.onRepetir, required this.onInicio,
  });

  @override
  State<ResultadoDialog> createState() => _ResultadoDialogState();
}

class _ResultadoDialogState extends State<ResultadoDialog> {
  bool isLoading = false;
  String? _lastError;

  Future<void> _generarReporte() async {
    if (isLoading) return;
    setState(() { isLoading = true; _lastError = null; });
    try {
      if (widget.nombre.isEmpty || widget.correo.isEmpty) throw Exception('Datos de usuario incompletos para generar reporte');
      await generarPDF(
        nombre: widget.nombre, institucion: widget.institucion, correo: widget.correo,
        areaGanadora: '${widget.nombrePerfil} (${widget.perfilGanador})',
        carreras: widget.recomendadas.take(10).map((e) => e.nombre).toList(),
      );
      final db = DatabaseService();
      await db.guardarRegistro(
        datosPersonales: {'nombre': widget.nombre, 'institucion': widget.institucion, 'correo': widget.correo, 'timestamp': DateTime.now().toIso8601String()},
        resultados: {'perfil': widget.perfilGanador, 'perfil_nombre': widget.nombrePerfil, 'puntajes': widget.puntajes, 'total_preguntas': preguntasBase.length},
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('✅ Reporte generado y guardado correctamente'), backgroundColor: Colors.green, duration: Duration(seconds: 3)));
      }
    } catch (e) {
      final errorMsg = 'Error al generar reporte: ${e.toString().replaceAll('Exception: ', '')}';
      setState(() => _lastError = errorMsg);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ $errorMsg'), backgroundColor: Colors.red[900], duration: const Duration(seconds: 4),
            action: SnackBarAction(label: 'Reintentar', textColor: Colors.white, onPressed: _generarReporte),
          ),
        );
      }
      print('❌ Error en _generarReporte: $e');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog( // ✅ barrierDismissible ELIMINADO: NO es parámetro de AlertDialog
      title: const Row(children: [Icon(Icons.emoji_events, color: Colors.amber), SizedBox(width: 8), Text('🎓 Resultado Vocacional')]),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Estudiante: ${widget.nombre}', style: TextStyle(color: Colors.grey[700])),
          const SizedBox(height: 8),
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.blue.shade200)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(widget.nombrePerfil, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
              const SizedBox(height: 4),
              Text(widget.descripcionPerfil, style: TextStyle(fontSize: 14, color: Colors.grey[800])),
            ]),
          ),
          const SizedBox(height: 16),
          const Text('Carreras sugeridas:', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          const SizedBox(height: 8),
          ...widget.recomendadas.take(5).map((carrera) => Padding(padding: const EdgeInsets.symmetric(vertical: 3), child: Row(children: [const Icon(Icons.check_circle, size: 16, color: Colors.green), const SizedBox(width: 8), Expanded(child: Text(carrera.nombre)), Text(carrera.demanda, style: TextStyle(fontSize: 12, color: Colors.grey[600]))]))),
          if (_lastError != null) ...[const SizedBox(height: 12), Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.red[50], borderRadius: BorderRadius.circular(6)), child: Text(_lastError!, style: TextStyle(color: Colors.red[900], fontSize: 12)))],
        ]),
      ),
      actions: [
        TextButton(onPressed: isLoading ? null : widget.onInicio, child: const Text('Inicio')),
        TextButton(onPressed: isLoading ? null : widget.onRepetir, child: const Text('Repetir')),
        TextButton(onPressed: isLoading ? null : () => Navigator.push(context, MaterialPageRoute(builder: (_) => ResultsHistoryScreen())), child: const Text('Historial')),
        ElevatedButton.icon(
          onPressed: isLoading ? null : _generarReporte,
          icon: isLoading ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.picture_as_pdf),
          label: Text(isLoading ? 'Generando...' : 'PDF'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red[700], foregroundColor: Colors.white),
        ),
      ],
      // ✅ barrierDismissible ya está configurado en showDialog() → no se repite aquí
    );
  }
}