import 'package:project/features/student/student_assistant/cgpa/ui/screens/cgpa.dart';

class Semester {
  final List<Course> courses = [];

  void addCourse(String name, double credit, double cg) {
    courses.add(Course(name, credit, cg));
  }

  double get totalCredits => courses.fold(0, (sum, course) => sum + course.credit);

  double get totalPoints => courses.fold(0, (sum, course) => sum + (course.credit * course.cg));

  double get gpa => totalCredits > 0 ? totalPoints / totalCredits : 0;
}