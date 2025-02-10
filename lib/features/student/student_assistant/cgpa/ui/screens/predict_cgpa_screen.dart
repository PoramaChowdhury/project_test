import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/features/student/student_assistant/cgpa/data/model/semester.dart';
import 'package:project/features/student/student_assistant/cgpa/ui/screens/cgpa.dart';

class PredictScreen extends StatefulWidget {
  final List<Semester> existingSemesters;

  const PredictScreen({Key? key, required this.existingSemesters}) : super(key: key);

  @override
  State<PredictScreen> createState() => _PredictScreenState();
}

class _PredictScreenState extends State<PredictScreen> {
  final List<Course> _predictedCourses = [];
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController courseCreditController = TextEditingController();
  final TextEditingController courseGradeController = TextEditingController();

  // Fetch previous semesters data from Firebase again, if needed
  Future<void> _loadDataFromFirebase() async {
    String? userId = await FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('student_cgpa')
        .doc(userId)
        .collection('semesters')
        .get();

    for (var doc in snapshot.docs) {
      Semester semester = Semester();
      List<dynamic> courses = doc['courses'];
      for (var course in courses) {
        semester.addCourse(course['name'], course['credit'], course['gradePoint']);
      }
      widget.existingSemesters.add(semester);
    }
    setState(() {});
  }

  void _addCourse() {
    if (courseNameController.text.isNotEmpty &&
        courseCreditController.text.isNotEmpty &&
        courseGradeController.text.isNotEmpty) {
      double credit = double.parse(courseCreditController.text);
      double cg = double.parse(courseGradeController.text);

      setState(() {
        _predictedCourses.add(Course(courseNameController.text, credit, cg));
      });

      // Clear the text fields
      courseNameController.clear();
      courseCreditController.clear();
      courseGradeController.clear();
    }
  }

  void _calculatePredictedCGPA() {
    double totalCredits = 0;
    double totalPoints = 0;

    // Calculate CGPA from existing semesters
    for (var semester in widget.existingSemesters) {
      totalCredits += semester.totalCredits;
      totalPoints += semester.totalPoints;
    }

    // Add predicted semester data
    for (var course in _predictedCourses) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predict CGPA'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display predicted courses
            Expanded(
              child: ListView.builder(
                itemCount: _predictedCourses.length,
                itemBuilder: (context, index) {
                  final course = _predictedCourses[index];
                  return ListTile(
                    title: Text(course.name),
                    subtitle: Text(
                        'Credits: ${course.credit}, Grade Point: ${course.cg}'),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: courseNameController,
                    decoration: const InputDecoration(hintText: 'Course Name'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: courseCreditController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Course Credit'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: courseGradeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Grade Point'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addCourse,
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _calculatePredictedCGPA,
              child: const Text('Predict CGPA'),
            ),
          ],
        ),
      ),
    );
  }
}