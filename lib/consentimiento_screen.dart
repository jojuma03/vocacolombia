import 'package:flutter/material.dart';
import 'test_screen.dart';

// ============================================================
//  ConsentimientoScreen - Ley 1581 de 2012
//  Responsable: Marcelo Gutiérrez Pineda
// ============================================================

class ConsentimientoScreen extends StatefulWidget {
  final VoidCallback? onAceptar;

  const ConsentimientoScreen({super.key, this.onAceptar});

  @override
  State<ConsentimientoScreen> createState() => _ConsentimientoScreenState();
}

class _ConsentimientoScreenState extends State<ConsentimientoScreen> {
  // ✅ Controllers para capturar datos del estudiante
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _institucionController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _ciudadController = TextEditingController();

  bool _aceptoDatos = false;
  bool _aceptoTerminos = false;
  final TextEditingController _correoAcudiente = TextEditingController();
  bool _mostrarCampoAcudiente = false;

  // ✅ Clave de formulario para validación
  final _formKey = GlobalKey<FormState>();

  bool get _puedoContinuar => _aceptoDatos && _aceptoTerminos;

  // ✅ Validar que todos los campos estén completos
  bool get _datosCompletos {
    return _nombreController.text.trim().isNotEmpty &&
        _institucionController.text.trim().isNotEmpty &&
        _correoController.text.trim().isNotEmpty &&
        _ciudadController.text.trim().isNotEmpty &&
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_correoController.text.trim());
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _institucionController.dispose();
    _correoController.dispose();
    _telefonoController.dispose();
    _ciudadController.dispose();
    _correoAcudiente.dispose();
    super.dispose();
  }

  // ✅ Navegar al TestScreen con los datos capturados
  void _navegarAlTest() {
    if (_formKey.currentState!.validate() && _datosCompletos && _puedoContinuar) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TestScreen(
            estudiante: {
              'nombre': _nombreController.text.trim(),
              'institucion': _institucionController.text.trim(),
              'correo': _correoController.text.trim(),
              'telefono': _telefonoController.text.trim(),
              'ciudad': _ciudadController.text.trim(),
              'correo_acudiente': _mostrarCampoAcudiente
                  ? _correoAcudiente.text.trim()
                  : '',
            },
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Por favor completa todos los campos obligatorios y acepta los términos.'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A237E),
      body: SafeArea(
        child: Column(
          children: [
            // ── ENCABEZADO ──────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.shield_outlined,
                        color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 16),
                  const Text('Registro y Consentimiento',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  Text('Tus datos están protegidos por la Ley 1581 de 2012',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.85), fontSize: 15),
                      textAlign: TextAlign.center),
                ],
              ),
            ),

            // ── CONTENIDO CON SCROLL ───────────────────────
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(28)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── FORMULARIO DE REGISTRO ──────────
                        const Text('📝 Tus Datos',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A237E))),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _nombreController,
                          decoration: InputDecoration(
                            labelText: 'Nombre completo *',
                            hintText: 'Ej: Juan Pérez García',
                            prefixIcon: const Icon(Icons.person_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Campo obligatorio';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),

                        TextFormField(
                          controller: _institucionController,
                          decoration: InputDecoration(
                            labelText: 'Institución educativa *',
                            hintText: 'Ej: Colegio Nacional',
                            prefixIcon: const Icon(Icons.school_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Campo obligatorio';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),

                        TextFormField(
                          controller: _correoController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Correo electrónico *',
                            hintText: 'Ej: juan@email.com',
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Campo obligatorio';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                              return 'Correo inválido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),

                        TextFormField(
                          controller: _telefonoController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Teléfono (opcional)',
                            hintText: 'Ej: 304 661 5420',
                            prefixIcon: const Icon(Icons.phone_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        TextFormField(
                          controller: _ciudadController,
                          decoration: InputDecoration(
                            labelText: 'Ciudad o municipio *',
                            hintText: 'Ej: Bogotá, Medellín...',
                            prefixIcon: const Icon(Icons.location_city_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Campo obligatorio';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 24),

                        // ── INFO DE PRIVACIDAD ──────────────
                        const _SeccionInfo(
                          icono: Icons.emoji_objects_outlined,
                          color: Color(0xFF1A237E),
                          titulo: '¿Para qué es esta app?',
                          contenido:
                          'Esta herramienta es completamente gratuita y fue creada para ayudarte a descubrir qué carreras se conectan mejor con tus actitudes y aptitudes.\n\nNo tiene fines comerciales ni publicidad. Su único propósito es acompañarte en una decisión importante de tu vida.',
                        ),
                        const SizedBox(height: 16),
                        const _SeccionInfo(
                          icono: Icons.data_usage_outlined,
                          color: Color(0xFF4527A0),
                          titulo: '¿Qué información recopilamos?',
                          contenido:
                          '• Nombre y apellido\n• Institución educativa\n• Correo electrónico\n• Ciudad o municipio\n• Respuestas del test vocacional\n\nNO recopilamos contraseñas, información financiera ni redes sociales.',
                        ),
                        const SizedBox(height: 16),
                        const _SeccionInfo(
                          icono: Icons.analytics_outlined,
                          color: Color(0xFF283593),
                          titulo: '¿Para qué usamos tus datos?',
                          contenido:
                          '• Generar tu reporte vocacional\n• Mejorar la herramienta\n• Ofrecer orientación profesional\n• Crear estadísticas anónimas\n\nTus datos NO se venden y NO se comparten con terceros.',
                        ),
                        const SizedBox(height: 20),

                        // ── RESPONSABLE ──────────────────────
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(14),
                            border:
                            Border.all(color: const Color(0xFFE0E0E0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.person_outline, size: 18,
                                      color: Color(0xFF1A237E)),
                                  SizedBox(width: 8),
                                  Text('Responsable del tratamiento de datos',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Color(0xFF1A237E))),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const _DatoResponsable(
                                  label: 'Nombre', valor: 'Marcelo Gutiérrez Pineda'),
                              const _DatoResponsable(
                                  label: 'Profesión',
                                  valor: 'Psicólogo Organizacional · Filósofo · Ciencias Económicas y Políticas'),
                              const _DatoResponsable(
                                  label: 'Contacto', valor: '304 661 5420'),
                              const _DatoResponsable(
                                  label: 'Correo', valor: 'johannchelo@gmail.com'),
                              const SizedBox(height: 6),
                              Text(
                                'Ley 1581 de 2012 — Protección de datos personales, Colombia.',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[500],
                                    fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // ── ACUDIENTE (Menores) ───────────────
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF8E1),
                            borderRadius: BorderRadius.circular(12),
                            border:
                            Border.all(color: const Color(0xFFFFE082)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.family_restroom, size: 18,
                                      color: Color(0xFFF57F17)),
                                  const SizedBox(width: 8),
                                  const Expanded(
                                    child: Text('¿Eres menor de 18 años?',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Color(0xFFF57F17))),
                                  ),
                                  Switch(
                                    value: _mostrarCampoAcudiente,
                                    activeColor: const Color(0xFFF57F17),
                                    onChanged: (v) => setState(
                                            () => _mostrarCampoAcudiente = v),
                                  ),
                                ],
                              ),
                              if (_mostrarCampoAcudiente) ...[
                                const SizedBox(height: 10),
                                const Text(
                                  'Puedes ingresar el correo de tu acudiente para que también reciba el reporte.',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xFF5D4037)),
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: _correoAcudiente,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: 'Correo del acudiente',
                                    prefixIcon:
                                    const Icon(Icons.mail_outline, size: 18),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // ── CHECKBOXES ────────────────────────
                        _CheckConsentimiento(
                          valor: _aceptoDatos,
                          onChanged: (v) =>
                              setState(() => _aceptoDatos = v!),
                          texto: 'Autorizo el tratamiento de mis datos personales conforme a la Ley 1581 de 2012.',
                        ),
                        const SizedBox(height: 12),
                        _CheckConsentimiento(
                          valor: _aceptoTerminos,
                          onChanged: (v) =>
                              setState(() => _aceptoTerminos = v!),
                          texto: 'Entiendo que esta herramienta es gratuita y que puedo solicitar la eliminación de mis datos cuando lo desee.',
                        ),
                        const SizedBox(height: 32),

                        // ── BOTÓN ─────────────────────────────
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _navegarAlTest,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1A237E),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text(
                              _puedoContinuar && _datosCompletos
                                  ? 'Continuar al test vocacional →'
                                  : 'Completa los campos y acepta los términos',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Text(
                            'johannchelo@gmail.com · 304 661 5420',
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey[500]),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── WIDGETS AUXILIARES ─────────────────────────────────────

class _SeccionInfo extends StatelessWidget {
  final IconData icono;
  final Color color;
  final String titulo;
  final String contenido;

  const _SeccionInfo({
    required this.icono,
    required this.color,
    required this.titulo,
    required this.contenido,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icono, size: 18, color: color),
              const SizedBox(width: 8),
              Text(titulo,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: color)),
            ],
          ),
          const SizedBox(height: 8),
          Text(contenido,
              style: const TextStyle(fontSize: 13, height: 1.55)),
        ],
      ),
    );
  }
}

class _DatoResponsable extends StatelessWidget {
  final String label;
  final String valor;

  const _DatoResponsable({
    required this.label,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text('$label:',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Text(valor, style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

class _CheckConsentimiento extends StatelessWidget {
  final bool valor;
  final ValueChanged<bool?> onChanged;
  final String texto;

  const _CheckConsentimiento({
    required this.valor,
    required this.onChanged,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!valor),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: valor
              ? const Color(0xFF1A237E).withOpacity(0.07)
              : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: valor
                ? const Color(0xFF1A237E).withOpacity(0.4)
                : Colors.grey[300]!,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: valor,
              onChanged: onChanged,
              activeColor: const Color(0xFF1A237E),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(texto,
                  style: const TextStyle(fontSize: 13, height: 1.5)),
            ),
          ],
        ),
      ),
    );
  }
}