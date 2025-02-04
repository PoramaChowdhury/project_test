/*
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:project/app/asset_path.dart';
import 'package:project/features/auth/service/auth_service.dart';
import 'package:project/features/auth/ui/screens/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:lottie/lottie.dart'; // Make sure to import Lottie

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    this.isProfileScreenOpen = false,
  });

  final bool isProfileScreenOpen;

  @override
  _HomeAppBarState createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  String name = '';
  String email = '';
  String profileImageBase64 = ''; // Define and initialize the variable
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

 */
/* // Function to load user data from Firestore
  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        Map<String, String> userData =
        await AuthService().getUserData(user.uid);
        setState(() {
          name = userData['firstName'] ?? '';
          email = userData['email'] ?? '';
        });
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
  }*//*

//todo for profile image
*/
/*
  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        Map<String, dynamic> userData = await AuthService().getUserData(user.uid); // Get all user data
        setState(() {
          name = userData['firstName'] ?? '';
          email = userData['email'] ?? '';
          profileImageUrl = userData['profileImageUrl'] ?? ''; // Access the image URL
        });
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
  }
*//*

  // Future<void> _loadUserData() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     try {
  //       Map<String, dynamic> userData = await AuthService().getUserData(user.uid);
  //       setState(() { // This setState is CRUCIAL for updating the UI
  //         name = userData['firstName'] ?? '';
  //         email = userData['email'] ?? '';
  //         profileImageBase64 = userData['profileImageBase64'] ?? '';
  //       });
  //     } catch (e) {
  //       print("Error fetching user data: $e");
  //     }
  //   }
  // }

  // Future<void> _loadUserData() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     try {
  //       Map<String, dynamic> userData = await AuthService().getUserData(user.uid);
  //       if (mounted) { // Check if the widget is still mounted before calling setState
  //         setState(() {
  //           name = userData['firstName'] ?? '';
  //           email = userData['email'] ?? '';
  //           profileImageBase64 = userData['profileImageBase64'] ?? '';
  //         });
  //       }
  //     } catch (e) {
  //       print("Error fetching user data: $e");
  //     }
  //   }
  // }
  // Future<void> _loadUserData() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     try {
  //       // 1. Try to get from Shared Preferences first
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       String? storedBase64 = prefs.getString('profileImageBase64');
  //
  //       if (storedBase64 != null && storedBase64.isNotEmpty) {
  //         print("Image loaded from Shared Preferences.");
  //         if (mounted) {
  //           setState(() {
  //             profileImageBase64 = storedBase64;
  //           });
  //         }
  //       } else {
  //         // 2. If not in Shared Preferences, get from Firestore
  //         Map<String, dynamic> userData = await AuthService().getUserData(user.uid);
  //         if (mounted) {
  //           setState(() {
  //             name = userData['firstName'] ?? '';
  //             email = userData['email'] ?? '';
  //             profileImageBase64 = userData['profileImageBase64'] ?? '';
  //           });
  //         }
  //         if (profileImageBase64.isNotEmpty) { // Save to Shared Preferences if fetched from Firestore
  //           await prefs.setString('profileImageBase64', profileImageBase64);
  //         }
  //       }
  //     } catch (e) {
  //       print("Error fetching user data: $e");
  //     }
  //   }
  // }


  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? storedBase64 = prefs.getString('profileImageBase64');

        if (storedBase64 != null && storedBase64.isNotEmpty) {
          if (mounted) {
            setState(() {
              profileImageBase64 = storedBase64;
            });
          }
        }

        Map<String, dynamic> userData = await AuthService().getUserData(user.uid);
        if (mounted) {
          setState(() {
            name = userData['firstName'] ?? ''; // Use firstName
            email = userData['email'] ?? '';
            profileImageBase64 = userData['profileImageBase64'] ?? '';
          });
        }
        if (profileImageBase64.isNotEmpty && storedBase64 == null) {
          await prefs.setString('profileImageBase64', profileImageBase64);
        }
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
  }


  // Future<void> _pickImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (image != null) {
  //     setState(() {
  //       _profileImage = File(image.path);
  //     });
  //     _uploadImageBase64(_profileImage!); // Call the Base64 upload function
  //   }
  // }

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

*/
/*
  Future<void> _uploadProfileImage() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && _profileImage != null) {
      try {
        final ref = FirebaseStorage.instance
            .ref()
            .child('profile_images/${user.uid}.jpg');
        final uploadTask = ref.putFile(_profileImage!);
        final snapshot = await uploadTask.whenComplete(() {});
        final downloadUrl = await snapshot.ref.getDownloadURL();

        await AuthService().updateProfileImage(user.uid, downloadUrl);

        setState(() {
          profileImageUrl = downloadUrl;
          _profileImage = null; // Clear the local file after upload
        });
      } catch (e) {
        print('Error uploading image: $e');
        // Handle error, e.g., show a snackbar
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error uploading image')));

      }
    }
  }
*//*

//todo upload ok but not show
  // Future<void> _uploadImageBase64(File imageFile) async {
  //   try {
  //     final bytes = await imageFile.readAsBytes(); // Read image as bytes
  //     final base64Image = base64Encode(bytes); // Encode bytes to Base64
  //
  //     User? user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       // Get the user's role from SharedPreferences
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       String? role = prefs.getString('role');
  //       CollectionReference userCollection;
  //
  //       if (role == 'students') {
  //         userCollection = FirebaseFirestore.instance.collection('students');
  //       } else if (role == 'teachers') {
  //         userCollection = FirebaseFirestore.instance.collection('teachers');
  //       } else if (role == 'drivers') {
  //         userCollection = FirebaseFirestore.instance.collection('drivers');
  //       } else if (role == 'transport') {
  //         userCollection = FirebaseFirestore.instance.collection('transports');
  //       } else {
  //         userCollection = FirebaseFirestore.instance.collection('users'); // Default
  //       }
  //
  //       await userCollection.doc(user.uid).update({
  //         'profileImageBase64': base64Image, // Store Base64 string in Firestore
  //       });
  //
  //       setState(() { // This setState is CRUCIAL for updating the UI
  //         profileImageBase64 = base64Image;
  //         _profileImage = null; // Clear the local file
  //       });
  //
  //       // Update UI or show a message
  //       print('Image uploaded (Base64)');
  //     }
  //   } catch (e) {
  //     print('Error uploading image (Base64): $e');
  //   }
  // }


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
      appBar: AppBar(
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Icon(Icons.menu), // Hamburger icon
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        flexibleSpace: Container(
          height: 300.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF66B2B2),
                Color(0xFF66B2B2),
              ],
            ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(11, 11),
            ),
          ),
        ),
        title: Row(
          children: [
            */
/*const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
            ),*//*

            //todo for profile image
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                // backgroundImage: profileImageUrl.isNotEmpty
                //     ? NetworkImage(profileImageUrl)
                //     : const AssetImage(AssetsPath.defaultProfileImage) as ImageProvider,
                backgroundImage: profileImageBase64.isNotEmpty
                    ? MemoryImage(base64Decode(profileImageBase64)) as ImageProvider
                    : const AssetImage(AssetsPath.defaultProfileImage) as ImageProvider,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello',
                    style: GoogleFonts.dynaPuff(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    name.isNotEmpty ? name : '',
                    // Display name if available, else nothing
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 2),
                  */
/*Text(
                    email.isNotEmpty ? email : '',
                    // Display email if available, else nothing
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),*//*

                ],
              ),
            ),
            //todo uncomment korio just line erro ou comnt kotsi
            IconButton(
                onPressed: () async {
                  // Call the signout function from AuthService
                  await AuthService().signout(context);
                },
                icon: _buildLottieIcon(AssetsPath.logout)// Replace with valid path
            ),
          ],
        ),
      ),
    );
  }

//todo:icon lottie add
  Widget _buildLottieIcon(String assetPath) {
    return Lottie.asset(
      assetPath,
      width: 35,
      height: 35,
    );
  }
}*/
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:project/app/asset_path.dart';
import 'package:project/features/auth/service/auth_service.dart';
import 'package:project/features/auth/ui/screens/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  _HomeAppBarState createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  String name = '';
  String email = '';
  String profileImageBase64 = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? storedBase64 = prefs.getString('profileImageBase64');

        if (storedBase64 != null && storedBase64.isNotEmpty) {
          if (mounted) {
            setState(() {
              profileImageBase64 = storedBase64;
            });
          }
        }

        Map<String, dynamic> userData = await AuthService().getUserData(user.uid);
        if (mounted) {
          setState(() {
            name = userData['firstName'] ?? '';
            email = userData['email'] ?? '';
            profileImageBase64 = userData['profileImageBase64'] ?? '';
          });
        }
        if (profileImageBase64.isNotEmpty && storedBase64 == null) {
          await prefs.setString('profileImageBase64', profileImageBase64);
        }
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      flexibleSpace: Container(
        height: 300.0,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF66B2B2),
              Color(0xFF66B2B2),
            ],
          ),
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(11, 11),
          ),
        ),
      ),
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            backgroundImage: profileImageBase64.isNotEmpty
                ? MemoryImage(base64Decode(profileImageBase64)) as ImageProvider
                : const AssetImage(AssetsPath.defaultProfileImage) as ImageProvider,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello',
                  style: GoogleFonts.dynaPuff(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Text(
                  name.isNotEmpty ? name : '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              await AuthService().signout(context);
            },
            icon: _buildLottieIcon(AssetsPath.logout),
          ),
        ],
      ),
    );
  }

  Widget _buildLottieIcon(String assetPath) {
    return Lottie.asset(
      assetPath,
      width: 35,
      height: 35,
    );
  }
}
