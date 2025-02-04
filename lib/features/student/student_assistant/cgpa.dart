import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/app/app_colors.dart';
import 'package:project/features/common/ui/widgets/custom_snakebar.dart';

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

    /*ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data saved successfully!')),
    );*/
    //todo called getx used snackbar
    showSnackBarMessage(context,'Data saved successfully!');
  }

  // Delete a semester both locally and in Firestore
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

    /*ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Semester deleted successfully!')),
    );*/
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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF66B2B2),
                Color(0xFF66B2B2),
              ],
            ),
            borderRadius: const BorderRadius.vertical(
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
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _calculateCGPA,
                      child: const Text('Calculate CGPA'),
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

class Semester {
  final List<Course> courses = [];

  void addCourse(String name, double credit, double cg) {
    courses.add(Course(name, credit, cg));
  }

  double get totalCredits => courses.fold(0, (sum, course) => sum + course.credit);

  double get totalPoints => courses.fold(0, (sum, course) => sum + (course.credit * course.cg));

  double get gpa => totalCredits > 0 ? totalPoints / totalCredits : 0;
}

class Course {
  final String name;
  final double credit;
  final double cg;

  Course(this.name, this.credit, this.cg);
}

class SemesterWidget extends StatefulWidget {
  final int semesterNumber;
  final Semester semester;
  final VoidCallback onRemoveSemester;

  const SemesterWidget({
    Key? key,
    required this.semesterNumber,
    required this.semester,
    required this.onRemoveSemester,
  }) : super(key: key);

  @override
  State<SemesterWidget> createState() => _SemesterWidgetState();
}

class _SemesterWidgetState extends State<SemesterWidget> {
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController courseCreditController = TextEditingController();
  final TextEditingController courseGradeController = TextEditingController();

  void _addCourse() {
    if (courseNameController.text.isNotEmpty &&
        courseCreditController.text.isNotEmpty &&
        courseGradeController.text.isNotEmpty) {
      double credit = double.parse(courseCreditController.text);
      double cg = double.parse(courseGradeController.text);

      widget.semester.addCourse(courseNameController.text, credit, cg);

      // Clear the text fields after adding
      courseNameController.clear();
      courseCreditController.clear();
      courseGradeController.clear();

      setState(() {});
    }
  }

  void _removeCourse(int index) {
    setState(() {
      widget.semester.courses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.themeColor.withOpacity(0.2),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Semester ${widget.semesterNumber}',
                    style: const TextStyle(fontSize: 18)),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: widget.onRemoveSemester,
                ),
              ],
            ),
            ...widget.semester.courses.asMap().entries.map((entry) {
              int index = entry.key;
              Course course = entry.value;
              return ListTile(
                title: Text(course.name),
                subtitle: Text(
                    'Credits: ${course.credit}, Grade Point (CG): ${course.cg}'),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () => _removeCourse(index),
                ),
              );
            }).toList(),
            Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: courseNameController,
                      decoration: const InputDecoration(hintText: 'Course Name')),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                      controller: courseCreditController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: 'Course Credit'),
                      onSubmitted: (_) => _addCourse()),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                      controller: courseGradeController,
                      keyboardType: TextInputType.number,
                      decoration:
                      const InputDecoration(hintText: 'Grade Point'),
                      onSubmitted: (_) => _addCourse()),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addCourse,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'GPA for this semester is ${widget.semester.gpa.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}