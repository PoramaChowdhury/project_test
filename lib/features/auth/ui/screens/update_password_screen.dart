import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:project/features/common/ui/widgets/custom_snakebar.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});
  static const String name = '/update-password-screen';

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final TextEditingController _currentPasswordTEController = TextEditingController();
  final TextEditingController _newPasswordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  Future<void> _updatePassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Re-authenticate user with their current password before updating the password
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: _currentPasswordTEController.text);

        // Reauthenticate user
        await user.reauthenticateWithCredential(credential);

        // Update password
        await user.updatePassword(_newPasswordTEController.text);

        //Fluttertoast.showToast(msg: "Password updated successfully.");
        //todo add snackbar msg
        showSnackBarMessage(context, "Password updated successfully.");
        Navigator.pop(context);  // Close the update password screen
      } else {
        // Fluttertoast.showToast(msg: "No user is signed in.");
        //todo add snackbar msg
        showSnackBarMessage(context, "No user is signed in.");
      }
    } on FirebaseAuthException catch (e) {
      //Fluttertoast.showToast(msg: e.message ?? "Error occurred");

      //todo add snackbar msg
      showSnackBarMessage(context, e.message ?? "Error occurred");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///todo add appbar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // No background color
        elevation: 0, // No shadow
        foregroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white // In dark mode, set icon color to white
            : Colors.black, // In light mode, set icon color to black
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 88),
              const AuthAppLogoWidget(),
              const SizedBox(height: 24),
              Text('Set a New Password',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 24),
              buildForm(),
              ElevatedButton(
                onPressed: _updatePassword,
                child: const Text('Update Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildForm(){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _currentPasswordTEController,
            obscureText: !_isCurrentPasswordVisible,
            decoration: InputDecoration(
              hintText: 'Current Password',
              suffixIcon: IconButton(
                icon: Icon(
                  _isCurrentPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your current password';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _newPasswordTEController,
            obscureText: !_isNewPasswordVisible,
            decoration: InputDecoration(
              hintText: 'New Password',
              suffixIcon: IconButton(
                icon: Icon(
                  _isNewPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isNewPasswordVisible = !_isNewPasswordVisible;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter a new password';
              }
              if (value!.length < 8) {
                return 'Password must be at least 8 characters';
              }
              //todo regex open kortay
              String passwordPattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
              if (!RegExp(passwordPattern).hasMatch(value)) {
                return 'Password must include uppercase, lowercase, number, and special character';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _confirmPasswordTEController,
            decoration: InputDecoration(
              hintText: 'Confirm New Password',
              suffixIcon: IconButton(
                icon: Icon(
                  _isConfirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please confirm your new password';
              }
              if (value != _newPasswordTEController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),

        ],
      ),
    );
  }
}