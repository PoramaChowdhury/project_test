import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/features/account/ui/screens/profile_screen.dart';
import 'package:project/features/ai/ui/screens/ai_bottom_nav_screen.dart';
import 'package:project/features/common/ui/widgets/navbar_app_bar.dart';
import 'package:project/features/home/ui/screens/home_screen.dart';
import 'package:project/features/home/ui/widgets/bottom_nav_bar_widget.dart';

class ClassRoomFinderScreen extends StatefulWidget {
  const ClassRoomFinderScreen({super.key});

  @override
  _ClassRoomFinderScreenState createState() => _ClassRoomFinderScreenState();
}

class _ClassRoomFinderScreenState extends State<ClassRoomFinderScreen> {
  int _currentIndex = 2;

  late GoogleMapController mapController; // Use late for initialization

  final LatLng universityLocation = LatLng(24.869552, 91.805231);

  final Map<String, LatLng> classroomLocations = {
    'G2': const LatLng(24.869393, 91.805006),
    'NL': const LatLng(24.869562, 91.805324),
    '306': const LatLng(24.869664, 91.805406),
    'ACL 1': const LatLng(24.869681, 91.805077),
    'ACL 2': const LatLng(24.869681, 91.805149),
    '302': const LatLng(24.869765, 91.805117),
    '304': const LatLng(24.869751, 91.805200),
    '309': const LatLng(24.869503, 91.805320),
  };

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {}; // Set for polyline

  @override
  void initState() {
    super.initState();
    _markers = classroomLocations.entries.map((entry) {
      return Marker(
        markerId: MarkerId(entry.key),
        position: entry.value,
        infoWindow: InfoWindow(title: entry.key),
      );
    }).toSet();


    final List<LatLng> liftCoordinates = [
      const LatLng(24.869774, 91.805312),  // Bottom-left
      const LatLng(24.869774, 91.805394),  // Top-left
      const LatLng(24.869755, 91.805394),  // Top-right
      const LatLng(24.869755, 91.805312),  // Bottom-right
      const LatLng(24.869774, 91.805312),  // Closing the square (Bottom-left again)

    ];

    _polylines.add(Polyline(
      polylineId: const PolylineId("lift_polyline"),
      points: liftCoordinates,
      color: Colors.blue, // Color of the polyline
      width: 5, // Width of the polyline
    ));
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onNavBarTapped(int index) async {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else if (index == 1) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const AiBottomNavScreen()));
    } else if (index == 2) {
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else if (index == 3) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarAppBar(
        title: 'Classroom Finder',
        automaticallyImplyLeading: false,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: universityLocation,
          zoom: 20.0, // Adjust zoom level as needed
        ),
        markers: _markers,
        polylines: _polylines, // Add the polyline to the map
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: _currentIndex,
        onNavBarTapped: _onNavBarTapped,
      ),
    );
  }
}
