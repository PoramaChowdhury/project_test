import 'package:flutter/material.dart';
import 'package:project/features/auth/service/auth_service.dart';
import 'package:project/features/auth/ui/screens/sign_in_screen.dart'; // Import SignInScreen
import 'package:project/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:project/features/common/ui/widgets/custom_snakebar.dart';
//todo working code

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static const String name = '/forgot-password-screen';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService(); // Instance of AuthService
  bool _isLoading = false; // Track loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Center(
        child: SingleChildScrollView( // Wrap with SingleChildScrollView
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const AuthAppLogoWidget(),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading // Disable button while loading
                      ? null
                      : () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true; // Set loading to true
                      });

                      await _authService.resetPassword(
                          _emailController.text, context);
                      //After reset mail sent successfully, navigate to sign in screen
                      Navigator.pushReplacementNamed(context, SignInScreen.name);

                      setState(() {
                        _isLoading = false; // Set loading to false
                      });
                    }
                  },
                  child: _isLoading // Show CircularProgressIndicator while loading
                      ? const CircularProgressIndicator()
                      : const Text('Send Reset Email'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}