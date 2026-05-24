// 📁 lib/widgets/charts/riasec_radar_chart.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class RiasecRadarChart extends StatelessWidget {

  final Map<String, int> scores;

  const RiasecRadarChart({
    super.key,
    required this.scores,
  });

  double _value(String key) {
    return scores[key]?.toDouble() ?? 0;
  }

  @override
  Widget build(BuildContext context) {

    final values = [

      _value('Realista'),
      _value('Investigador'),
      _value('Artístico'),
      _value('Social'),
      _value('Emprendedor'),
      _value('Convencional'),
    ];

    final maxValue =
    values.reduce(
          (a, b) => a > b ? a : b,
    );

    final scale =
    maxValue <= 10
        ? 10.0
        : maxValue;

    return Card(

      elevation: 3,

      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(24),
      ),

      child: Padding(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [

            Text(

              'Perfil Vocacional RIASEC',

              style: TextStyle(
                fontSize: 20,
                fontWeight:
                FontWeight.bold,
                color:
                Colors.blue.shade800,
              ),
            ),

            const SizedBox(height: 20),

            AspectRatio(

              aspectRatio: 1.2,

              child: RadarChart(

                RadarChartData(

                  radarShape:
                  RadarShape.polygon,

                  tickCount: 5,

                  ticksTextStyle:
                  TextStyle(
                    color:
                    Colors.grey.shade600,
                    fontSize: 10,
                  ),

                  tickBorderData:
                  BorderSide(
                    color:
                    Colors.grey.shade300,
                  ),

                  gridBorderData:
                  BorderSide(
                    color:
                    Colors.blue.shade100,
                    width: 1,
                  ),

                  radarBorderData:
                  BorderSide(
                    color:
                    Colors.blue.shade700,
                    width: 2,
                  ),

                  titlePositionPercentageOffset:
                  0.18,

                  getTitle:
                      (index, angle) {

                    const titles = [

                      'R',
                      'I',
                      'A',
                      'S',
                      'E',
                      'C',
                    ];

                    return RadarChartTitle(
                      text:
                      titles[index],

                      angle: angle,
                    );
                  },

                  borderData:
                  FlBorderData(
                    show: false,
                  ),

                  radarTouchData:
                  RadarTouchData(
                    enabled: true,
                  ),

                  dataSets: [

                    RadarDataSet(

                      fillColor:
                      Colors.blue
                          .withOpacity(
                        0.25,
                      ),

                      borderColor:
                      Colors.blue.shade800,

                      borderWidth: 3,

                      entryRadius: 4,

                      dataEntries:
                      values
                          .map(
                            (value) =>
                            RadarEntry(
                              value:
                              value /
                                  scale,
                            ),
                      )
                          .toList(),
                    ),
                  ],
                ),

                swapAnimationDuration:
                const Duration(
                  milliseconds: 500,
                ),

                swapAnimationCurve:
                Curves.easeInOut,
              ),
            ),

            const SizedBox(height: 20),

            Wrap(

              spacing: 12,
              runSpacing: 10,

              alignment:
              WrapAlignment.center,

              children: const [

                _LegendItem(
                  label: 'R = Realista',
                ),

                _LegendItem(
                  label:
                  'I = Investigador',
                ),

                _LegendItem(
                  label:
                  'A = Artístico',
                ),

                _LegendItem(
                  label: 'S = Social',
                ),

                _LegendItem(
                  label:
                  'E = Emprendedor',
                ),

                _LegendItem(
                  label:
                  'C = Convencional',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// 🏷️ LEYENDA
// =====================================================

class _LegendItem extends StatelessWidget {

  final String label;

  const _LegendItem({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
      const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),

      decoration: BoxDecoration(

        color:
        Colors.blue.shade50,

        borderRadius:
        BorderRadius.circular(12),
      ),

      child: Text(

        label,

        style: TextStyle(
          fontSize: 12,
          color:
          Colors.blue.shade800,
          fontWeight:
          FontWeight.w500,
        ),
      ),
    );
  }
}