import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:project/authorities/transport/student_count.dart';
import 'package:project/features/auth/ui/screens/sign_in_screen.dart';
import 'package:project/features/authorities/transport/student_count.dart';
import 'package:project/features/common/ui/widgets/custom_snakebar.dart';
import 'package:project/features/driver/ui/screens/map_screen.dart';
import 'package:project/features/home/ui/screens/home_screen.dart';
import 'package:project/features/student/ui/screens/route_select.dart';
// import 'package:project/home/ui/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //todo ib added SharedPreferences
  // Save user data to SharedPreferences
  Future<void> _saveUserData(String uid, String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
    await prefs.setString('role', role);
  }

  //todo for profile pic
/*
  Future<void> updateProfileImage(String uid, String imageUrl) async {
    try {
      // Get the user's role from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? role = prefs.getString('role');
      CollectionReference userCollection;

      if (role == 'students') {
        userCollection = FirebaseFirestore.instance.collection('students');
      } else if (role == 'teachers') {
        userCollection = FirebaseFirestore.instance.collection('teachers');
      } else if (role == 'drivers') {
        userCollection = FirebaseFirestore.instance.collection('drivers');
      } else if (role == 'transport') {
        userCollection = FirebaseFirestore.instance.collection('transports');
      } else {
        userCollection = FirebaseFirestore.instance.collection('users'); // Default
      }

      await userCollection.doc(uid).update({
        'profileImageUrl': imageUrl,
      });
    } catch (e) {
      print('Error updating profile image URL: $e');
    }
  }
*/

  Future<Map<String, dynamic>> getUserData(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? role = prefs.getString('role');
    CollectionReference userCollection;

    if (role == 'students') {
      userCollection = FirebaseFirestore.instance.collection('students');
    } else if (role == 'teachers') {
      userCollection = FirebaseFirestore.instance.collection('teachers');
    } else if (role == 'drivers') {
      userCollection = FirebaseFirestore.instance.collection('drivers');
    } else if (role == 'transport') {
      userCollection = FirebaseFirestore.instance.collection('transports');
    } else {
      userCollection = FirebaseFirestore.instance.collection('users'); // Default
    }

    DocumentSnapshot userDoc = await userCollection.doc(uid).get();

    if (!userDoc.exists) {
      throw Exception("User data not found");
    }

    return userDoc.data() as Map<String, dynamic>;
  }







  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // Show a message to the user indicating that a reset email has been sent.
      showSnackBarMessage(context, "Password reset email sent. Check your inbox.");
    } on FirebaseAuthException catch (e) {
      showSnackBarMessage(context, e.message ?? "Error sending reset email.");
    }
  }

  // Check if the user is logged in by verifying SharedPreferences
  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    if (uid != null) {
      return true; // User is logged in
    }
    return false; // User is not logged in
  }

  Future<String> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? role = prefs.getString('role');

    if (role == null) {
      throw Exception("User role not found"); // You can customize this message.
    }

    return role;
  }

  // Get user data from Firestore
/*//   Future<Map<String, String>> getUserData(String uid) async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     DocumentSnapshot userDoc =
//         await firestore.collection('students').doc(uid).get();
// //todo only for students
//     if (!userDoc.exists) {
//       throw Exception("User data not found");
//     }
//
//     var userData = userDoc.data() as Map<String, dynamic>;
//
//     // Return user data as a map (fullName and email)
//     return {
//       'fullName': '${userData['firstName']} ${userData['lastName']}',
//       'firstName': userData['firstName'] ?? '',
//       'email': userData['email'],
//     };
//   }*/



  Future<void> signup(
    String firstName,
    String lastName,
    String mobile,
    String email,
    String password,
    String role,
    BuildContext context,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference userCollection;

      if (role == 'Student') {
        userCollection = firestore.collection('students');
      } else if (role == 'Teacher') {
        userCollection = firestore.collection('teachers');
      } else if (role == 'Driver') {
        userCollection = firestore.collection('drivers');
      } else if (role == 'Transport') {
        userCollection = firestore.collection('transports');
      } else {
        // Default collection if no role selected
        userCollection = firestore.collection('users');
      }

      await userCollection.doc(userCredential.user?.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'mobile': mobile,
        'password': password,
        // Optional: You might not want to store the password here
        'role': role,
        'createdAt': Timestamp.now(),
      });

      // todo --Save the user data to SharedPreferences after successful signup
      await _saveUserData(userCredential.user!.uid, role);

      // Fluttertoast.showToast(msg: "Account created");
      //todo snakebar added
      showSnackBarMessage(context, "Account created");
      //todo: add directly added

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignInScreen(),
        ),
      );

      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
      //todo i commented it
    } on FirebaseAuthException catch (e) {
      // Fluttertoast.showToast(msg: e.message ?? "Error occurred");
      //todo snakebar added
      showSnackBarMessage(context, e.message ?? "Error occurred");
    }
  }

  // Future<void> signin(
  //     String email, String password, BuildContext context) async {
  //   try {
  //     await _auth.signInWithEmailAndPassword(email: email, password: password);
  //     Fluttertoast.showToast(msg: "Welcome ");
  //     Navigator.pushReplacement(context,
  //        //todo uncomit 64 line
  //        MaterialPageRoute(builder: (context) => MainBottomNavScreen()));
  //         //todo - tesing update working or not
  //        //  MaterialPageRoute(builder: (context) => UpdatePasswordScreen()));
  //   } on FirebaseAuthException catch (e) {
  //     Fluttertoast.showToast(msg: e.message ?? "Error occurred");
  //   }
  // }

  // todo  commented for new role based singin
  Future<void> signin(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //Fluttertoast.showToast(msg: "Welcome ");
      ///snackbar added
      showSnackBarMessage(context, "Welcome!!");
      // Get the user role from Firestore
      //todo add driver auth part
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      // Try to find the user in the correct collection based on the UID
      DocumentSnapshot studentDoc = await firestore
          .collection('students')
          .doc(userCredential.user!.uid)
          .get();
      DocumentSnapshot teacherDoc = await firestore
          .collection('teachers')
          .doc(userCredential.user!.uid)
          .get();
      DocumentSnapshot driverDoc = await firestore
          .collection('drivers')
          .doc(userCredential.user!.uid)
          .get();
      DocumentSnapshot transportDoc = await firestore
          .collection('transports')
          .doc(userCredential.user!.uid)
          .get();

      //todo before share role based
      /*  // Check which document exists (the user will only be in one of these collections)
      if (driverDoc.exists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MapScreen(driverId: userCredential.user!.uid),
          ),
        );
      } else if (studentDoc.exists || teacherDoc.exists) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => RouteSelectionScreen()));
      } else {
        Fluttertoast.showToast(msg: "User role not found");
      }*/

      // Navigator.pushReplacement(
      //     context,
      //     //todo uncomit 64 line
      //     // MaterialPageRoute(builder: (context) => MainBottomNavScreen()));
      //     MaterialPageRoute(builder: (context) => UpdatePasswordScreen()));

      //todo share role based
      String role = '';

      // Check which document exists and assign role
      if (driverDoc.exists) {
        role = 'drivers';
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MapScreen(driverId: userCredential.user!.uid),
          ),
        );
      } else if (studentDoc.exists) {
        role = 'students';
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else if (teacherDoc.exists) {
        role = 'teachers';
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SelectRoutesScreen()),
        );
      } else if (transportDoc.exists) {
        role = 'transports';
        //todo age transport asil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StudentCount()),
        );
      } else {
        //Fluttertoast.showToast(msg: "User role not found");
        //todo add snackbar msg
        showSnackBarMessage(context, "User role not found");
        return;
      }

      // Save the user data to SharedPreferences after successful sign-in
      await _saveUserData(userCredential.user!.uid, role);
    } on FirebaseAuthException catch (e) {
     // Fluttertoast.showToast(msg: e.message ?? "Error occurred");
      //todo add snackbar msg
      showSnackBarMessage(context, e.message ?? "Error occurred");
    }
  }

  Future<void> signout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear saved data from SharedPreferences

    await _auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }
}
