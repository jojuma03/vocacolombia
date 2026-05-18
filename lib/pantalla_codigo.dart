import 'package:flutter/material.dart';
import 'pantalla_introduccion.dart';

class PantallaCodigo extends StatefulWidget {
  const PantallaCodigo({super.key});

  @override
  State<PantallaCodigo> createState() => _PantallaCodigoState();
}

class _PantallaCodigoState extends State<PantallaCodigo> {

  final TextEditingController _controladorCodigo =
  TextEditingController();

  String _mensajeError = '';

  // 🔐 Código de acceso
  final String _codigoCorrecto = 'ORIENTA2025';

  void _verificarCodigo() {

    if (_controladorCodigo.text.trim() ==
        _codigoCorrecto) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
          const PantallaIntroduccion(),
        ),
      );

    } else {

      setState(() {
        _mensajeError =
        'Código incorrecto. Solicita autorización.';
      });
    }
  }

  @override
  void dispose() {
    _controladorCodigo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1565C0),
              Color(0xFF0D47A1),
            ],
          ),
        ),

        child: Center(

          child: SingleChildScrollView(

            padding: const EdgeInsets.all(24),

            child: Card(

              elevation: 10,

              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(18),
              ),

              child: Padding(

                padding: const EdgeInsets.all(30),

                child: Column(

                  mainAxisSize: MainAxisSize.min,

                  children: [

                    const Icon(
                      Icons.lock_outline,
                      size: 70,
                      color: Color(0xFF1565C0),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Acceso Restringido',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1565C0),
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Herramienta exclusiva para estudiantes autorizados.',
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 25),

                    TextField(

                      controller: _controladorCodigo,

                      obscureText: true,

                      textAlign: TextAlign.center,

                      style: const TextStyle(
                        fontSize: 22,
                        letterSpacing: 5,
                      ),

                      decoration: InputDecoration(

                        labelText:
                        'Código de acceso',

                        hintText: '••••••••',

                        prefixIcon:
                        const Icon(Icons.key),

                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(14),
                        ),

                        errorText:
                        _mensajeError.isNotEmpty
                            ? _mensajeError
                            : null,
                      ),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(

                      width: double.infinity,
                      height: 52,

                      child: ElevatedButton(

                        onPressed: _verificarCodigo,

                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(0xFF1565C0),
                          foregroundColor:
                          Colors.white,
                        ),

                        child: const Text(
                          'INGRESAR',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Si no tienes código, consulta con tu orientador.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}