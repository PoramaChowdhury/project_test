import 'package:firebase_database/firebase_database.dart';

class FirebaseResource {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  // Fetch all subjects from the Firebase Realtime Database
  Future<Map<String, dynamic>> fetchSubjects() async {
    try {
      final snapshot = await _dbRef.child('resource/subjects').get();

      if (snapshot.exists) {
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

        // Convert the Firebase data to a Map<String, dynamic> structure
        Map<String, dynamic> subjectsMap = {};

        data.forEach((key, value) {
          subjectsMap[key] = value; // Add subject with its links
        });

        return subjectsMap;
      } else {
        print("No subjects data found in the database.");
        return {}; // Return an empty map if no data exists
      }
    } catch (e) {
      print("Error fetching subjects: $e");
      return {}; // Return an empty map on error
    }
  }
}