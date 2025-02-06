import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/app/app_theme_data.dart';
import 'package:project/app/controler_binder.dart';
// import 'package:project/authorities/transport/student_count.dart';
import 'package:project/features/auth/ui/screens/forget_pass_otp_screen.dart';
import 'package:project/features/auth/ui/screens/forget_pass_phone_screen.dart';
import 'package:project/features/auth/ui/screens/forget_password_link_screen.dart';
import 'package:project/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:project/features/auth/ui/screens/phone_verification_screen.dart';
import 'package:project/features/auth/ui/screens/sign_in_screen.dart';
import 'package:project/features/auth/ui/screens/sign_up_screen.dart';
import 'package:project/features/auth/ui/screens/splash_screen.dart';
import 'package:project/features/auth/ui/screens/update_password_screen.dart';
import 'package:project/features/authorities/transport/student_count.dart';
import 'package:project/features/driver/ui/screens/map_screen.dart';
import 'package:project/features/home/ui/screens/home_screen.dart';
import 'package:project/features/role_base_different_home/ui/screens/teachers/teacher_home_screen.dart';
import 'package:project/features/role_base_different_home/ui/screens/transport_authoroty/authority_home_screen.dart';
import 'package:project/features/role_base_different_home/ui/screens/drivers/driver_home_screen.dart';
import 'package:project/features/student/ui/screens/route_select.dart';
// import 'package:project/home/ui/screens/home_screen.dart';

class Project extends StatefulWidget {
  const Project({super.key});

  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

        initialRoute: '/',
        theme: AppThemeData.lightThemeData,
        darkTheme: AppThemeData.darkThemeData,
        themeMode: ThemeMode.system,
        initialBinding: ControllerBinder(),
        onGenerateRoute: (RouteSettings settings) {
          late Widget widget;
          if (settings.name == SplashScreen.name) {
            widget = const SplashScreen();
          }

          else if (settings.name == SignInScreen.name) {
            widget = const SignInScreen();
          }
          else if (settings.name == PhoneVerificationScreen.name) {
            widget = const PhoneVerificationScreen();
          }
          //todo: uncomit
          // else if (settings.name == OtpVerificationScreen.name) {
          //   widget = const OtpVerificationScreen(userId: ,);
          // }
          //todo: mera nehi calti edar
          else if (settings.name == OtpVerificationScreen.name) {
            // Ensure the userId is passed when navigating to OtpVerificationScreen
            final String userId = settings.arguments as String;
            final String phoneNumber = settings.arguments as String;
            widget = OtpVerificationScreen(userId: userId, phoneNumber: phoneNumber,);
          }
          else if (settings.name == SignUpScreen.name) {
            String phoneNumber = settings.arguments as String;
            widget = SignUpScreen(phoneNumber: phoneNumber);
          }
          else if (settings.name == HomeScreen.name) {
            widget =  const HomeScreen();
          }
          else if (settings.name == TeacherHomeScreen.name) {
            // Ensure the driverId is passed when navigating to MapScreen
            widget = const TeacherHomeScreen();
          }
          else if (settings.name == AuthorityHomeScreen.name) {
            // Ensure the driverId is passed when navigating to MapScreen
            widget = const AuthorityHomeScreen();
          }
          else if (settings.name == DriverHomeScreen.name) {
            // Ensure the driverId is passed when navigating to MapScreen
            widget = const DriverHomeScreen();
          }

          //todo added map part
          else if (settings.name == MapScreen.name) {
            // Ensure the driverId is passed when navigating to MapScreen
            final String driverId = settings.arguments as String;
            widget = MapScreen(driverId: driverId);
          }



          //todo update will use as update aND FORGET BOTH LOGIC APATOTO OFF
          else if (settings.name == UpdatePasswordScreen.name) {
            widget = const UpdatePasswordScreen();
          }
          //todo added ForgotPasswordScreen
          // else if (settings.name == ForgetPassPhoneScreen.name) {
          //   widget = const ForgotPasswordScreen();
          // }
          // else if (settings.name == ForgetPassOtpScreen.name) {
          //   widget = const ForgetPassOtpScreen();
          // }

          return MaterialPageRoute(builder: (ctx) {
            return widget;
          });
        });
  }
}
