/*import 'package:firebase_database/firebase_database.dart';

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
}*/

///sorted_list

import 'package:firebase_database/firebase_database.dart';

class FirebaseServiceForTeacher {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  // Fetch all staff from Firebase Realtime Database
  Future<List<Map<String, dynamic>>> fetchStaff() async {
    try {
      final snapshot = await _dbRef
          .child('sorted/users')
          .get(); // Fetch data from 'users' node

      if (snapshot.exists) {
        // Check if the data is a Map or a List
        if (snapshot.value is Map) {
          // If it's a Map, we handle it as a Map (indexed by 0, 1, 2, etc.)
          Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

          List<Map<String, dynamic>> staffList = [];

          // Loop through each index (e.g., "0", "1", "2"...), and extract staff data
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
        } else if (snapshot.value is List) {
          // If it's a List, we handle it as a List of staff data
          List<dynamic> data = snapshot.value as List<dynamic>;

          List<Map<String, dynamic>> staffList = [];

          // Loop through the List and extract staff data
          for (var staff in data) {
            staffList.add({
              'Full name': staff['Full name'],
              'Dept': staff['Dept'],
              'Designation': staff['Designation'],
              'Cell': staff['Cell'],
              'Email': staff['Email'],
            });
          }

          return staffList;
        } else {
          print("Unexpected data format in Firebase.");
          return []; // Return empty list if data format is not expected
        }
      } else {
        print("No staff data found in the database.");
        return []; // Return an empty list if no data exists
      }
    } catch (e) {
      print("Error fetching staff: $e");
      return []; // Return an empty list on error
    }
  }
}
