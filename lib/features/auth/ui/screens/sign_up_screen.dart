
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/features/auth/service/auth_service.dart';
import 'package:project/features/auth/ui/screens/sign_in_screen.dart';
import 'package:project/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:appwrite/appwrite.dart';


class SignUpScreen extends StatefulWidget {
  final String? phoneNumber;

  const SignUpScreen({super.key, this.phoneNumber});

  static const String name = '/complete-profile';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  // Appwrite Client and Account initialization
  final Client _client = Client()
      .setEndpoint('https://cloud.appwrite.io/v1') // Your Appwrite Endpoint
      .setProject('6787c8cb000919c242c8'); // Your Project ID

  late final Account _account; // Declare the Account instance

  String? _selectedRole;
  final List<String> _roles = ['Student', 'Teacher', 'Driver','Transport'];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();

    _account = Account(_client); // Initialize Account inside initState

    if (widget.phoneNumber != null) {
      _mobileTEController.text = widget.phoneNumber!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              const AuthAppLogoWidget(width: 100, height: 100),
              const SizedBox(height: 16),
              Text('Welcome to the family!',
                style: GoogleFonts.dynaPuff(
                  color: Theme.of(context).textTheme.titleLarge?.color ?? Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),),
              Text(
                'Create your account and join the adventure',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              buildForm(),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      // Perform signup
                      await AuthService().signup(
                        _firstNameTEController.text,
                        _lastNameTEController.text,
                        _mobileTEController.text,
                        _emailTEController.text,
                        _passwordTEController.text,
                        _selectedRole!,

                        context,
                      );

                      // Perform logout
                      await logout(context);

                      // After logout, navigate to the SignIn screen
                      Navigator.pushNamed(context, SignInScreen.name);
                    } catch (e) {
                      // Handle any errors (you can display a message to the user)
                      print('Error during signup or logout: $e');
                    }
                  }
                },
                child: const Text('Complete'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(hintText: 'Select Role'),
            value: _selectedRole,
            items: _roles.map((role) {
              return DropdownMenuItem<String>(
                value: role,
                child: Text(role),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedRole = value;
              });
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please select a role';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          if (_selectedRole != null) ...[
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _firstNameTEController,
              decoration: const InputDecoration(hintText: 'First Name'),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Enter your first name';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _lastNameTEController,
              decoration: const InputDecoration(hintText: 'Last Name'),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Enter your last name';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              enabled: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _mobileTEController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(hintText: 'Mobile'),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Enter your mobile number';
                }
                //todo pohn tik kortam
                if (RegExp(r"^\+880\d{10}$").hasMatch(value!) == false) {
                  return 'Enter valid mobile number';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _emailTEController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'Email'),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Enter your email';
                }

                if (_selectedRole == 'Student') {
                  if (!RegExp(r'^(cse|bba|arch|thm|ph|eee|ce|eng)_\d{15,16}@lus\.ac\.bd$').hasMatch(value!)) {
                    return 'Enter a valid student email';
                  }

                } else if (_selectedRole == 'Teacher') {
                  if (!RegExp(r'^[a-zA-Z]+_cse@lus\.ac\.bd$')
                      .hasMatch(value!)) {
                    return 'Enter a valid teacher email';
                  }
                } else if (_selectedRole == 'Driver') {
                  if (!RegExp(r'^[a-zA-Z]+_driver@lus\.ac\.bd$')
                      .hasMatch(value!)) {
                    return 'Enter a valid driver email';
                  }

                } else if (_selectedRole == 'Transport') {
                  if (!RegExp(r'^[a-zA-Z]+_ro@lus\.ac\.bd$')
                      .hasMatch(value!)) {
                    return 'Enter a valid driver email';
                  }

                }
                else {
                  return 'Please select a role first';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            //todo i updated the regex
            // TextFormField(
            //   autovalidateMode: AutovalidateMode.onUserInteraction,
            //   controller: _passwordTEController,
            //   obscureText: true,
            //   decoration: const InputDecoration(hintText: 'Password'),
            //   validator: (String? value) {
            //     if (value?.trim().isEmpty ?? true) {
            //       return 'Enter your password';
            //     }
            //     if (value!.length < 8) {
            //       return 'Password must be at least 8 characters';
            //     }
            //     return null;
            //   },
            // ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _passwordTEController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(hintText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Enter your password';
                }
                if (value!.length < 8) {
                  return 'Password must be at least 8 characters';
                }
                // Regex for password complexity (uppercase, lowercase, number, special character)
                String passwordPattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
                if (!RegExp(passwordPattern).hasMatch(value)) {
                  return 'Password must include uppercase, lowercase, number, and special character';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _confirmPasswordTEController,
              obscureText: !_isConfirmPasswordVisible,
              decoration:  InputDecoration(hintText: 'Confirm Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
              ),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Confirm your password';
                }
                if (value != _passwordTEController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    try {
      await _account.deleteSession(sessionId: 'current');  // Don't pass 'current' as a string, just the keyword.
      Navigator.pushReplacementNamed(context, SignInScreen.name);// Navigate to SignInScreen
      print('appwrite session out successfully');
    } catch (e) {
      // Handle any errors here
      print('appwrite session failed: $e');
    }
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
