import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Map<String, int> riasec = {};
  Map<String, int> instituciones = {};

  bool loading = true;

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    final registros = await _db.collection('registros').get();
    final students = await _db.collection('students').get();

    final Map<String, int> contadorRiasec = {
      'Realista': 0,
      'Investigador': 0,
      'Artístico': 0,
      'Social': 0,
      'Emprendedor': 0,
      'Convencional': 0,
    };

    final Map<String, int> contadorInstituciones = {};

    for (var doc in registros.docs) {
      final data = doc.data();

      final resultados = data['resultados'];

      if (resultados is Map && resultados['perfil'] != null) {
        final perfil = resultados['perfil'].toString();

        if (contadorRiasec.containsKey(perfil)) {
          contadorRiasec[perfil] =
              contadorRiasec[perfil]! + 1;
        }
      }
    }

    for (var doc in students.docs) {
      final data = doc.data();

      final institucion =
          data['institucion']?.toString() ?? 'Sin asignar';

      contadorInstituciones[institucion] =
          (contadorInstituciones[institucion] ?? 0) + 1;
    }

    setState(() {
      riasec = contadorRiasec;
      instituciones = contadorInstituciones;
      loading = false;
    });
  }

  List<PieChartSectionData> buildRiasecChart() {
    final total = riasec.values.fold(0, (a, b) => a + b);

    if (total == 0) {
      return [
        PieChartSectionData(
          value: 1,
          title: 'Sin datos',
          color: Colors.grey,
        )
      ];
    }

    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
    ];

    int i = 0;

    return riasec.entries.map((e) {
      final percent = (e.value / total) * 100;

      final section = PieChartSectionData(
        value: e.value.toDouble(),
        title: '${percent.toStringAsFixed(1)}%',
        color: colors[i % colors.length],
        radius: 90,
      );

      i++;
      return section;
    }).toList();
  }

  BarChartData buildInstitucionesChart() {
    final keys = instituciones.keys.toList();

    return BarChartData(
      barGroups: List.generate(keys.length, (i) {
        final value = instituciones[keys[i]]!.toDouble();

        return BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: value,
              width: 18,
              color: Colors.blue,
            )
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📊 Dashboard Analítico PRO'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "📌 RIASEC Distribution",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: buildRiasecChart(),
                ),
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              "🏫 Instituciones",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 250,
              child: BarChart(
                buildInstitucionesChart(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}