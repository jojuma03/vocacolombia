import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'dart:typed_data';
import 'dart:convert';

class ExcelService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> descargarExcel() async {
    final snapshot = await _db
        .collection('estudiantes')
        .orderBy('fecha_registro', descending: true)
        .get();

    final excel = Excel.createExcel();
    final Sheet hoja = excel['Resultados'];

    hoja.appendRow([
      TextCellValue('Nombre'),
      TextCellValue('Institucion'),
      TextCellValue('Correo'),
      TextCellValue('Telefono'),
      TextCellValue('Ciudad'),
      TextCellValue('Perfil RIASEC'),
      TextCellValue('Perfil Nombre'),
      TextCellValue('Carreras Sugeridas'),
      TextCellValue('Puntaje R'),
      TextCellValue('Puntaje I'),
      TextCellValue('Puntaje A'),
      TextCellValue('Puntaje S'),
      TextCellValue('Puntaje E'),
      TextCellValue('Puntaje C'),
      TextCellValue('Fecha'),
    ]);

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final resultados = data['resultados'] ?? {};
      final puntajes = resultados['puntajes'] ?? {};
      final carreras =
          (resultados['carreras_sugeridas'] as List?)?.join(', ') ?? '';
      final fecha = data['fecha_registro'] != null
          ? (data['fecha_registro'] as Timestamp)
              .toDate()
              .toString()
              .substring(0, 10)
          : 'Sin fecha';

      hoja.appendRow([
        TextCellValue(data['nombre'] ?? ''),
        TextCellValue(data['institucion'] ?? ''),
        TextCellValue(data['correo'] ?? ''),
        TextCellValue(data['telefono'] ?? ''),
        TextCellValue(data['ciudad'] ?? ''),
        TextCellValue(resultados['perfil_riasec'] ?? ''),
        TextCellValue(resultados['perfil_nombre'] ?? ''),
        TextCellValue(carreras),
        TextCellValue(puntajes['R']?.toString() ?? '0'),
        TextCellValue(puntajes['I']?.toString() ?? '0'),
        TextCellValue(puntajes['A']?.toString() ?? '0'),
        TextCellValue(puntajes['S']?.toString() ?? '0'),
        TextCellValue(puntajes['E']?.toString() ?? '0'),
        TextCellValue(puntajes['C']?.toString() ?? '0'),
        TextCellValue(fecha),
      ]);
    }

    final bytes = excel.encode();
    if (bytes != null && kIsWeb) {
      final b64 = base64Encode(Uint8List.fromList(bytes));
      print('EXCEL_DOWNLOAD:$b64');
    }
  }
}
