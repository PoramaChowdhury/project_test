// import 'package:flutter/material.dart';
// import 'package:project/features/auth/ui/screens/phone_verification_screen.dart';
// import 'package:project/features/auth/ui/screens/sign_in_screen.dart';
// import 'package:project/features/auth/ui/widgets/app_logo_widget.dart';
//
// class SplashScreen extends StatefulWidget {
//   static const String name = '/';
//
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _moveToNextScreen();
//   }
//
//   Future<void> _moveToNextScreen() async {
//     await Future.delayed(const Duration(seconds: 2));
//     Navigator.pushReplacementNamed(context, SignInScreen.name);
//     //Navigator.pushReplacementNamed(context, PhoneVerificationScreen.name);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Spacer(),
//               AppLogoWidget(),
//               Spacer(),
//               CircularProgressIndicator(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//todo for sharep
import 'package:flutter/material.dart';
import 'package:project/features/auth/service/auth_service.dart';
import 'package:project/features/auth/ui/screens/sign_in_screen.dart';
import 'package:project/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:project/features/authorities/transport/student_count.dart';
import 'package:project/features/common/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:project/features/driver/ui/screens/map_screen.dart';
import 'package:project/features/home/ui/screens/home_screen.dart';
import 'package:project/features/role_base_different_home/ui/screens/authority_home_screen.dart';
import 'package:project/features/role_base_different_home/ui/screens/driver_home_screen.dart';
import 'package:project/features/role_base_different_home/ui/screens/teacher_home_screen.dart';
// import 'package:project/features/student/transportation/ui/screens/route_select.dart';
import 'package:project/features/student/ui/screens/route_select.dart';

class SplashScreen extends StatefulWidget {
  static const String name = '/';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // Check login status when the screen is initialized
  }

  // This method checks if the user is logged in and navigates accordingly
  Future<void> _checkLoginStatus() async {
    // Wait for a few seconds to show the splash screen logo and loading
    await Future.delayed(const Duration(seconds: 3));

    // Call the AuthService to check if the user is logged in
    bool loggedIn = await AuthService().isUserLoggedIn();

    if (loggedIn) {
      // If the user is logged in, navigate to the appropriate screen based on role
      String role = await AuthService().getUserRole(); // Fetch the user's role (Driver, Student, etc.)

      if (role == 'drivers') {
        Navigator.pushReplacementNamed(context, DriverHomeScreen.name);  //todo add home testing// Navigate to MapScreen for Driver
      } else if (role == 'students')  {
        Navigator.pushReplacementNamed(context, HomeScreen.name); // Navigate to RouteSelectionScreen
      } else if ( role == 'teachers') {
        // If the role is unknown, navigate to SignInScreen
       // Navigator.pushReplacementNamed(context, SelectRoutesScreen.name);
        Navigator.pushReplacementNamed(context, TeacherHomeScreen.name); //todo add home testing
      }
      else if ( role == 'transports') {
        //todo check it
        //If the role is unknown, navigate to SignInScreen
        Navigator.pushReplacementNamed(context, AuthorityHomeScreen.name); //todo add home testing
      }
    } else {
      // If not logged in, navigate to SignInScreen
      Navigator.pushReplacementNamed(context, SignInScreen.name);
    }

  }@override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                AppLogoWidget(), // This is your logo widget
                Spacer(),
                CenteredCircularProgressIndicator(),
                SizedBox(height: 15,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}