import 'package:flutter/material.dart';
import 'package:project/features/common/ui/widgets/custom_app_bar.dart';
import 'package:project/features/student/resource_link/service/firebase_resource.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourceLinkScreen extends StatefulWidget {
  const ResourceLinkScreen({super.key});

  @override
  _ResourceLinkScreenState createState() => _ResourceLinkScreenState();
}

class _ResourceLinkScreenState extends State<ResourceLinkScreen> {
  late Future<Map<String, dynamic>> _subjects;
  final FirebaseResource _firebaseService = FirebaseResource();

  @override
  void initState() {
    super.initState();
    _subjects = _firebaseService.fetchSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title:'Resource'),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _subjects, // Fetch and display the subject data here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No subjects available.'));
          }


          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              String subjectKey = snapshot.data!.keys.elementAt(index);
              var subjectLinks = snapshot.data![subjectKey];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subjectKey, // Subject name
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      buildLinks(subjectLinks),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }


  Widget buildLinks(dynamic links) {
    List<Widget> linkWidgets = [];

    if (links is Map) {
      links.forEach((key, value) {
        linkWidgets.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              key,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        );
        linkWidgets.add(buildLinks(value));
      });
    } else if (links is List) {

      for (var link in links) {
        linkWidgets.add(
          ListTile(
            title: const Text('Open Link'),
            onTap: () => _launchURL(link),
            trailing: const Icon(Icons.link),
          ),
        );
      }
    } else if (links is String) {
      // If links is a string, it's a direct link
      linkWidgets.add(
        ListTile(
          title: const Text('Open Link'),
          onTap: () => _launchURL(links),
          trailing: const Icon(Icons.link),
        ),
      );
    }
    return Column(children: linkWidgets);
  }


  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}


