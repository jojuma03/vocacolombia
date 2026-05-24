import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRoleService {
  final _db = FirebaseFirestore.instance;

  Future<String> getRole() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return 'guest';

    final doc = await _db.collection('users').doc(user.uid).get();

    if (!doc.exists) return 'guest';

    return doc.data()?['role'] ?? 'guest';
  }
}