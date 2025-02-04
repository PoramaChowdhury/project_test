import 'package:flutter/material.dart';
import 'package:project/features/student/ui/screens/map_screen_student.dart';

class BottomSheetHelper {
  // Function to show the bottom sheet with route details
  static void showRouteBottomSheet(BuildContext context, List<String> routes) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.blueGrey],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,  // Ensures the sheet takes up minimal space
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Route Details',
                  style: TextStyle(
                    fontFamily: 'cus',
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              const Divider(thickness: 4, color: Colors.grey),
              const SizedBox(height: 8), // Space between Divider and the list
              Expanded(  // To make the list scrollable
                child: ListView.builder(
                  shrinkWrap: true, // To allow ListView to take only required space
                  itemCount: routes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(routes[index]),
                      onTap: () {


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
              ),
            ],
          ),
        );
      },
    );
  }
}