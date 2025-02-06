/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/features/common/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:project/features/common/ui/widgets/custom_app_bar.dart';

class StudentCount extends StatefulWidget {
  static const String name = '/student-count';


  @override
  _StudentCountState createState() => _StudentCountState();
}

class _StudentCountState extends State<StudentCount> {
  // Function to get the stream of bookings from Firestore
  Stream<QuerySnapshot> getBookingsStream() {
    return FirebaseFirestore.instance.collection('Bookings').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Transport Authority View',
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getBookingsStream(), // Stream of bookings
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CenteredCircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("No bookings yet"));
          }

          var bookings = snapshot.data!.docs;

          // This map will store bookings categorized by date -> route -> slot
          Map<String, Map<String, Map<String, int>>> bookingCount = {};

          for (var booking in bookings) {
            String route = booking['route']; // Get the route from the booking
            String slot =
                booking['timeSlot']; // Get the time slot from the booking
            Timestamp timestamp =
                booking['date']; // Get the timestamp of the booking
            String date = timestamp
                .toDate()
                .toLocal()
                .toString()
                .split(' ')[0]; // Extract date in "YYYY-MM-DD" format

            // Initialize the data structure if it doesn't exist
            if (!bookingCount.containsKey(date)) {
              bookingCount[date] = {}; // Add new date
            }
            if (!bookingCount[date]!.containsKey(route)) {
              bookingCount[date]![route] = {}; // Add new route for the date
            }
            if (!bookingCount[date]![route]!.containsKey(slot)) {
              bookingCount[date]![route]![slot] =
                  0; // Initialize slot count as 0
            }

            // Increment the booking count for this route and slot
            bookingCount[date]![route]![slot] =
                bookingCount[date]![route]![slot]! + 1;
          }

          // Sort the dates in ascending order
          var sortedDates = bookingCount.keys.toList()..sort();

          return ListView.builder(
            itemCount: sortedDates.length, // Count of dates
            itemBuilder: (context, index) {
              String date = sortedDates[index]; // Get the date
              var routes = bookingCount[date]!; // Get the routes for this date

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('Date: $date'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: routes.keys.map((route) {
                      var slots =
                          routes[route]!; // Get the slots for this route
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: slots.keys.map((slot) {
                          return Text(
                              '$slot: ${slots[slot]} students'); // Display the number of students for this slot
                        }).toList(),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/features/common/ui/widgets/app_bar_logout.dart';
import 'package:project/features/common/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:project/features/common/ui/widgets/custom_app_bar.dart';

class StudentCount extends StatefulWidget {
  static const String name = '/student-count';

  @override
  _StudentCountState createState() => _StudentCountState();
}

class _StudentCountState extends State<StudentCount> {
  Stream<QuerySnapshot> getBookingsStream() {
    return FirebaseFirestore.instance.collection('Bookings').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //todo add new appbar with logout
      appBar: const AppBarLogout(
        title: 'Transport Authority View',
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getBookingsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CenteredCircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("No bookings yet"));
          }

          var bookings = snapshot.data!.docs;

          Map<String, Map<String, Map<String, int>>> bookingCount = {};

          for (var booking in bookings) {
            String route = booking['route'];
            String slot = booking['timeSlot'];
            Timestamp timestamp = booking['date'];
            String date = timestamp.toDate().toLocal().toString().split(' ')[0];

            bookingCount.putIfAbsent(date, () => {});
            bookingCount[date]!.putIfAbsent(route, () => {});
            bookingCount[date]![route]!.putIfAbsent(slot, () => 0);

            bookingCount[date]![route]![slot] = bookingCount[date]![route]![slot]! + 1;
          }

          var sortedDates = bookingCount.keys.toList()..sort();

          return ListView.builder(
            itemCount: sortedDates.length,
            itemBuilder: (context, index) {
              String date = sortedDates[index];
              var routes = bookingCount[date]!;

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('Date: $date'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: routes.entries.map((entry) { // Iterate through route entries
                      String route = entry.key;
                      var slots = entry.value;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Route : $route", style: const TextStyle(fontWeight: FontWeight.bold)), // Display the route name
                          ...slots.entries.map((slotEntry) { // Iterate through slot entries
                            String slot = slotEntry.key;
                            int count = slotEntry.value;
                            return Text('$slot: $count students');
                          }).toList(),
                        ],
                      );
                    }).toList(),
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