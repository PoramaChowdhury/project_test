import 'package:flutter/material.dart';
// import 'package:project/authorities/transport/student_count.dart';
import 'package:project/features/common/ui/widgets/custom_app_bar.dart';
import 'package:project/features/student/ui/screens/seat_booking_screen.dart';
import 'package:project/features/student/ui/widgets/bottom_sheet_helper.dart';

class BusLocatorAndSeatBook extends StatefulWidget {
  const BusLocatorAndSeatBook({super.key});

  @override
  State<BusLocatorAndSeatBook> createState() => _BusLocatorAndSeatBookState();
}

class _BusLocatorAndSeatBookState extends State<BusLocatorAndSeatBook> {
  final List<String> routes = ['Route 1', 'Route 2', 'Route 3', 'Route 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Bus'),
      body: Column(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            child: Center(
                //child: Lottie.asset('assets/ani/Map1.json'),
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeatBookingScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.event_seat,
                  ),
                  label: const Text(
                    'Seat booking',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    BottomSheetHelper.showRouteBottomSheet(context, routes);
                  },
                  child: const Text('Select Route'),
                ),
              ),
              //temporary todo

            ],
          ),
        ],
      ),
    );
  }
}
