/*
import 'package:flutter/material.dart';
import 'package:project/features/common/ui/widgets/custom_app_bar.dart';

// import 'package:project/features/student/transportation/ui/screens/map_screen_student.dart';
import 'package:project/features/student/ui/screens/map_screen_student.dart';

class SelectRoutesScreen extends StatelessWidget {
  final List<String> routes = ['Route 1', 'Route 2', 'Route 3', 'Route 4'];
  final List<String> points = [
    'Tilagor --> Baluchar --> TB Gate --> Eidgah --> Electric Supply --> Amberkhana --> Dorshondewry --> Subidbazar --> Londony Road --> Pathantula --> Modina Market --> Akhalia Mosque --> Surmagate --> SUST Gate --> Temukhi Bridge --> Rail Crossing --> Ragib Nagar',
    'Surmatower --> Jitumiar Point --> Kazirbazar Bridge --> Lamabazar --> Rikabibazar --> Radio Office --> Subidbazar --> Londony Road --> Pathantula --> Modina Market --> Akhalia Mosque --> Surmagate --> SUST Gate --> Temukhi Bridge --> Rail Crossing --> Ragib Nagar',
    'Lakkatura --> Chowkidekhi Point --> Khashdobir --> Mazumdar Fulkoli --> Amberkhana --> Dorshondewry --> Subidbazar --> Londony Road --> Pathantula --> Modina Market --> Akhalia Mosque --> Surmagate --> SUST Gate --> Temukhi Bridge --> Rail Crossing --> Ragib Nagar',
    'Tilagor --> Shibgonj --> Naiorpul --> Subhanighat Point --> Rose View Point --> Humayun Rashid Chattar --> Chandirpul --> Bypass --> Rail Crossing --> Ragib Nagar'
  ];

  static const String name = '/select-routes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Select a Route'),
      body: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(routes[index]),
            subtitle: Text(points[index]),
            onTap: () {
              // Navigate to the map screen and pass the selected route
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentMapScreen(routeIndex: index),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:project/features/common/ui/widgets/custom_app_bar.dart';
import 'package:project/features/student/transport/ui/screens/map_screen_student.dart';

class SelectRoutesScreen extends StatelessWidget {
  final List<String> routes = ['Route 1', 'Route 2', 'Route 3', 'Route 4'];
  final List<String> points = [
    'Tilagor --> Baluchar --> TB Gate --> Eidgah --> Electric Supply --> Amberkhana --> Dorshondewry --> Subidbazar --> Londony Road --> Pathantula --> Modina Market --> Akhalia Mosque --> Surmagate --> SUST Gate --> Temukhi Bridge --> Rail Crossing --> Ragib Nagar',
    'Surmatower --> Jitumiar Point --> Kazirbazar Bridge --> Lamabazar --> Rikabibazar --> Radio Office --> Subidbazar --> Londony Road --> Pathantula --> Modina Market --> Akhalia Mosque --> Surmagate --> SUST Gate --> Temukhi Bridge --> Rail Crossing --> Ragib Nagar',
    'Lakkatura --> Chowkidekhi Point --> Khashdobir --> Mazumdar Fulkoli --> Amberkhana --> Dorshondewry --> Subidbazar --> Londony Road --> Pathantula --> Modina Market --> Akhalia Mosque --> Surmagate --> SUST Gate --> Temukhi Bridge --> Rail Crossing --> Ragib Nagar',
    'Tilagor --> Shibgonj --> Naiorpul --> Subhanighat Point --> Rose View Point --> Humayun Rashid Chattar --> Chandirpul --> Bypass --> Rail Crossing --> Ragib Nagar'
  ];
  static const String name = '/select-routes';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Select a Route'),
      body: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentMapScreen(routeIndex: index),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(routes[index],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                    const Divider(),
                    const Text("Bus Stoppage Point:",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(points[index]),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
