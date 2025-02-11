import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Text(
          'Help & Support',
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email Support'),
            onTap: () async {
              final Uri emailUri = Uri(
                scheme: 'mailto',
                path:
                    'cse_182210012101018@lus.ac.bd,cse_182210012101023@lus.ac.bd',
                // Replace with your support email
                query:
                    'subject=App Support&body=Hello, I need help with...', // Optional
              );
              if (await canLaunch(emailUri.toString())) {
                await launch(emailUri.toString());
              } else {
                throw 'Could not launch $emailUri';
              }
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.help_outline),
          //   title: const Text('FAQs'),
          //   onTap: () {
          //     // Add your FAQ screen navigation here
          //     // Navigator.push(
          //     //   context,
          //     //   MaterialPageRoute(
          //     //     builder: (context) => FAQScreen(),
          //     //   ),
          //     // );
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Contact Us'),
            onTap: () async {
              final Uri phoneUri = Uri(
                  scheme: 'tel',
                  path:
                      '+88017********'); // Replace with your support phone number
              if (await canLaunch(phoneUri.toString())) {
                await launch(phoneUri.toString());
              } else {
                throw 'Could not make a call';
              }
            },
          ),
        ],
      ),
    );
  }
}
