import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/app/app_colors.dart';
import 'package:project/features/common/ui/widgets/custom_app_bar.dart';
import 'package:project/features/common/ui/widgets/custom_snakebar.dart';

class SeatBookingScreen extends StatefulWidget {
  @override
  _SeatBookingScreenState createState() => _SeatBookingScreenState();
}

class _SeatBookingScreenState extends State<SeatBookingScreen> {
  DateTime? selectedDate;
  String? selectedRoute;
  String? selectedSlot;
  String? studentUid; // Variable to store student's UID


  // List of available routes and time slots
  List<String> routes = ["Route 1", "Route 2", "Route 3", "Route 4"];
  List<String> slots = ["8 AM", "9 AM", "10 AM", "11 AM", "1 PM"];

  // Function to get the current user's UID (for multiple students)
  void _getUserUid() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        studentUid = user.uid; // Store UID of logged-in user
      });
    } else {
      // Handle user not logged in case
      /*ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please log in to book a seat')),
      );*/
      //todo called getx used snackbar
      showSnackBarMessage(context, 'Please log in to book a seat');
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserUid(); // Fetch the UID of the student
  }


  // Function to select the date
  void _selectDate() async {
    final DateTime currentDate = DateTime.now();
    final DateTime maxDate =
    currentDate.add(Duration(days: 7)); // Maximum one week ahead

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? currentDate,
      firstDate: currentDate,
      // Prevent past dates
      lastDate: maxDate,
      // Prevent dates beyond one week
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.themeColor,
            hintColor: AppColors.themeColor,
            buttonTheme:
            const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  // Function to book a seat
  // void _bookSeat() {
  //   if (selectedDate != null && selectedRoute != null && selectedSlot != null) {
  //     FirebaseFirestore.instance.collection('Bookings').add({
  //       'studentName': 'Student',
  //       // Replace with the actual student name if required
  //       'route': selectedRoute,
  //       'date': selectedDate,
  //       'timeSlot': selectedSlot,
  //     });
  //
  //     // Show confirmation dialog
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Icon(Icons.check_circle,
  //             color: AppColors.themeColor, size: 40),
  //         content: Text(
  //           'Your seat has been booked for $selectedRoute at $selectedSlot on ${selectedDate?.toLocal().toString().split(' ')[0]}',
  //           style: const TextStyle(fontSize: 16),
  //         ),
  //         actions: <Widget>[
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             style: ElevatedButton.styleFrom(
  //                 backgroundColor: AppColors.themeColor),
  //             child: const Text('OK', style: TextStyle(color: Colors.white)),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }

  // Function to book a seat
  void _bookSeat() {
    if (selectedDate != null && selectedRoute != null && selectedSlot != null &&
        studentUid != null) {
      FirebaseFirestore.instance.collection('Bookings').add({
        'studentUid': studentUid,
        // Save UID of the student
        'studentName': 'Student',
        // Replace with the actual student name if required
        'route': selectedRoute,
        'date': selectedDate,
        'timeSlot': selectedSlot,
      }).then((value) {
        // Show confirmation dialog
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: const Icon(
                    Icons.check_circle, color: AppColors.themeColor, size: 40),
                content: Text(
                  'Your seat has been booked for $selectedRoute at $selectedSlot on ${selectedDate
                      ?.toLocal().toString().split(' ')[0]}',
                  style: const TextStyle(fontSize: 16),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.themeColor),
                    child: const Text(
                        'OK', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
        );
      }).catchError((error) {
        /*ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to book seat: $error')),
        );*/
        //todo called getx used snackbar
        showSnackBarMessage(context, 'Failed to book seat: $error');
      });
    } else {
      /*ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all the details')),
      );*/
      //todo called getx used snackbar
      showSnackBarMessage(context, 'Please fill in all the details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Book Bus Seat'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            // Select Date Card
            Card(
              elevation: 8.0,
              shadowColor: AppColors.themeColor.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Date',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.themeColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: AppColors.themeColor),
                      ),
                      child: ElevatedButton(
                        onPressed: _selectDate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          selectedDate == null
                              ? 'Select Date'
                              : 'Selected Date: ${selectedDate?.toLocal().toString().split(' ')[0]}',
                          style: TextStyle(
                            fontSize: 16,
                            color: selectedDate == null
                                ? AppColors.themeColor
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Select Route Card
            Card(
              elevation: 8.0,
              shadowColor: AppColors.themeColor.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Route',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.themeColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButton<String>(
                      value: selectedRoute,
                      isExpanded: true,
                      hint: const Text("Select Route"),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedRoute = newValue;
                        });
                      },
                      items:
                      routes.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Select Time Slot Card
            Card(
              elevation: 8.0,
              shadowColor: AppColors.themeColor.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Time Slot',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.themeColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButton<String>(
                      value: selectedSlot,
                      isExpanded: true,
                      hint: const Text("Select Time Slot"),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSlot = newValue;
                        });
                      },
                      items:
                      slots.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Book Seat Button
            ElevatedButton(
              onPressed: _bookSeat,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.themeColor,
                foregroundColor: Colors.white,
                fixedSize: const Size.fromWidth(double.maxFinite),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                'Book Seat',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}