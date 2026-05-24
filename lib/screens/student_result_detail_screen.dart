// 📁 lib/screens/student_result_detail_screen.dart
// Vista detallada del perfil vocacional RIASEC

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/charts/riasec_radar_chart.dart';

class StudentResultDetailScreen extends StatefulWidget {

  final String studentName;
  final String studentEmail;

  const StudentResultDetailScreen({
    super.key,
    required this.studentName,
    required this.studentEmail,
  });

  @override
  State<StudentResultDetailScreen> createState() =>
      _StudentResultDetailScreenState();
}

class _StudentResultDetailScreenState
    extends State<StudentResultDetailScreen> {

  // =====================================================
  // 📊 PUNTAJES RIASEC
  // =====================================================

  Map<String, int> puntajes = {};

  // =====================================================
  // 🔄 ESTADOS
  // =====================================================

  bool _loading = true;

  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchResult();
  }

  // =====================================================
  // 🔍 OBTENER RESULTADO
  // =====================================================

  Future<void> _fetchResult() async {

    try {

      final query = await FirebaseFirestore.instance
          .collection('results')

          .where(
        'studentEmail',
        isEqualTo: widget.studentEmail,
      )

          .orderBy(
        'completedAt',
        descending: true,
      )

          .limit(1)
          .get();

      // =====================================================
      // 📭 SIN RESULTADOS
      // =====================================================

      if (query.docs.isEmpty) {

        setState(() {

          puntajes = {};

          _loading = false;
        });

        return;
      }

      // =====================================================
      // ✅ RESULTADO ENCONTRADO
      // =====================================================

      final data =
      query.docs.first.data();

      setState(() {

        puntajes = {

          'Realista':
          _parseScore(
            data['realista'],
          ),

          'Investigador':
          _parseScore(
            data['investigador'],
          ),

          'Artístico':
          _parseScore(
            data['artistico'],
          ),

          'Social':
          _parseScore(
            data['social'],
          ),

          'Emprendedor':
          _parseScore(
            data['emprendedor'],
          ),

          'Convencional':
          _parseScore(
            data['convencional'],
          ),
        };

        _loading = false;
      });

    } catch (e) {

      setState(() {

        _loading = false;

        _errorMessage =
        'Error cargando resultados.\n\n$e';
      });
    }
  }

  // =====================================================
  // 🛡️ SEGURIDAD PARA PUNTAJES
  // =====================================================

  int _parseScore(dynamic value) {

    if (value == null) {
      return 0;
    }

    if (value is int) {
      return value;
    }

    return int.tryParse(
      value.toString(),
    ) ??
        0;
  }

  // =====================================================
  // 🏆 PERFIL DOMINANTE
  // =====================================================

  String get perfilDominante {

    if (puntajes.isEmpty) {
      return 'Sin datos';
    }

    final top =
    puntajes.entries.reduce(
          (a, b) =>
      a.value > b.value
          ? a
          : b,
    );

    return top.key;
  }

  // =====================================================
  // 🎨 UI PRINCIPAL
  // =====================================================

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      Colors.grey.shade100,

      appBar: AppBar(

        title: Text(
          widget.studentName,
        ),

        backgroundColor:
        Colors.blue.shade800,

        foregroundColor:
        Colors.white,

        elevation: 0,
      ),

      body: _loading

      // =====================================================
      // 🔄 LOADING
      // =====================================================

          ? const Center(
        child:
        CircularProgressIndicator(),
      )

      // =====================================================
      // ❌ ERROR
      // =====================================================

          : _errorMessage != null

          ? _buildErrorState()

      // =====================================================
      // 📭 SIN RESULTADOS
      // =====================================================

          : puntajes.isEmpty

          ? _buildEmptyState()

      // =====================================================
      // ✅ RESULTADOS
      // =====================================================

          : _buildResultView(),
    );
  }

  // =====================================================
  // ❌ ERROR
  // =====================================================

  Widget _buildErrorState() {

    return Center(

      child: Padding(

        padding:
        const EdgeInsets.all(24),

        child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            const Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red,
            ),

            const SizedBox(height: 20),

            Text(

              _errorMessage ??
                  'Error inesperado',

              textAlign:
              TextAlign.center,

              style:
              const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // 📭 SIN RESULTADOS
  // =====================================================

  Widget _buildEmptyState() {

    return Center(

      child: Padding(

        padding:
        const EdgeInsets.all(24),

        child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Icon(
              Icons.assignment_outlined,

              size: 90,

              color:
              Colors.orange.shade400,
            ),

            const SizedBox(height: 20),

            Text(

              '${widget.studentName} aún no ha realizado el test vocacional.',

              textAlign:
              TextAlign.center,

              style:
              const TextStyle(
                fontSize: 18,
                fontWeight:
                FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // ✅ RESULTADOS
  // =====================================================

  Widget _buildResultView() {

    return SingleChildScrollView(

      padding:
      const EdgeInsets.all(20),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          // =====================================================
          // 🏆 PERFIL DOMINANTE
          // =====================================================

          Card(

            elevation: 3,

            shape:
            RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
                20,
              ),
            ),

            child: Padding(

              padding:
              const EdgeInsets.all(
                20,
              ),

              child: Row(

                children: [

                  CircleAvatar(

                    radius: 32,

                    backgroundColor:
                    Colors.blue.shade100,

                    child: Icon(

                      Icons.emoji_events,

                      color:
                      Colors.blue.shade800,

                      size: 36,
                    ),
                  ),

                  const SizedBox(
                    width: 18,
                  ),

                  Expanded(

                    child: Column(

                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                      children: [

                        Text(

                          'Perfil Dominante',

                          style: TextStyle(
                            color:
                            Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(
                          height: 6,
                        ),

                        Text(

                          perfilDominante,

                          style: TextStyle(
                            fontSize: 26,
                            fontWeight:
                            FontWeight.bold,

                            color:
                            Colors.blue
                                .shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 28),

          // =====================================================
          // 📊 RADAR CHART
          // =====================================================

          RiasecRadarChart(
            scores: puntajes,
          ),

          const SizedBox(height: 30),

          // =====================================================
          // 📈 TÍTULO PUNTAJES
          // =====================================================

          const Text(

            'Desglose de Puntajes',

            style: TextStyle(
              fontSize: 20,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          // =====================================================
          // 📋 LISTA PUNTAJES
          // =====================================================

          ...puntajes.entries.map(

                (entry) {

              return Card(

                elevation: 1,

                margin:
                const EdgeInsets.only(
                  bottom: 12,
                ),

                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                    16,
                  ),
                ),

                child: Padding(

                  padding:
                  const EdgeInsets.all(
                    16,
                  ),

                  child: Row(

                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,

                    children: [

                      // =====================================================
                      // 🧠 ÁREA
                      // =====================================================

                      Expanded(

                        child: Text(

                          entry.key,

                          style:
                          const TextStyle(
                            fontSize: 16,

                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                      ),

                      // =====================================================
                      // 📊 PUNTAJE
                      // =====================================================

                      Container(

                        padding:
                        const EdgeInsets
                            .symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),

                        decoration:
                        BoxDecoration(

                          color:
                          Colors.blue
                              .shade800,

                          borderRadius:
                          BorderRadius
                              .circular(
                            14,
                          ),
                        ),

                        child: Text(

                          '${entry.value} pts',

                          style:
                          const TextStyle(
                            color:
                            Colors.white,

                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}