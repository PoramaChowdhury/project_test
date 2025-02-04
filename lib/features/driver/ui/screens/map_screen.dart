import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapScreen extends StatefulWidget {
  // final String role; // Define the role parameter
  final String driverId; // Unique identifier for the driver
  static const String name = 'driver_map';

  const MapScreen(
      {super.key,
        // required this.role,
        required this.driverId}); // Constructor with role and driverId

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Location _locationController = Location();
  LatLng? _currentP;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
    // if (widget.role == 'driver') {
    saveDriverLocation(); // Save driver's location to Firestore
    // }
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
        // if (widget.role == 'driver') {
        saveDriverLocation(); // Save driver's location to Firestore
        // }
      }
    });
  }

  void saveDriverLocation() {
    if (_currentP != null) {
      // Use the driverId to save the location under that specific driver's document
      _firestore.collection('drivers_locations').doc(widget.driverId).set({
        'latitude': _currentP!.latitude,
        'longitude': _currentP!.longitude,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location sharing')),
      body: _currentP == null
          ? const Center(child: Text("Loading map"))
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentP!,
          zoom: 19,
        ),
        markers: {
          Marker(
            markerId: MarkerId("currentLocation"),
            position: _currentP!,
          ),
        },
      ),
    );
  }
}