///tap able phone email
import 'package:flutter/material.dart';
import 'package:project/features/common/ui/widgets/custom_app_bar.dart';
import 'package:project/features/student/teacher_info/service/firebase_service_teacher.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class TeacherInfoListScreen extends StatefulWidget {
  const TeacherInfoListScreen({super.key});

  @override
  _TeacherInfoListScreenState createState() => _TeacherInfoListScreenState();
}

class _TeacherInfoListScreenState extends State<TeacherInfoListScreen> {
  late Future<List<Map<String, dynamic>>> _teacher;
  final FirebaseServiceForTeacher _firebaseService = FirebaseServiceForTeacher();

  @override
  void initState() {
    super.initState();
    _teacher = _firebaseService.fetchStaff(); // Fetch staff data from Firebase
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

  Future<void> _launchEmail(String email) async {
    // Clean the email: For this example, we ensure there are no unnecessary spaces
    final String cleanedEmail = email.trim();

    // Regex to check if the email is in a valid format
    final emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(cleanedEmail)) {
      throw 'Invalid email format: $cleanedEmail';
    }

    final subject = 'Subject goes here'; // Customize as needed
    final body = 'Body of the email goes here'; // Customize as needed

    final encodedSubject = Uri.encodeComponent(subject);
    final encodedBody = Uri.encodeComponent(body);

    final url = 'mailto:$cleanedEmail?subject=$encodedSubject&body=$encodedBody';

    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not open email client for $cleanedEmail';
      }
    } catch (e) {
      print("Error launching email client: $e");
      throw 'Error launching email client';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Teacher Info List',),
      body: FutureBuilder<List<Map<String,
      dynamic >>> ( // Fetch and display staff data
      future: _teacher,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No staff available.'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            var staff = snapshot.data![index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: ${staff['Full name']}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Dept: ${staff['Dept']}',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Designation: ${staff['Designation']}',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        GestureDetector(
                          onTap: () => _launchPhone(staff['Cell']),
                          child: Text(
                            'Cell: ${staff['Cell']}',
                            style: TextStyle(fontSize: 14, color: Colors.blue),
                          ),
                        ),
                        SizedBox(height: 4),
                        GestureDetector(
                          onTap: () => _launchEmail(staff['Email']),
                          child: Text(
                            'Email: ${staff['Email']}',
                            style: TextStyle(fontSize: 14, color: Colors.blue),
                          ),
                        ),
                      ],
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
