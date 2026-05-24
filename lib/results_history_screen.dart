import 'package:flutter/material.dart';

import 'services.dart';

class ResultsHistoryScreen
    extends StatefulWidget {
  const ResultsHistoryScreen({
    super.key,
  });

  @override
  State<ResultsHistoryScreen>
  createState() =>
      _ResultsHistoryScreenState();
}

class _ResultsHistoryScreenState
    extends State<ResultsHistoryScreen> {
  final DatabaseService db =
  DatabaseService();

  List<Map<String, dynamic>> registros =
  [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    final data =
    await db.obtenerRegistros();

    if (!mounted) return;

    setState(() {
      registros = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '📊 Historial Vocacional',
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: registros.isEmpty
          ? const Center(
        child: Text(
          'No hay registros.',
        ),
      )
          : ListView.builder(
        itemCount: registros.length,

        itemBuilder: (
            context,
            index,
            ) {
          final data =
          registros[index];

          final datos =
          data['datosPersonales'];

          final resultados =
          data['resultados'];

          return Card(
            margin:
            const EdgeInsets.all(
              10,
            ),

            child: ListTile(
              leading:
              const CircleAvatar(
                backgroundColor:
                Colors.blue,

                child: Icon(
                  Icons.psychology,
                  color: Colors.white,
                ),
              ),

              title: Text(
                datos['nombre'] ??
                    'Sin nombre',
              ),

              subtitle: Text(
                'Perfil: ${resultados['perfil_nombre']}',
              ),
            ),
          );
        },
      ),
    );
  }
}