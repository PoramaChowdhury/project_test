import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';

import 'package:project/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:project/features/auth/ui/widgets/app_logo_widget.dart';

///*
//
// class PhoneVerificationScreen extends StatefulWidget {
//   const PhoneVerificationScreen({super.key});
//
//   static const String name = '/phone-verification';
//
//   @override
//   State<PhoneVerificationScreen> createState() => _PhoneVerificationScreenState();
// }
//
// class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
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
//                 const SizedBox(
//                   height: 24,
//                 ),
//                 Text(
//                   'Welcome Back',
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 Text(
//                   'Please enter your phone number',
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
//                     if (RegExp(r'^\+880\d{10}$').hasMatch(value!) == false) {
//                       return 'Enter a valid phone number (+880**********)';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       // Get the phone number from the controller
//                       String phoneNumber = _mobileTEController.text.trim();
//                       Navigator.pushNamed(context, OtpVerificationScreen.name,
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
// */
//
// class PhoneVerificationScreen extends StatefulWidget {
//   const PhoneVerificationScreen({super.key});
//
//   static const String name = '/phone-verification';
//
//   @override
//   State<PhoneVerificationScreen> createState() => _PhoneVerificationScreenState();
// }
//
// class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
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
//                 const SizedBox(height: 24),
//                 Text(
//                   'Welcome Back',
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 Text(
//                   'Please enter your phone number',
//                   style:
//                   Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
//                 ),
//                 const SizedBox(height: 24),
//                 TextFormField(
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   controller: _mobileTEController,
//                   keyboardType: TextInputType.phone,
//                   decoration:
//                   const InputDecoration(hintText: 'Mobile'),
//                   validator:(String? value) {
//                     if (value?.trim().isEmpty ?? true) {
//                       return 'Enter your mobile number';
//                     }
//                     if (RegExp(r'^\+880\d{10}$').hasMatch(value!) == false) {
//                       return 'Enter a valid phone number (+880**********)';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed:( ) {
//                     if (_formKey.currentState!.validate()) {
//                       // Get the phone number from the controller
//                       String phoneNumber = _mobileTEController.text.trim();
//                       Navigator.pushNamed(context, OtpVerificationScreen.name,
//                         arguments : phoneNumber, /// Pass phone number as argument
//                       );
//                     }
//                   },
//                   child :const Text('Next'),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  static const String name = '/phone-verification';

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final TextEditingController _mobileTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final Client _client;
  late final Account _account;
  String? _userId;

  // final Client client = Client()
  //     .setEndpoint('https://cloud.appwrite.io/v1') // Your Appwrite Endpoint
  //     .setProject('6787c8cb000919c242c8'); // Your Project ID
  // late final Account account; //todo fix it

  @override
  void initState() {
    super.initState();
    _client = Client()
        .setEndpoint('https://cloud.appwrite.io/v1') // Your Appwrite Endpoint
        .setProject('6787c8cb000919c242c8'); // Your Project ID
    _account = Account(_client);
  }

  // Function to send OTP
  Future<void> sendSms() async {
    try {
      final token = await _account.createPhoneToken(
        userId: ID.unique(), // Unique user ID for registration
        phone: _mobileTEController.text,
      );
      _userId = token.userId;

      // Navigate to OTP screen after sending SMS
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpVerificationScreen(
            userId: _userId!,
            phoneNumber: _mobileTEController.text,
          ),
        ),

      );

      // Notify the user that the OTP has been sent
      print('OTP sent to ${_mobileTEController.text}. User ID: $_userId');
    } catch (e) {
      print('Error sending SMS: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 88),
                const AuthAppLogoWidget(),
                const SizedBox(height: 24),
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Please enter your phone number',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _mobileTEController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(hintText: 'Mobile'),

                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your mobile number';
                    }
                    if (RegExp(r'^\+8801[3-9]\d{8}$').hasMatch(value!) == false) {
                      return 'Enter a valid phone number (+880**********)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  // todo -no need this part, still will cross check
                 // onPressed:() {
                 //    if (_formKey.currentState!.validate()) {
                 //      String phoneNumber = _mobileTEController.text.trim();
                 //      print("Navigating to OTP screen with phone number: $phoneNumber");
                 //      Navigator.pushNamed(
                 //        context,
                 //        OtpVerificationScreen.name,
                 //        arguments: phoneNumber, // Pass phone number here
                 //      );
                 //    }
                 //  },
                  onPressed: sendSms,
                  child: const Text('Next'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
