import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class EstadisticasScreen extends StatefulWidget {
  const EstadisticasScreen({super.key});

  @override
  State<EstadisticasScreen> createState() => _EstadisticasScreenState();
}

class _EstadisticasScreenState extends State<EstadisticasScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  bool _cargando = true;
  int _totalEstudiantes = 0;
  Map<String, int> _perfilesCounts = {};
  Map<String, int> _carrerasCounts = {};
  Map<String, int> _institucionesCounts = {};
  Map<String, int> _fechasCounts = {};

  final Map<String, Color> _coloresRiasec = {
    'R': const Color(0xFFE53935),
    'I': const Color(0xFF1E88E5),
    'A': const Color(0xFF8E24AA),
    'S': const Color(0xFF43A047),
    'E': const Color(0xFFFF8F00),
    'C': const Color(0xFF00ACC1),
  };

  final Map<String, String> _nombresRiasec = {
    'R': 'Realista',
    'I': 'Investigador',
    'A': 'Artistico',
    'S': 'Social',
    'E': 'Emprendedor',
    'C': 'Convencional',
  };

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    final snapshot = await _db
        .collection('estudiantes')
        .orderBy('fecha_registro', descending: false)
        .get();

    final perfiles = <String, int>{};
    final carreras = <String, int>{};
    final instituciones = <String, int>{};
    final fechas = <String, int>{};

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final resultados = data['resultados'] ?? {};
      final perfil = resultados['perfil_riasec'] ?? 'N/A';
      perfiles[perfil] = (perfiles[perfil] ?? 0) + 1;
      final listaCarreras =
          (resultados['carreras_sugeridas'] as List?)?.take(1) ?? [];
      for (final c in listaCarreras) {
        carreras[c] = (carreras[c] ?? 0) + 1;
      }
      final inst = data['institucion'] ?? 'Sin institucion';
      instituciones[inst] = (instituciones[inst] ?? 0) + 1;
      if (data['fecha_registro'] != null) {
        final fecha = (data['fecha_registro'] as Timestamp).toDate();
        final mes = '${fecha.year}-${fecha.month.toString().padLeft(2, '0')}';
        fechas[mes] = (fechas[mes] ?? 0) + 1;
      }
    }

    setState(() {
      _totalEstudiantes = snapshot.docs.length;
      _perfilesCounts = perfiles;
      _carrerasCounts = Map.fromEntries(
        carreras.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
      );
      _institucionesCounts = Map.fromEntries(
        instituciones.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value)),
      );
      _fechasCounts = fechas;
      _cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadisticas'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              setState(() => _cargando = true);
              _cargarDatos();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : _totalEstudiantes == 0
              ? const Center(
                  child: Text('Sin datos aun',
                      style: TextStyle(color: Colors.grey)))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _tarjetaTotal(),
                      const SizedBox(height: 20),
                      _titulo('Perfiles RIASEC'),
                      const SizedBox(height: 12),
                      _graficaPie(),
                      const SizedBox(height: 20),
                      if (_fechasCounts.isNotEmpty) ...[
                        _titulo('Registros por Mes'),
                        const SizedBox(height: 12),
                        _graficaLineas(),
                        const SizedBox(height: 20),
                      ],
                      _titulo('Top Carreras Sugeridas'),
                      const SizedBox(height: 12),
                      _graficaBarras(),
                      const SizedBox(height: 20),
                      _titulo('Instituciones'),
                      const SizedBox(height: 12),
                      _listaInstituciones(),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
    );
  }

  Widget _tarjetaTotal() {
    return Card(
      color: Colors.blue[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(Icons.people, color: Colors.white, size: 40),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Estudiantes',
                    style: TextStyle(color: Colors.white70, fontSize: 14)),
                Text('$_totalEstudiantes',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _titulo(String texto) {
    return Text(texto,
        style:
            const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget _graficaPie() {
    final secciones = _perfilesCounts.entries.map((e) {
      final color = _coloresRiasec[e.key] ?? Colors.grey;
      final pct = (e.value / _totalEstudiantes * 100).toStringAsFixed(1);
      return PieChartSectionData(
        value: e.value.toDouble(),
        color: color,
        title: '${e.key}\n$pct%',
        radius: 80,
        titleStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
      );
    }).toList();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
                height: 220,
                child: PieChart(PieChartData(sections: secciones))),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: _perfilesCounts.entries.map((e) {
                final color = _coloresRiasec[e.key] ?? Colors.grey;
                final nombre = _nombresRiasec[e.key] ?? e.key;
                return Row(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                          color: color, shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  Text('$nombre (${e.value})',
                      style: const TextStyle(fontSize: 12)),
                ]);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _graficaLineas() {
    final meses = _fechasCounts.keys.toList()..sort();
    final spots = meses.asMap().entries
        .map((e) =>
            FlSpot(e.key.toDouble(), _fechasCounts[e.value]!.toDouble()))
        .toList();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 200,
          child: LineChart(LineChartData(
            gridData: const FlGridData(show: true),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final idx = value.toInt();
                    if (idx >= 0 && idx < meses.length) {
                      return Text(meses[idx].substring(5),
                          style: const TextStyle(fontSize: 10));
                    }
                    return const Text('');
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) => Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontSize: 10)),
                ),
              ),
              topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false)),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: Colors.blue[800],
                barWidth: 3,
                dotData: const FlDotData(show: true),
                belowBarData: BarAreaData(
                    show: true, color: Colors.blue.withOpacity(0.15)),
              ),
            ],
          )),
        ),
      ),
    );
  }

  Widget _graficaBarras() {
    final top5 = _carrerasCounts.entries.take(5).toList();
    final colores = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red
    ];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: BarChart(BarChartData(
                alignment: BarChartAlignment.spaceAround,
                barGroups: top5.asMap().entries.map((e) {
                  return BarChartGroupData(x: e.key, barRods: [
                    BarChartRodData(
                      toY: e.value.value.toDouble(),
                      color: colores[e.key % colores.length],
                      width: 20,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ]);
                }).toList(),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        if (idx >= 0 && idx < top5.length) {
                          final nombre = top5[idx].key;
                          final corto = nombre.length > 10
                              ? '${nombre.substring(0, 10)}...'
                              : nombre;
                          return Text(corto,
                              style: const TextStyle(fontSize: 8),
                              textAlign: TextAlign.center);
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) => Text(
                          value.toInt().toString(),
                          style: const TextStyle(fontSize: 10)),
                    ),
                  ),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
              )),
            ),
            const SizedBox(height: 12),
            ...top5.asMap().entries.map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(children: [
                    Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                            color: colores[e.key % colores.length],
                            borderRadius: BorderRadius.circular(2))),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Text('${e.value.key} (${e.value.value})',
                            style: const TextStyle(fontSize: 12))),
                  ]),
                )),
          ],
        ),
      ),
    );
  }

  Widget _listaInstituciones() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: _institucionesCounts.entries.take(10).map((e) {
            final pct = e.value / _totalEstudiantes;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(e.key,
                              style: const TextStyle(fontSize: 13),
                              overflow: TextOverflow.ellipsis)),
                      Text('${e.value} est.',
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: pct,
                    backgroundColor: Colors.grey[200],
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.blue[800]!),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
