// 📁 lib/screens/teacher_students_screen.dart
// Lista de estudiantes para Docentes

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'student_result_detail_screen.dart';

class TeacherStudentsScreen extends StatelessWidget {
  const TeacherStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.blue.shade50,

      appBar: AppBar(
        title: const Text('👥 Mis Estudiantes'),

        backgroundColor:
        Colors.blue.shade800,

        foregroundColor: Colors.white,

        elevation: 0,
      ),

      body: StreamBuilder<QuerySnapshot>(

        stream: FirebaseFirestore.instance
            .collection('users')
            .where('role', isEqualTo: 'student')
        // Sin orderBy → usa índice automático
            .snapshots(),

        builder: (context, snapshot) {

          // =====================================================
          // 🔄 CARGANDO
          // =====================================================

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child:
              CircularProgressIndicator(),
            );
          }

          // =====================================================
          // ❌ ERROR
          // =====================================================

          if (snapshot.hasError) {

            return Center(
              child: Padding(
                padding:
                const EdgeInsets.all(24),

                child: Text(
                  '❌ Error cargando estudiantes:\n\n${snapshot.error}',

                  textAlign: TextAlign.center,

                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }

          // =====================================================
          // 📭 SIN ESTUDIANTES
          // =====================================================

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {

            return const Center(
              child: Text(
                'No hay estudiantes registrados aún.',

                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            );
          }

          // =====================================================
          // ✅ LISTA
          // =====================================================

          final students =
              snapshot.data!.docs;

          return ListView.builder(

            padding:
            const EdgeInsets.all(16),

            itemCount: students.length,

            itemBuilder: (context, index) {

              final student =
              students[index];

              final data =
              student.data()
              as Map<String, dynamic>;

              // =====================================================
              // 📌 DATOS
              // =====================================================

              final email =
                  data['email']
                      ?.toString() ??
                      'Sin correo';

              final name =
                  data['name']
                      ?.toString() ??
                      email.split('@')[0];

              final uid =
                  student.id;

              // =====================================================
              // 🎨 CARD
              // =====================================================

              return Card(

                elevation: 2,

                margin:
                const EdgeInsets.only(
                  bottom: 14,
                ),

                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                    14,
                  ),
                ),

                child: ListTile(

                  contentPadding:
                  const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),

                  leading: CircleAvatar(

                    backgroundColor:
                    Colors.blue.shade700,

                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),

                  // =====================================================
                  // 👤 NOMBRE
                  // =====================================================

                  title: Text(

                    name,

                    style: const TextStyle(
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  // =====================================================
                  // 📧 EMAIL + UID
                  // =====================================================

                  subtitle: Column(

                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                    children: [

                      const SizedBox(
                        height: 4,
                      ),

                      Text(email),

                      const SizedBox(
                        height: 4,
                      ),

                      Text(
                        'UID: ${uid.substring(0, 8)}...',

                        style: TextStyle(
                          color:
                          Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),

                  // =====================================================
                  // 🚀 ABRIR PERFIL VOCACIONAL
                  // =====================================================

                  onTap: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>
                            StudentResultDetailScreen(

                              studentName: name,

                              studentEmail: email,
                            ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}