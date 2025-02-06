import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:project/app/asset_path.dart';
import 'package:project/features/auth/service/auth_service.dart';

class AppBarLogout extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const AppBarLogout({Key? key, required this.title}) : super(key: key);

  @override
  _AppBarLogoutState createState() => _AppBarLogoutState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarLogoutState extends State<AppBarLogout> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      title: Text(
        widget.title, // Use widget.title to access the title property
        style: GoogleFonts.dynaPuff(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(
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
      actions: [
        IconButton(
            onPressed: () async {
              // Call the signout function from AuthService
              await AuthService().signout(context);
            },
            icon: _buildLottieIcon(AssetsPath.logout)// Replace with valid path
        ),
      ],
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
