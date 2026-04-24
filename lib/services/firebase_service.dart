import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final _db = FirebaseFirestore.instance;

  // Exam Form Submit
  static Future<void> submitExam(
    String name,
    String id,
    Map<String, bool> subjects,
  ) async {
    await _db.collection("exam_forms").add({
      "name": name,
      "student_id": id,
      "subjects": subjects,
      "created_at": FieldValue.serverTimestamp(),
    });
  }

  // Contact Form Submit
  static Future<void> submitContact(
    String name,
    String email,
    String message,
  ) async {
    await _db.collection("contacts").add({
      "name": name,
      "email": email,
      "message": message,
      "created_at": FieldValue.serverTimestamp(),
    });
  }
}