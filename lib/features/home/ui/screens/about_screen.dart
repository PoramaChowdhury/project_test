import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Text('About App',style: GoogleFonts.dynaPuff(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About Campus Guru",
                style: GoogleFonts.dynaPuff(
                  color: Theme.of(context).textTheme.titleLarge?.color ?? Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "This app is designed to make campus life more convenient for students, faculty, and the transportation team. It offers features like real-time bus tracking, seat booking for buses, academic record tracking, AI-powered assistance, and more.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                "Key Features by Role:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Features for Student
              const Text(
                "For Students:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "- Real-time bus tracking\n- Seat booking\n- Academic CGPA Prediction\n- Semester fee count\n- AI-powered chatbot\n- Faculty and alumni information\n- PC Build Guide",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Features for Teacher
              const Text(
                "For Teachers:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "- Real-time bus tracking\n- AI-powered chatbot",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Features for Transport Authority
              const Text(
                "For Transport Authority:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "- Get daily student count for specific routes and times and Route management",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Features for Driver
              const Text(
                "For Drivers:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "- Share location",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Divider(),  // Optional divider to separate sections
              const SizedBox(height: 10),
              const Text(
                "Developed by:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Ibshar Ibna Ebad and Porama Chowdhury",
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white70  // Light grey color for dark mode
                      : Colors.black54, // Dark grey color for light mode
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
