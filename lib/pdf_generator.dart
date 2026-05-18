// 📁 lib/pdf_generator.dart

import 'package:flutter/foundation.dart'; // ✅ Para detectar kIsWeb
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class _PerfilTemperamento {
  final String temperamento;
  final String caracter;
  const _PerfilTemperamento(this.temperamento, this.caracter);
}

_PerfilTemperamento _obtenerPerfil(String area) {
  final a = area.toLowerCase();
  if (a.contains('realista') || a.contains('tecnologia'))
    return const _PerfilTemperamento('Racional y Logico', 'Metodico y Estructurado');
  if (a.contains('investigador') || a.contains('salud'))
    return const _PerfilTemperamento('Empatico y Servicial', 'Cuidadoso y Observador');
  if (a.contains('artistico') || a.contains('arte'))
    return const _PerfilTemperamento('Creativo y Expresivo', 'Innovador y Sensible');
  if (a.contains('social') || a.contains('sociales'))
    return const _PerfilTemperamento('Comunicativo y Justo', 'Lider y Persuasivo');
  if (a.contains('emprendedor') || a.contains('negocios'))
    return const _PerfilTemperamento('Emprendedor y Competitivo', 'Estrategico y Organizado');
  if (a.contains('convencional'))
    return const _PerfilTemperamento('Organizado y Preciso', 'Detallista y Confiable');
  return const _PerfilTemperamento('Proactivo', 'Analitico');
}

Future<void> generarPDF({
  required String nombre,
  required String institucion,
  required String correo,
  required String areaGanadora,
  required List<String> carreras,
}) async {
  final pdf = pw.Document();
  final logoData = await rootBundle.load('assets/images/logo_logoterapia.png');
  final logoImage = pw.MemoryImage(logoData.buffer.asUint8List());
  final perfil = _obtenerPerfil(areaGanadora);

  final estiloSeccion = pw.TextStyle(
    fontSize: 16,
    fontWeight: pw.FontWeight.bold,
    color: PdfColors.blue900,
  );

  pw.Widget seccion(String titulo, List<pw.Widget> contenido) =>
      pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Text(titulo, style: estiloSeccion),
        pw.SizedBox(height: 8),
        ...contenido,
        pw.SizedBox(height: 20),
      ]);

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      header: (_) => pw.Center(
        child: pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 16),
          child: pw.Image(logoImage, width: 120, height: 120),
        ),
      ),
      // ✅ Footer correcto para MultiPage (reemplaza pw.Spacer)
      footer: (_) => pw.Center(
        child: pw.Text(
          'Generado por App Orientacion Vocacional - 2026',
          style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey),
        ),
      ),
      build: (_) => [
        pw.Center(
          child: pw.Text(
            'REPORTE DE ORIENTACION VOCACIONAL',
            style: pw.TextStyle(
              fontSize: 22,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue900,
            ),
          ),
        ),
        pw.SizedBox(height: 16),
        pw.Divider(color: PdfColors.blue900),
        pw.SizedBox(height: 16),

        seccion('DATOS DEL ESTUDIANTE', [
          pw.Text('Nombre: $nombre'),
          pw.Text('Institucion: $institucion'),
          pw.Text('Correo: $correo'),
        ]),

        seccion('RESULTADO DEL TEST', [
          pw.Text(
            'Area Recomendada: ${areaGanadora.toUpperCase()}',
            style: pw.TextStyle(
              color: PdfColors.blue,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ]),

        seccion('PERFIL DE TEMPERAMENTO', [
          pw.Text('- Temperamento: ${perfil.temperamento}'),
          pw.Text('- Caracter: ${perfil.caracter}'),
        ]),

        seccion('CARRERAS SUGERIDAS', [
          ...carreras.map((c) => pw.Text('- $c')),
        ]),
      ],
    ),
  );

  // ✅ Fix principal: comportamiento diferente según plataforma
  final bytes = await pdf.save();

  if (kIsWeb) {
    // En web: descarga directa sin layoutPdf (evita el error de Flex)
    await Printing.sharePdf(
      bytes: bytes,
      filename: 'reporte_vocacional_${nombre.replaceAll(' ', '_')}.pdf',
    );
  } else {
    // En móvil/desktop: diálogo de impresión normal
    await Printing.layoutPdf(
      onLayout: (_) async => bytes,
    );
  }
}