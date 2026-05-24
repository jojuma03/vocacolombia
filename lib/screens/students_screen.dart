// 📁 lib/screens/students_screen.dart

import 'package:flutter/material.dart';

import '../models/student_model.dart';
import '../services/firestore_service.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() =>
      _StudentsScreenState();
}

class _StudentsScreenState
    extends State<StudentsScreen> {
  final FirestoreService _service =
  FirestoreService();

  final TextEditingController nombreController =
  TextEditingController();

  final TextEditingController edadController =
  TextEditingController();

  final TextEditingController gradoController =
  TextEditingController();

  final TextEditingController
  institucionController =
  TextEditingController();

  // ======================================================
  // 🔥 AGREGAR ESTUDIANTE
  // ======================================================

  Future<void> _addStudent() async {
    if (nombreController.text.trim().isEmpty ||
        edadController.text.trim().isEmpty ||
        gradoController.text.trim().isEmpty ||
        institucionController.text
            .trim()
            .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '⚠️ Completa todos los campos',
          ),
        ),
      );
      return;
    }

    final student = StudentModel(
      id: '',
      nombre: nombreController.text.trim(),
      edad:
      int.tryParse(edadController.text) ??
          0,
      grado: gradoController.text.trim(),
      institucion:
      institucionController.text.trim(),
      perfilVocacional: 'Sin definir',
    );

    try {
      await _service.addStudent(student);

      nombreController.clear();
      edadController.clear();
      gradoController.clear();
      institucionController.clear();

      if (mounted) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              '✅ Estudiante guardado correctamente',
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '❌ Error: $e',
          ),
        ),
      );
    }
  }

  // ======================================================
  // 🔥 FORMULARIO
  // ======================================================

  void _showForm() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            '👨‍🎓 Agregar Estudiante',
          ),

          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nombreController,
                  decoration:
                  const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: edadController,
                  keyboardType:
                  TextInputType.number,
                  decoration:
                  const InputDecoration(
                    labelText: 'Edad',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: gradoController,
                  decoration:
                  const InputDecoration(
                    labelText: 'Grado',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller:
                  institucionController,
                  decoration:
                  const InputDecoration(
                    labelText: 'Institución',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),

            ElevatedButton.icon(
              onPressed: _addStudent,
              icon: const Icon(Icons.save),
              label: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  // ======================================================
  // 🔥 UI
  // ======================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '👨‍🎓 Estudiantes',
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      floatingActionButton:
      FloatingActionButton(
        onPressed: _showForm,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),

      body: StreamBuilder<List<StudentModel>>(
        stream: _service.getStudents(),

        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child:
              CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                '❌ Error: ${snapshot.error}',
              ),
            );
          }

          final students = snapshot.data ?? [];

          if (students.isEmpty) {
            return const Center(
              child: Text(
                'No hay estudiantes registrados',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: students.length,

            itemBuilder: (context, index) {
              final s = students[index];

              return Card(
                margin:
                const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),

                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                    Colors.blue,
                    child: Text(
                      s.nombre.isNotEmpty
                          ? s.nombre[0]
                          .toUpperCase()
                          : '?',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),

                  title: Text(
                    s.nombre,
                    style: const TextStyle(
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(
                    'Edad: ${s.edad}\n'
                        'Grado: ${s.grado}\n'
                        'Institución: ${s.institucion}',
                  ),

                  isThreeLine: true,

                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),

                    onPressed: () async {
                      await _service
                          .deleteStudent(s.id);
                    },
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