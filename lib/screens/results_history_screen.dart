import 'package:flutter/material.dart';

import '../models/riasec_result_model.dart';
import '../services/riasec_analyzer.dart';
import '../services/test_service.dart';

class ResultsHistoryScreen extends StatelessWidget {
  ResultsHistoryScreen({super.key});

  final TestService _service = TestService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        const Text('📊 Historial Vocacional'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: StreamBuilder<List<RiasecResultModel>>(
        stream: _service.getResults(),

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child:
              CircularProgressIndicator(),
            );
          }

          final results = snapshot.data!;

          if (results.isEmpty) {
            return const Center(
              child: Text(
                'No hay resultados registrados.',
              ),
            );
          }

          return ListView.builder(
            itemCount: results.length,

            itemBuilder: (context, index) {
              final result = results[index];

              final dominant =
              RiasecAnalyzer.getDominantProfile(
                realista: result.realista,
                investigador:
                result.investigador,
                artistico: result.artistico,
                social: result.social,
                emprendedor:
                result.emprendedor,
                convencional:
                result.convencional,
              );

              return Card(
                margin: const EdgeInsets.all(10),

                child: ListTile(
                  leading: const Icon(
                    Icons.psychology,
                    color: Colors.blue,
                  ),

                  title:
                  Text(result.studentName),

                  subtitle: Text(
                    'Perfil dominante: $dominant',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}