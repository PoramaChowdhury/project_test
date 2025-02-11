import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/app/asset_path.dart';
import 'package:project/features/account/ui/screens/update_name_screen.dart';
import 'package:project/features/ai/ui/screens/ai_bottom_nav_screen.dart';
import 'package:project/features/auth/ui/screens/update_password_screen.dart';
import 'package:project/features/common/ui/widgets/navbar_app_bar.dart';
import 'package:project/features/home/ui/screens/home_screen.dart';
import 'package:project/features/home/ui/widgets/bottom_nav_bar_widget.dart';
import 'package:project/features/student/classroom_finder/ui/screen/classroom_finder_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Uncomment and set up image picking if you need the profile picture functionality
  // XFile? _imageFile;

  int _currentIndex = 3;

  String profileImageBase64 = '';
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }
  Future<void> _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedBase64 = prefs.getString('profileImageBase64');
    if (storedBase64 != null && storedBase64.isNotEmpty) {
      setState(() {
        profileImageBase64 = storedBase64;
      });
    }
  }


  void _onNavBarTapped(int index) async {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else if (index == 1) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const AiBottomNavScreen()));
    } else if (index == 2) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ClassRoomFinderScreen()));
    } else if (index == 3) {
      //  already the current screen so no action need
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });

      await _uploadImageBase64(_profileImage!);
    }
  }

  Future<void> _uploadImageBase64(File imageFile) async {
    try {
      final compressedFile = await FlutterImageCompress.compressWithFile(
        imageFile.path,
        quality: 50,
      );

      if (compressedFile != null) {
        final bytes = compressedFile;
        final base64Image = base64Encode(bytes!);

        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? role = prefs.getString('role');
          CollectionReference userCollection;

          // Determine the user collection based on role (same as before)
          if (role == 'students') {
            userCollection = FirebaseFirestore.instance.collection('students');
          } else if (role == 'teachers') {
            userCollection = FirebaseFirestore.instance.collection('teachers');
          } else if (role == 'drivers') {
            userCollection = FirebaseFirestore.instance.collection('drivers');
          } else if (role == 'transport') {
            userCollection = FirebaseFirestore.instance.collection('transports');
          } else {
            userCollection = FirebaseFirestore.instance.collection('users'); // Default
          }

          await userCollection.doc(user.uid).update({
            'profileImageBase64': base64Image,
          });

          await prefs.setString('profileImageBase64', base64Image); // Store in shared preferences

          setState(() {
            profileImageBase64 = base64Image;
            _profileImage = null;
          });
        }
      } else {
        print('Image compression failed');
      }
    } catch (e) {
      print('Error uploading image (Base64): $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarAppBar(
        title: 'Account Info',
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              _buildSectionHeader("Profile"),
              _buildProfileSection(),
              _buildAccountActionsSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: _currentIndex,
        onNavBarTapped: _onNavBarTapped,
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [




        GestureDetector(
          onTap:  _pickImage,

          child: Center(
            child: CircleAvatar(
              radius: 100, // Increased size
              backgroundColor: Colors.blueGrey,
              backgroundImage: profileImageBase64.isNotEmpty
                  ? MemoryImage(base64Decode(profileImageBase64))
              as ImageProvider
                  : const AssetImage(AssetsPath.defaultProfileImage)
              as ImageProvider,
              child: profileImageBase64.isEmpty
                  ? const Icon(Icons.camera_alt, size: 60, color: Colors.white) // Increased icon size
                  : null,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Divider(),
      ],
    );
  }

  // Updated Account Actions Section with ListTile for better UI structure
  Widget _buildAccountActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text('Update Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          leading: const Icon(Icons.edit),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigate to update name screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UpdateNameScreen()),
            );
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('Change Password',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          leading: const Icon(Icons.password),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigate to update password screen
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const UpdatePasswordScreen()),
            );
          },
        ),
      ],
    );
  }
}
