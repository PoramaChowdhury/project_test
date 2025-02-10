import 'package:flutter/material.dart';
import 'package:project/app/app_colors.dart';
import 'package:project/features/student/student_assistant/cgpa/data/model/semester.dart';
import 'package:project/features/student/student_assistant/cgpa/ui/screens/cgpa.dart';

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