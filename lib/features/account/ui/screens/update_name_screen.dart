import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/features/auth/service/auth_service.dart'; // Import your auth service
import 'package:project/features/common/ui/widgets/custom_snakebar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UpdateNameScreen extends StatefulWidget {
  const UpdateNameScreen({super.key});
  static const String name = '/update-name-screen';

  @override
  _UpdateNameScreenState createState() => _UpdateNameScreenState();
}

class _UpdateNameScreenState extends State<UpdateNameScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadCurrentName(); // Load the current name when the screen initializes
  }

  Future<void> _loadCurrentName() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Map<String, dynamic> userData = await AuthService().getUserData(user.uid);
        setState(() {
          _firstNameTEController.text = userData['firstName'] ?? '';
          _lastNameTEController.text = userData['lastName'] ?? '';
        });
      }
    } catch (e) {
      print("Error loading current name: $e");
      showSnackBarMessage(context, "Error loading name.");
    }
  }

  Future<void> _updateName() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String firstName = _firstNameTEController.text;
        String lastName = _lastNameTEController.text;

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

        await userCollection.doc(user.uid).update({
          'firstName': firstName,
          'lastName': lastName,
        });

        showSnackBarMessage(context, "Name updated successfully.");
        Navigator.pop(context); // Close the update name screen

      } else {
        showSnackBarMessage(context, "No user is signed in.");
      }
    } catch (e) {
      showSnackBarMessage(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 88),
            //const AppLogoWidget(), // If you want to keep the logo
            const SizedBox(height: 24),
            Text('Update Name', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _firstNameTEController,
                    decoration: const InputDecoration(hintText: 'First Name'),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _lastNameTEController,
                    decoration: const InputDecoration(hintText: 'Last Name'),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _updateName,
              child: const Text('Update Name'),
            ),
          ],
        ),
      ),
    );
  }
}