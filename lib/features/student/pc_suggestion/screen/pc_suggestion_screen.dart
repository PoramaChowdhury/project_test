import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/features/common/ui/widgets/custom_app_bar.dart';
import 'package:project/features/home/ui/widgets/custom_carousel_slider_image.dart';
import 'package:project/features/student/pc_suggestion/widgets/pc_carousel/pc_carouselslider.dart';

class PcSuggestionScreen extends StatefulWidget {
  const PcSuggestionScreen({Key? key}) : super(key: key);

  @override
  State<PcSuggestionScreen> createState() => _PcSuggestionScreenState();
}

class _PcSuggestionScreenState extends State<PcSuggestionScreen> {
  late CollectionReference pcCollection; // Declare CollectionReference

  @override
  void initState() {
    super.initState();
    // Initialize CollectionReference in initState
    pcCollection = FirebaseFirestore.instance.collection('pc');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'PC build guide'),
      body: StreamBuilder<QuerySnapshot>(
        stream: pcCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text('Something went wrong: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No data available."));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              // Access your fields, handling potential nulls
              String article = data['article'] ??
                  ''; // Replace 'article' with your field name
              String budget18 = data['18k'] ?? '';

              String budget25 = data['25k'] ?? '';

              String budget45 = data['45k'] ?? '';

              // Replace 'article' with your field name
              // Example: String processor = data['processor'] ?? 'N/A';
              // Example: int ram = data['ram'] ?? 0;

              return Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  PcCarouselSliderImage(),
                  const SizedBox(
                    height: 5,
                  ),
                  Card(
                    // Use Card for better visual separation
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //todo bangla added
                          const Text(
                            "ভুমিকাঃ", // Label for the field
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(article), // Display the article text

                          // Add more Text widgets for other fields as needed
                          // Example:
                          // Text("Processor: $processor"),
                          // Text("RAM: $ram GB"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Card(
                    // Use Card for better visual separation
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //todo bangla added
                          const Text(
                            "বাজেট ১৮ হাজার টাকা: ", // Label for the field
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(budget18), // Display the article text

                          // Add more Text widgets for other fields as needed
                          // Example:
                          // Text("Processor: $processor"),
                          // Text("RAM: $ram GB"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Card(
                    // Use Card for better visual separation
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //todo bangla added
                          const Text(
                            "বাজেট ২৫ হাজার টাকাঃ", // Label for the field
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(budget25), // Display the article text

                          // Add more Text widgets for other fields as needed
                          // Example:
                          // Text("Processor: $processor"),
                          // Text("RAM: $ram GB"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Card(
                    // Use Card for better visual separation
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //todo bangla added
                          const Text(
                            "জিপিইউ দিয়ে ৪৫ হাজার টাকারঃ",
                            // Label for the field
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(budget45), // Display the article text

                          // Add more Text widgets for other fields as needed
                          // Example:
                          // Text("Processor: $processor"),
                          // Text("RAM: $ram GB"),
                        ],
                      ),
                    ),
                  ),
                  const Text('Data collected from - Pc Builder Bangladesh '),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
