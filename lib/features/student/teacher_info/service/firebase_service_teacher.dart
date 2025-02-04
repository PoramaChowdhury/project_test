import 'package:firebase_database/firebase_database.dart';

class FirebaseServiceForTeacher {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  // Fetch all staff from Firebase Realtime Database
  Future<List<Map<String, dynamic>>> fetchStaff() async {
    try {
      final snapshot = await _dbRef.child('users').get(); // Fetch data from 'users' node

      if (snapshot.exists) {
        // The snapshot is now a Map, not a List
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

        // Convert the data into a list of maps
        List<Map<String, dynamic>> staffList = [];

        // Loop through each staff entry and add it to the list
        data.forEach((key, value) {
          staffList.add({
            'Full name': value['Full name'],
            'Dept': value['Dept'],
            'Designation': value['Designation'],
            'Cell': value['Cell'],
            'Email': value['Email'],
          });
        });

        return staffList;
      } else {
        print("No data found in the database.");
        return []; // Return an empty list if no data exists
      }
    } catch (e) {
      print("Error fetching staff: $e");
      return []; // Return an empty list on error
    }
  }
}
