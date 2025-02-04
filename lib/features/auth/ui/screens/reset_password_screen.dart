import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/features/auth/ui/screens/sign_in_screen.dart';
import 'package:project/features/auth/ui/widgets/app_logo_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  static const String name = '/reset-password-screen';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 88),
              const AuthAppLogoWidget(),
              const SizedBox(height: 24),
              Text(
                'Reset password', style: Theme.of(context).textTheme.titleLarge,),
              const SizedBox(height: 8),
              Text(
                'Minimum password length should be 6 characters',
                style: textTheme.bodyLarge?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              _buildForm(),
              const SizedBox(height: 47),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _passwordTEController,
            obscureText: true,
            decoration: const InputDecoration(hintText: 'Password'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter your password';
              }
              if (value!.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _confirmPasswordTEController,
            obscureText: true,
            decoration: const InputDecoration(hintText: 'Confirm Password'),
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
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed:(){
              Get.offAll(() => const SignInScreen(),
                opaque: false,
              );
            },
            child: const Icon(Icons.arrow_circle_right_outlined),
          ),
        ],
      ),
    );
  }

}