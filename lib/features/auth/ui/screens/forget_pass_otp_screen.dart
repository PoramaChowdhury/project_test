// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:project/app/app_colors.dart';
// import 'package:project/app/app_constants.dart';
// import 'package:project/features/auth/ui/screens/reset_password_screen.dart';
// import 'package:project/features/auth/ui/screens/sign_in_screen.dart';
// import 'package:project/features/auth/ui/widgets/app_logo_widget.dart';
//
// class ForgetPassOtpScreen extends StatefulWidget {
//   const ForgetPassOtpScreen({super.key});
//
//   static const String name = '/forget-pass-otp-verification';
//
//   @override
//   State<ForgetPassOtpScreen> createState() => _ForgetPassOtpScreenState();
// }
//
// class _ForgetPassOtpScreenState extends State<ForgetPassOtpScreen> {
//   final TextEditingController _otpTEController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final RxInt _remainingTime = AppConstants.resendOtpTimeOutInSecs.obs;
//   late Timer timer;
//   final RxBool _enableResendCodeButton = false.obs;
//
//   @override
//   void initState() {
//     super.initState();
//     _startResendCodeTimer();
//   }
//
//   void _startResendCodeTimer() {
//     _enableResendCodeButton.value = false;
//     _remainingTime.value = AppConstants.resendOtpTimeOutInSecs;
//     timer = Timer.periodic(const Duration(seconds: 1), (t) {
//       _remainingTime.value--;
//       if (_remainingTime.value == 0) {
//         t.cancel();
//         _enableResendCodeButton.value = true;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 const SizedBox(height: 88),
//                 const AppLogoWidget(),
//                 const SizedBox(height: 24),
//                 Text(
//                   'Enter OTP Code',
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'A 6 Digit OTP Code has been Sent',
//                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                     color: Colors.grey,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 PinCodeTextField(
//                   length: 6,
//                   obscureText: false,
//                   animationType: AnimationType.fade,
//                   animationDuration: const Duration(milliseconds: 300),
//                   pinTheme: PinTheme(
//                     shape: PinCodeFieldShape.box,
//                     activeColor: AppColors.themeColor,
//                     inactiveColor: AppColors.themeColor,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   backgroundColor:
//                   Theme.of(context).brightness == Brightness.dark
//                       ? Colors.grey
//                       : Colors.white,
//                   keyboardType: TextInputType.number,
//                   appContext: context,
//                   controller: _otpTEController,
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, ResetPasswordScreen.name);
//                   },
//                   child: const Text('Next'),
//                 ),
//                 const SizedBox(height: 16),
//                 Obx(
//                       () => Visibility(
//                     visible: !_enableResendCodeButton.value,
//                     child: RichText(
//                       text: TextSpan(
//                           text: 'This code will be expire in ',
//                           style: const TextStyle(
//                             color: Colors.grey,
//                           ),
//                           children: [
//                             TextSpan(
//                                 text: '${_remainingTime}s',
//                                 style: const TextStyle(
//                                   color: AppColors.themeColor,
//                                 ))
//                           ]),
//                     ),
//                   ),
//                 ),
//                 Obx(
//                       () => Visibility(
//                     visible: _enableResendCodeButton.value,
//                     child: TextButton(
//                       onPressed: () {
//                         _startResendCodeTimer();
//                       },
//                       child: const Text('Resend Code'),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     timer.cancel();
//     super.dispose();
//   }
// }