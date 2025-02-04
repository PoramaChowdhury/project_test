// import 'package:flutter/material.dart';
// import 'package:project/features/auth/ui/screens/forget_pass_otp_screen.dart';
// import 'package:project/features/auth/ui/widgets/app_logo_widget.dart';
//
// class ForgetPassPhoneScreen extends StatefulWidget {
//   const ForgetPassPhoneScreen({super.key});
//
//   static const String name = '/forget-pass-phone';
//
//   @override
//   State<ForgetPassPhoneScreen> createState() => _ForgetPassPhoneScreenState();
// }
//
// class _ForgetPassPhoneScreenState extends State<ForgetPassPhoneScreen> {
//
//   final TextEditingController _mobileTEController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
//                 const SizedBox(height: 24,),
//                 Text(
//                     'Forgot Your Password?', style: Theme.of(context).textTheme.titleLarge),
//                 const SizedBox(height: 8),
//                 Text(
//                   'No worries! Just enter your phone number below and we\'ll help you reset it.',
//                   textAlign: TextAlign.center,
//                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                     color: Colors.grey,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 TextFormField(
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   controller: _mobileTEController,
//                   keyboardType: TextInputType.phone,
//                   decoration: const InputDecoration(hintText: 'Mobile'),
//                   validator: (String? value) {
//                     if (value?.trim().isEmpty ?? true) {
//                       return 'Enter your mobile number';
//                     }
//                     if (RegExp(r'^\+8801[3-9]\d{8}$').hasMatch(value!) == false) {
//                       return 'Enter a valid phone number (+880)';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       String phoneNumber = _mobileTEController.text.trim();
//                       Navigator.pushNamed(context, ForgetPassOtpScreen.name,
//                         arguments: phoneNumber, /// Pass phone number as argument
//                       );
//                     }
//                   },
//                   child: const Text('Next'),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }