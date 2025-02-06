import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/app/app_colors.dart';
import 'package:project/features/auth/service/auth_service.dart';
import 'package:project/features/auth/ui/screens/forget_password_link_screen.dart';
import 'package:project/features/auth/ui/screens/phone_verification_screen.dart';
import 'package:project/features/auth/ui/widgets/app_logo_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  String? _selectedRole;
  final List<String> _roles = ['Student', 'Teacher', 'Driver', 'Transport'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 88),
              const AuthAppLogoWidget(),
              const SizedBox(height: 24),
              Text('Welcome!',
                style: GoogleFonts.dynaPuff(
                  color: Theme.of(context).textTheme.titleLarge?.color ?? Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                ),),
              Text(
                'Let’s Get You In',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.grey),
              ),

              const SizedBox(height: 24),
              buildForm(),
              ElevatedButton(
                //todo: on tap signinbutton
                onPressed: _onTapSigninButton,
                child: const Text('Sign In'),
              ),
              const SizedBox(height: 14),
              Center(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: _onTapForgetPasswordButton,
                      child: const Text(
                        'Forget your password?',
                        style:
                        TextStyle(letterSpacing: 0.5, color: Colors.grey),
                      ),
                    ),
                    _buildSignUpSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //todo ForgotPasswordScreen added
  void _onTapForgetPasswordButton() {
    Get.to(() => const ForgotPasswordScreen());
  }

  Widget buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Dropdown for role selection (first field)
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
              controller: _emailTEController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'Email'),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Enter your email';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _passwordTEController,
              // obscureText: true,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                hintText: 'Password',
                //todo add eye on off
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
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
                //todo regex open kortay
                String passwordPattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
                if (!RegExp(passwordPattern).hasMatch(value)) {
                  return 'Password must include uppercase, lowercase, number, and special character';
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

  Widget _buildSignUpSection() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          //color: Colors.black,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
        text: "Don't have an account?  ",
        children: [
          TextSpan(
            text: 'Sign up ',
            style: const TextStyle(
              color: AppColors.themeColor,
            ),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignUp,
          ),
        ],
      ),
    );
  }

  Future<void> _onTapSigninButton() async {
    //todo test
    if (!_formKey.currentState!.validate()) {
      return;  // If form is invalid, do nothing
    }
    await AuthService()
        .signin(_emailTEController.text, _passwordTEController.text, context);
  }

  void _onTapSignUp() {
    Get.to(() => const PhoneVerificationScreen());
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}