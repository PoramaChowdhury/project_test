import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/app/asset_path.dart';
import 'package:project/features/auth/service/auth_service.dart';
import 'package:project/features/auth/ui/screens/update_password_screen.dart';
import 'package:project/features/home/ui/screens/about_screen.dart';
import 'package:project/features/home/ui/screens/help_screen.dart';
import 'package:project/features/home/ui/screens/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String fullName = '';
  String email = '';
  String profileImageBase64 = ''; //todo  Add this line
  bool isDarkMode = false; // Track theme state

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Function to load user data from Firestore
  // Future<void> _loadUserData() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     try {
  //       // Map<String, String> userData =
  //       // await AuthService().getUserData(user.uid);
  //       //todo image
  //       Map<String, dynamic> userData =
  //       await AuthService().getUserData(user.uid);
  //       setState(() {
  //         fullName = userData['fullName'] ?? '';
  //         email = userData['email'] ?? '';
  //       });
  //     } catch (e) {
  //       print("Error fetching user data: $e");
  //     }
  //   }
  // }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        Map<String, dynamic> userData =
            await AuthService().getUserData(user.uid);
        setState(() {
          fullName = userData['firstName'] ?? '';
          email = userData['email'] ?? '';
          profileImageBase64 =
              userData['profileImageBase64'] ?? ''; // Get the image Base64
        });
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
  }

  void _toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
      // You can directly set the theme mode here
      Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child:
                // Row(
                //   children: [
                //     CircleAvatar(
                //       radius: 20,
                //       // backgroundImage: AssetImage('assets/image/profile.jpg'), // Replace with valid path
                //     ),
                //     SizedBox(height: 10),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //
                //       children: [
                //         Text(
                //           fullName.isNotEmpty ? fullName : '',
                //           style: const TextStyle(
                //             fontFamily: 'cus',
                //             color: Colors.white,
                //             fontSize: 15,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //         Text(
                //           email.isNotEmpty ? email : '',
                //           style: const TextStyle(
                //               fontFamily: 'cus',
                //               color: Colors.black,
                //               fontSize: 10
                //           ),
                //         ),
                //       ],
                //     ),
                //
                //   ],
                // ),
                Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  // Use CircleAvatar to display the image
                  backgroundColor: Colors.white,
                  //radius: 30, // Increased radius for better visibility
                  radius: screenWidth * 0.1, // Increased radius for better visibility
                  backgroundImage:
                      profileImageBase64.isNotEmpty // Check if it's not empty
                          ? MemoryImage(base64Decode(profileImageBase64))
                              as ImageProvider
                          : const AssetImage(AssetsPath.defaultProfileImage)
                              as ImageProvider,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullName.isNotEmpty ? fullName : '',
                        // Display name if available, else nothing
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        email.isNotEmpty ? email : '',
                        // Display email if available, else nothing
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(
              'Home',
              style: TextStyle(fontFamily: 'cus'),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer first
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(
              'Change Your Password',
              style: TextStyle(),
            ),
            onTap: () {
              //todo fix back option
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //         const UpdatePasswordScreen())); // Replace current screen with HomeScreen
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UpdatePasswordScreen()));
            },
          ),
           ListTile(
            leading: const Icon(Icons.info),
            title: const Text(
              'About!',
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutScreen(), // Navigate to AboutUsScreen
                ),
              );
            },
          ),
           ListTile(
            leading: Icon(Icons.help_center_outlined),
            title: const Text(
              'Help!',
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HelpScreen(), // Navigate to AboutUsScreen
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.lightbulb_outline),
            title: const Text('Switch Theme'),
            onTap: _toggleTheme, // Handle the theme toggle
          ),
         // const SizedBox(height: 230), // This will work now as it's in a Column
          SizedBox(height: screenHeight * 0.23),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              'LogOut',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () async {
              // Call the signout function from AuthService
              await AuthService().signout(context);
            },
          ),
          const Divider(),
          IconButton(
            icon: const Icon(
              Icons.video_library, // YouTube icon
              color: Colors.red, // YouTube color
              size: 30, // Adjust size
            ),
            onPressed: () async {
              const url =
                  'https://youtube.com/@ibzzzzcreation2035?si=LqsbrjASWrVDZYMV'; // todo add channel id
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
        ],
      ),
    );
  }
}
