import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/features/common/ui/widgets/custom_snakebar.dart';
import 'package:project/features/student/student_assistant/cgpa/data/model/semester.dart';
import 'package:project/features/student/student_assistant/cgpa/ui/screens/predict_cgpa_screen.dart';
import 'package:project/features/student/student_assistant/cgpa/ui/widgets/semester_widget.dart';

class CgpaCalculatorWithUid extends StatefulWidget {
  const CgpaCalculatorWithUid({super.key});

  @override
  State<CgpaCalculatorWithUid> createState() => _CgpaCalculatorWithUidState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CgpaCalculatorWithUidState extends State<CgpaCalculatorWithUid> {
  final List<Semester> _semesters = [];

  @override
  void initState() {
    super.initState();
    _loadDataFromFirebase();
  }

  Future<String?> _getUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid; // Fetch the UID of the current user
  }

  // Load data from Firestore based on UID
  void _loadDataFromFirebase() async {
    String? userId = await _getUserId();
    if (userId == null) return;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('student_cgpa')
        .doc(userId)
        .collection('semesters')
        .get();

    // Map Firestore data to the Semester object
    for (var doc in snapshot.docs) {
      Semester semester = Semester();
      List<dynamic> courses = doc['courses'];
      for (var course in courses) {
        semester.addCourse(course['name'], course['credit'], course['gradePoint']);
      }
      _semesters.add(semester);
    }
    setState(() {});
  }

  // Add a new semester locally
  void _addSemester() {
    setState(() {
      _semesters.add(Semester());
    });
  }

  // Calculate CGPA and show it in a dialog
  void _calculateCGPA() {
    double totalCredits = 0;
    double totalPoints = 0;

    for (var semester in _semesters) {
      totalCredits += semester.totalCredits;
      totalPoints += semester.totalPoints;
    }

    double cgpa = totalCredits > 0 ? totalPoints / totalCredits : 0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('CGPA Calculation'),
          content: Text('Your current CGPA is: ${cgpa.toStringAsFixed(2)}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  //todo  Navigate to the prediction screen
  void _navigateToPredictScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PredictScreen(
          existingSemesters: _semesters,
        ),
      ),
    );
  }

  // Calculate CGPA with the predicted semester
/*
  void _predictCGPA(List<Course> predictedCourses) {
    double totalCredits = 0;
    double totalPoints = 0;

    for (var semester in _semesters) {
      totalCredits += semester.totalCredits;
      totalPoints += semester.totalPoints;
    }

    // Add the predicted semester's courses to the calculation
    for (var course in predictedCourses) {
      totalCredits += course.credit;
      totalPoints += (course.credit * course.cg);
    }

    double cgpa = totalCredits > 0 ? totalPoints / totalCredits : 0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Predicted CGPA'),
          content: Text('Your predicted CGPA is: ${cgpa.toStringAsFixed(2)}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
*/
//todo added predict

  // Save the data to Firebase Firestore based on UID
  void _saveDataToFirebase() async {
    String? userId = await _getUserId();
    if (userId == null) return;

    // Iterate over the semesters and save them to Firestore
    for (int i = 0; i < _semesters.length; i++) {
      Semester semester = _semesters[i];
      List<Map<String, dynamic>> courseData = semester.courses.map((course) {
        return {
          'name': course.name,
          'credit': course.credit,
          'gradePoint': course.cg,
        };
      }).toList();

      await FirebaseFirestore.instance
          .collection('student_cgpa')
          .doc(userId)
          .collection('semesters')
          .doc('semester_$i')
          .set({
        'courses': courseData,
        'totalCredits': semester.totalCredits,
        'totalPoints': semester.totalPoints,
      });
    }

    //todo called getx used snackbar
    showSnackBarMessage(context,'Data saved successfully!');
  }

  void _deleteSemester(int index) async {
    String? userId = await _getUserId();
    if (userId == null) return;

    await FirebaseFirestore.instance
        .collection('student_cgpa')
        .doc(userId)
        .collection('semesters')
        .doc('semester_$index')
        .delete();

    setState(() {
      _semesters.removeAt(index);
    });

    //todo called getx used snackbar
    showSnackBarMessage(context,'Semester deleted successfully!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: const Text('CGPA Calculator'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF66B2B2),
                Color(0xFF66B2B2),
              ],
            ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(11, 11),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveDataToFirebase,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _semesters.length,
                  itemBuilder: (context, index) {
                    return SemesterWidget(
                      semesterNumber: index + 1,
                      semester: _semesters[index],
                      onRemoveSemester: () => _deleteSemester(index),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _addSemester,
                      child: const Text('Add Semester'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _calculateCGPA,
                      child: const Text('Calculate CGPA'),
                    ),
                  ),

                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _navigateToPredictScreen,
                      child: const Text('Predict CGPA'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Course {
  final String name;
  final double credit;
  final double cg;

  Course(this.name, this.credit, this.cg);
}



