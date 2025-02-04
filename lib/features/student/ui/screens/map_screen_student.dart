import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/features/common/ui/widgets/custom_app_bar.dart';

class StudentMapScreen extends StatefulWidget {
  final int routeIndex;
  const StudentMapScreen({super.key, required this.routeIndex});

  @override
  State<StudentMapScreen> createState() => _StudentMapScreenState();
}

class _StudentMapScreenState extends State<StudentMapScreen> {
  Set<Marker> _markers = {};
  Set<Polyline> _polyline = {};
  LatLng? _centerPosition;
  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;

  List<List<LatLng>> routes = [
    [
      const LatLng(24.897009504620836, 91.90024816299233),//tilagor -amborkhana ///1
      const LatLng(24.90459171470383, 91.89173829969421),//amanullah
      const LatLng(24.907594225668706, 91.88768579573347),//hearfundation
      const LatLng(24.905627853965893, 91.87338529318225),//pdb
      const LatLng(24.905088516301166, 91.87106349628722),//amborkhana
      const LatLng(24.90547090434948, 91.86802985196657),//unimart
      const LatLng(24.905930728924986, 91.86556269348777),//archedia
      const LatLng(24.910377261845923, 91.85227261008751),//scholarshome
      const LatLng(24.90921606112149, 91.83520124953007),//syl-sun highway
      const LatLng(24.91113778348122, 91.83223409583512),//sust
      const LatLng(24.912876396514108, 91.82466657471946),//temukhi point
      const LatLng(24.909554082018868, 91.82341612228858),//temukhi bridge
      const LatLng(24.88597339555394, 91.830504795193),//railcrossing
      const LatLng(24.88597339555394, 91.830504795193),//railcrossing
      const LatLng(24.88169528090037, 91.81006195062095), // kamalbazar bridge(You can update with actual coordinates)
      const LatLng(24.869582156548002, 91.80485752211375), // Leading University
    ],
    [
      const LatLng(24.890522193470222, 91.86758341469763), //surma tower //2
      const LatLng(24.890522435201078, 91.85996236349712), // jitu mia
      const LatLng(24.89611813361337, 91.8613666566976), // lamabazar
      const LatLng(24.89891606566305, 91.86239965756967), // rikabibazar audi
      const LatLng(24.902183441672747, 91.86278171337413), //policeline road
      const LatLng(24.90603232391345, 91.86049456881275), //press club
      const LatLng(24.90721840366236, 91.86080539784462), //subidbazar point
      const LatLng(24.910377261845923, 91.85227261008751),//scholarshome
      const LatLng(24.90921606112149, 91.83520124953007),//syl-sun highway
      const LatLng(24.91113778348122, 91.83223409583512),//sust
      const LatLng(24.912876396514108, 91.82466657471946),//temukhi point
      const LatLng(24.909554082018868, 91.82341612228858),//temukhi bridge
      const LatLng(24.88597339555394, 91.830504795193),//railcrossing
      const LatLng(24.88169528090037, 91.81006195062095), // kamalbazar bridge(You can update with actual coordinates)
      const LatLng(24.869582156548002, 91.80485752211375), // Leading University
    ],
    [
      const LatLng(24.9195921903525, 91.87392059713328),//lakaktura ///3
      const LatLng(24.90714748043896, 91.87245450390617),//borobazar
      const LatLng(24.905088516301166, 91.87106349628722),//amborkhana
      const LatLng(24.90547090434948, 91.86802985196657),//unimart
      const LatLng(24.905930728924986, 91.86556269348777),//archedia
      const LatLng(24.90721840366236, 91.86080539784462), //subidbazar point
      const LatLng(24.910377261845923, 91.85227261008751),//scholarshome
      const LatLng(24.90921606112149, 91.83520124953007),//syl-sun highway
      const LatLng(24.91113778348122, 91.83223409583512),//sust
      const LatLng(24.912876396514108, 91.82466657471946),//temukhi point
      const LatLng(24.909554082018868, 91.82341612228858),//temukhi bridge
      const LatLng(24.88597339555394, 91.830504795193),//railcrossing
      const LatLng(24.88169528090037, 91.81006195062095), // kamalbazar bridge(You can update with actual coordinates)
      const LatLng(24.869582156548002, 91.80485752211375), // Leading University
    ],
    [
      const LatLng(24.89642428136203, 91.90025648229512), // Ilagaor point ///4
      const LatLng(24.89538402016021, 91.89065455094972), // Shibgonj point
      const LatLng(24.895433239126554, 91.88166449327946), // Mirabazar
      const LatLng(24.89482877646885, 91.87897896855895), // naiorpul
      const LatLng(24.89179493276936, 91.87793135670664), // subhanighat
      const LatLng(24.886668889282436, 91.88104378849843), // Uposhor (You can update with actual coordinates)
      const LatLng(24.877813088815802, 91.87552993891197), // chottor (You can update with actual coordinates)
      const LatLng(24.867627828454253, 91.85704329272113), // chondirpul (You can update with actual coordinates)
      const LatLng(24.86529069891606, 91.8543827002042), // badikuna (You can update with actual coordinates)
      const LatLng(24.861939137579846, 91.84907525419955), // highway (You can update with actual coordinates)
      const LatLng(24.861092085628876, 91.84613517116188), // bypass point  (You can update with actual coordinates)
      const LatLng(24.88597339555394, 91.830504795193),//railcrossing
      const LatLng(24.88169528090037, 91.81006195062095), // kamalbazar bridge(You can update with actual coordinates)
      const LatLng(24.869582156548002, 91.80485752211375), // Leading University
    ],

  ];

  @override
  void initState() {
    super.initState();
    customMarker();
    getDriversLocation();
    //todo change from pcai
    addPolyline();

  }

  // Load custom marker icon
  Future<void> customMarker() async {
    //todo fromAssetImage will deprecated soon
    final BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/images/marker.png', // Make sure the image path is correct
    );
    setState(() {
      customIcon = icon;
    });
  }

  //todo change from pcai
  void addPolyline() {
    List<LatLng> selectedRoute = routes[widget.routeIndex];
    setState(() {
      _polyline.add(
        Polyline(
          polylineId: const PolylineId('selectedRoute'),
          points: selectedRoute,
          color: Colors.blue,
          width: 5,
        ),
      );
    });
  }


  Future<void> getDriversLocation() async {
    // Listen for changes in driver locations from Firestore
    FirebaseFirestore.instance
        .collection('drivers_locations')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        //todo ill check it
        _markers.clear(); // Clear previous markers
        if (snapshot.docs.isNotEmpty) {
          // Assuming the first driver is the one to center on
          var data = snapshot.docs.first.data();
          LatLng driverLocation = LatLng(data['latitude'], data['longitude']);
          _centerPosition = driverLocation; // Set center position to the first driver's location

          // Add marker for the first driver
          _markers.add(Marker(
            markerId: MarkerId(snapshot.docs.first.id),
            position: driverLocation,
            icon: customIcon,
            infoWindow: InfoWindow(
              //todo here we can change the title

              title: 'Driver ${snapshot.docs.first.id}', // Display driver ID

              snippet: 'Latitude: ${data['latitude']}, Longitude: ${data['longitude']}',
            ),
          ));
        }

        // Add additional markers for other drivers if necessary
        for (var doc in snapshot.docs.skip(1)) {
          var data = doc.data();
          if (data != null) {
            LatLng driverLocation = LatLng(data['latitude'], data['longitude']);
            _markers.add(Marker(
              markerId: MarkerId(doc.id),
              position: driverLocation,
              icon: customIcon,
              infoWindow: InfoWindow(
              title: 'Driver ${doc.id}', // Display driver ID

                snippet: 'Latitude: ${data['latitude']}, Longitude: ${data['longitude']}',
              ),
            ));
          }

        }
        // Add polyline representing the route

      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: const CustomAppBar(title: ('Track Your Bus')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _centerPosition ?? LatLng(24.905118634980173, 91.8588028076225), // Default to a fallback position if no data
          zoom: 12.4,
        ),
        markers: _markers,
        polylines: _polyline,
        // Update the camera position when the first driver's location is available
        onMapCreated: (GoogleMapController controller) {
          if (_centerPosition != null) {
            controller.animateCamera(
              CameraUpdate.newLatLng(_centerPosition!),
            );
          }
        },
      ),
    );
  }
}
