/*
import 'package:flutter/material.dart';
import 'package:project/features/common/ui/widgets/custom_app_bar.dart';
import 'package:project/features/student/alumni_info/service/fire_service.dart'; // Assuming this is the file with FirebaseService

class AlumniListScreen extends StatefulWidget {
  const AlumniListScreen({super.key});

  @override
  _AlumniListScreenState createState() => _AlumniListScreenState();
}

class _AlumniListScreenState extends State<AlumniListScreen> {
  late Future<List<Map<String, dynamic>>> _students;
  final FireServiceForAlumni _firebaseService = FireServiceForAlumni();

  @override
  void initState() {
    super.initState();
    _students = _firebaseService.fetchStudents(); // Fetch students from Firebase
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Alumni Info List',),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _students, // Fetch and display the student data here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No students available.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var student = snapshot.data![index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Student Full Name
                      Text(
                        student['full_name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Student Email Address
                      Text('Email: ${student['email_address']}'),
                      // Student Phone Number
                      Text('Phone: ${student['phone_number']}'),
                      // Student Batch Number
                      Text('Batch: ${student['batch_no']}'),
                      // Student Graduation Year
                      Text('Graduation Year: ${student['graduation_year']}'),
                      // Student Company Name
                      Text('Company: ${student['company_name']}'),
                      // LinkedIn Profile
                      Text(
                        'LinkedIn: ${student['linkedin_profile']}',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
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
*/

//todo phn tapable
/*import 'package:flutter/material.dart';
import 'package:project/features/common/ui/widgets/custom_app_bar.dart';
import 'package:project/features/student/alumni_info/service/fire_service.dart'; // Assuming this is the file with FirebaseService
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class AlumniListScreen extends StatefulWidget {
  const AlumniListScreen({super.key});

  @override
  _AlumniListScreenState createState() => _AlumniListScreenState();
}

class _AlumniListScreenState extends State<AlumniListScreen> {
  late Future<List<Map<String, dynamic>>> _students;
  final FireServiceForAlumni _firebaseService = FireServiceForAlumni();

  @override
  void initState() {
    super.initState();
    _students = _firebaseService.fetchStudents(); // Fetch students from Firebase
  }

  // Function to launch the phone dialer with the given phone number
  Future<void> _launchPhone(String phoneNumber) async {
    // Ensure phone number is formatted correctly
    final String cleanedPhone = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    final url = 'tel:$cleanedPhone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not dial $cleanedPhone';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Alumni Info List'),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _students, // Fetch and display the student data here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var student = snapshot.data![index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Student Full Name
                      Text(
                        student['full_name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Student Email Address
                      Text('Email: ${student['email_address']}'),
                      const SizedBox(height: 8),
                      // Tappable Phone Number
                      GestureDetector(
                        onTap: () => _launchPhone(student['phone_number']),
                        child: Text(
                          'Phone: ${student['phone_number']}',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Student Batch Number
                      Text('Batch: ${student['batch_no']}'),
                      // Student Graduation Year
                      Text('Graduation Year: ${student['graduation_year']}'),
                      // Student Company Name
                      Text('Company: ${student['company_name']}'),
                      // LinkedIn Profile
                      Text(
                        'LinkedIn: ${student['linkedin_profile']}',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
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



//todo working ektu check korio still
import 'package:flutter/material.dart';
import 'package:project/features/common/ui/widgets/custom_app_bar.dart';
import 'package:project/features/student/alumni_info/service/fire_service.dart'; // Assuming this is the file with FirebaseService
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class AlumniListScreen extends StatefulWidget {
  const AlumniListScreen({super.key});

  @override
  _AlumniListScreenState createState() => _AlumniListScreenState();
}

class _AlumniListScreenState extends State<AlumniListScreen> {
  late Future<List<Map<String, dynamic>>> _students;
  final FireServiceForAlumni _firebaseService = FireServiceForAlumni();

  @override
  void initState() {
    super.initState();
    _students = _firebaseService.fetchStudents(); // Fetch students from Firebase
  }

  // Function to launch the phone dialer with the given phone number
  Future<void> _launchPhone(String phoneNumber) async {
    final String cleanedPhone = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    final url = 'tel:$cleanedPhone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not dial $cleanedPhone';
    }
  }

  // Function to open LinkedIn profile URL in the browser
  Future<void> _launchLinkedIn(String linkedInUrl) async {
    final url = linkedInUrl.startsWith('http') ? linkedInUrl : 'https://$linkedInUrl';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open LinkedIn profile: $linkedInUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Alumni Info List'),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _students, // Fetch and display the student data here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No students available.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var student = snapshot.data![index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Student Full Name
                      Text(
                        student['full_name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Student Batch Number
                      Text('Batch: ${student['batch_no']}'),
                      // Student Graduation Year
                      Text('Graduation Year: ${student['graduation_year']}'),
                      // Student Company Name
                      Text('Company: ${student['company_name']}'),
                      const SizedBox(height: 8),
                      // Student Email Address
                      Text('Email: ${student['email_address']}'),
                      const SizedBox(height: 8),
                      // Tappable Phone Number
                      GestureDetector(
                        onTap: () => _launchPhone(student['phone_number']),
                        child: Text(
                          'Phone: ${student['phone_number']}',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Tappable LinkedIn Profile
                      GestureDetector(
                        onTap: () => _launchLinkedIn(student['linkedin_profile']),
                        child: Text(
                          'LinkedIn: ${student['linkedin_profile']}',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
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
