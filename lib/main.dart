import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/app/app.dart';

// void main() {
//   runApp(const ());
// }


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Project());
}