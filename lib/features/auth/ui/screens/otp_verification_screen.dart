import 'dart:async';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:project/app/app_colors.dart';
import 'package:project/app/app_constants.dart';
import 'package:project/features/auth/ui/screens/sign_up_screen.dart';
import 'package:project/features/auth/ui/widgets/app_logo_widget.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String userId;
  final String phoneNumber;

  const OtpVerificationScreen(
      {required this.userId,
      required this.phoneNumber,
      super.key}); //todo const dorkari ni?

  static const String name = '/otp-verification';

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RxInt _remainingTime = AppConstants.resendOtpTimeOutInSecs.obs;
  late Timer timer;
  final RxBool _enableResendCodeButton = false.obs;
  late final Client _client;
  late final Account _account;

  @override
  void initState() {
    super.initState();
    _client = Client()
        .setEndpoint('https://cloud.appwrite.io/v1') // Your Appwrite Endpoint
        .setProject('6787c8cb000919c242c8'); // Your Project ID
    _account = Account(_client);
    _startResendCodeTimer();
  }

  // Function to verify OTP and create the user session
  Future<void> verifyOtp() async {
    if (_otpTEController.text.isEmpty) {
      print('OTP is missing');
      return;
    }

    try {
      // Now, verify OTP and create a session
      final session = await _account.createSession(
        userId: widget.userId,
        // Use the userId passed from the registration screen
        secret: _otpTEController.text, // OTP entered by the user
      );

      print('OTP verified successfully. Session created: ${session.toMap()}');

      // Navigate to welcome screen after successful OTP verification
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpScreen(
            phoneNumber: widget.phoneNumber,
          ),
        ),
      );
    } catch (e) {
      print('Error verifying OTP: $e');
    }
  }

  void _startResendCodeTimer() {
    _enableResendCodeButton.value = false;
    _remainingTime.value = AppConstants.resendOtpTimeOutInSecs;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      _remainingTime.value--;
      if (_remainingTime.value == 0) {
        t.cancel();
        _enableResendCodeButton.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 80),
                const AuthAppLogoWidget(),
                const SizedBox(height: 16),
                Text(
                  'Enter OTP Code',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'A 6 Digit OTP Code has been Sent',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(height: 24),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  animationDuration: const Duration(milliseconds: 300),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    activeColor: AppColors.themeColor,
                    inactiveColor: AppColors.themeColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey
                          : Colors.white,
                  keyboardType: TextInputType.number,
                  appContext: context,
                  controller: _otpTEController,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: verifyOtp,
                  // onPressed: () {
                  //   Navigator.pushNamed(context, CompleteProfileScreen.name);
                  // },
                  child: const Text('Next'),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => Visibility(
                    visible: !_enableResendCodeButton.value,
                    child: RichText(
                      text: TextSpan(
                          text: 'This code will be expire in ',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(
                                text: '${_remainingTime}s',
                                style: const TextStyle(
                                  color: AppColors.themeColor,
                                ))
                          ]),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: _enableResendCodeButton.value,
                    child: TextButton(
                      onPressed: () {
                        _startResendCodeTimer();
                      },
                      child: const Text('Resend Code'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
