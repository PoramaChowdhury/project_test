import 'package:firebase_database/firebase_database.dart';

class FireServiceForAlumni {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  // Fetch all students from Firebase Realtime Database
  Future<List<Map<String, dynamic>>> fetchStudents() async {
    try {
      // Correct path: 'users'
      final snapshot = await _dbRef.child('alumni/users').get();

      if (snapshot.exists) {
        // Extract data from the snapshot
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

        List<Map<String, dynamic>> studentsList = [];

        // Loop through the data and add student details to the list
        data.forEach((key, value) {
          studentsList.add({
            'full_name': value['full_name'],
            'batch_no': value['batch_no'],
            'graduation_year': value['graduation_year'],
            'company_name': value['company_name'],
            'email_address': value['email_address'],
            'phone_number': value['phone_number'],
            'linkedin_profile': value['linkedin_profile'],
          });
        });

        return studentsList;
      } else {
        print("No student data found in the database.");
        return []; // Return an empty list if no data exists
      }
    } catch (e) {
      print("Error fetching students: $e");
      return []; // Return an empty list on error
    }
  }
}
