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
      const LatLng(24.897009504620836, 91.90024816299233),
      //tilagor -amborkhana ///1
      const LatLng(24.90459171470383, 91.89173829969421),
      //amanullah
      const LatLng(24.907594225668706, 91.88768579573347),
      //hearfundation
      const LatLng(24.905627853965893, 91.87338529318225),
      //pdb
      const LatLng(24.905088516301166, 91.87106349628722),
      //amborkhana
      const LatLng(24.90547090434948, 91.86802985196657),
      //unimart
      const LatLng(24.905930728924986, 91.86556269348777),
      //archedia
      const LatLng(24.906427378967386, 91.86225956651951),
      //royal crown
      const LatLng(24.90721840366236, 91.86080539784462),
      //subidbazar point
      const LatLng(24.9078017259765, 91.85972135757919),
      //subidbazar market
      const LatLng(24.908425663246092, 91.85751582816737),
      //khanpalace
      const LatLng(24.90979075136369, 91.85636928633673),
      //londoni
      const LatLng(24.911083978801564, 91.85474328167884),
      //pathantula
      const LatLng(24.910316362988187, 91.84974852907494),
      //pollobi
      const LatLng(24.910320144358096, 91.84883129560582),
      //modina market
      const LatLng(24.910509212721024, 91.8455209169557),
      //highway
      const LatLng(24.90921606112149, 91.83520124953007),
      //syl-sun highway
      const LatLng(24.91113778348122, 91.83223409583512),
      //sust
      const LatLng(24.912876396514108, 91.82466657471946),
      //temukhi point
      const LatLng(24.90979507099398, 91.82346372047036),
      //temukhi bridge
      const LatLng(24.907599295712018, 91.82294264998309),
      //temukhi bridge
      const LatLng(24.904814531145284, 91.8243575569687),
      //temukhi bridge
      const LatLng(24.904814531145284, 91.8243575569687),
      //temukhi bridge
      const LatLng(24.893311008658657, 91.82760485134656),
      //temukhi bridge
      const LatLng(24.88901240053569, 91.82927661262278),
      //temukhi bridge
      const LatLng(24.88597339555394, 91.830504795193),
      //railcrossing
      const LatLng(24.88169528090037, 91.81006195062095),
      // kamalbazar bridge(You can update with actual coordinates)
      const LatLng(24.880947, 91.809343),
      // kamalbazar
      const LatLng(24.877336, 91.809461),
      // kamalbazar
      const LatLng(24.876776, 91.808166),
      // kamalbazar
      const LatLng(24.876428, 91.808123),
      // kamalbazar
      const LatLng(24.876104, 91.807147),
      // kamalbazar
      const LatLng(24.875403, 91.805141),
      //gate
      const LatLng(24.874411, 91.805097),
      //mosque
      const LatLng(24.872446, 91.805228),
      //gate
      const LatLng(24.872035, 91.805023),
      //gate
      const LatLng(24.871887, 91.804902),
      //gate
      const LatLng(24.869605, 91.804312),
      // Leading University
    ],
    [
      const LatLng(24.890560, 91.867550),
      //surma tower //2
      const LatLng(24.891090420651192, 91.86537571278804),
      //
      const LatLng(24.89061218161843, 91.86402435578613),
      //
      const LatLng(24.89023789285078, 91.86117180857612),
      //
      const LatLng(24.89041224777865, 91.86053175395527),
      //afza sweet
      const LatLng(24.890522435201078, 91.85996236349712),
      // jitu mia
      const LatLng(24.891348768408545, 91.86018757794731),
      // road
      const LatLng(24.8939263903491, 91.86053973586355),
      // lamabazar
      const LatLng(24.89611813361337, 91.8613666566976),
      // lamabazar
      const LatLng(24.897143155252397, 91.86164008253971),
      // lamabazar
      const LatLng(24.89891606566305, 91.86239965756967),
      // rikabibazar audi
      const LatLng(24.902183441672747, 91.86278171337413),
      //policeline road
      const LatLng(24.902132587637258, 91.862883774674),
      //policeline road
      const LatLng(24.903264092546188, 91.86098035876698),
      //seba clinic
      const LatLng(24.903887790199402, 91.86044769624972),
      //radio
      const LatLng(24.90411745465098, 91.86014347475675),
      //middle
      const LatLng(24.90507501118313, 91.8601810607901),
      //mughaldine
      const LatLng(24.90721840366236, 91.86080539784462),
      //subidbazar point
      const LatLng(24.9078017259765, 91.85972135757919),
      //subidbazar market
      const LatLng(24.908425663246092, 91.85751582816737),
      //khanpalace
      const LatLng(24.90979075136369, 91.85636928633673),
      //londoni
      const LatLng(24.911083978801564, 91.85474328167884),
      //pathantula
      const LatLng(24.910316362988187, 91.84974852907494),
      //pollobi
      const LatLng(24.910320144358096, 91.84883129560582),
      //modina market
      const LatLng(24.910509212721024, 91.8455209169557),
      //highway
      const LatLng(24.90921606112149, 91.83520124953007),
      //syl-sun highway
      const LatLng(24.91113778348122, 91.83223409583512),
      //sust
      const LatLng(24.912876396514108, 91.82466657471946),
      //temukhi point
      const LatLng(24.90979507099398, 91.82346372047036),
      //temukhi bridge
      const LatLng(24.907599295712018, 91.82294264998309),
      //temukhi bridge
      const LatLng(24.904814531145284, 91.8243575569687),
      //temukhi bridge
      const LatLng(24.904814531145284, 91.8243575569687),
      //temukhi bridge
      const LatLng(24.893311008658657, 91.82760485134656),
      //temukhi bridge
      const LatLng(24.88901240053569, 91.82927661262278),
      //temukhi bridge
      const LatLng(24.88597339555394, 91.830504795193),
      //railcrossing
      const LatLng(24.88169528090037, 91.81006195062095),
      //kamalbazar bridge(You can update with actual coordinates)
      const LatLng(24.880947, 91.809343),
      // kamalbazar
      const LatLng(24.877336, 91.809461),
      // kamalbazar
      const LatLng(24.876776, 91.808166),
      // kamalbazar
      const LatLng(24.876428, 91.808123),
      // kamalbazar
      const LatLng(24.876104, 91.807147),
      // kamalbazar
      const LatLng(24.875403, 91.805141),
      //gate
      const LatLng(24.874411, 91.805097),
      //mosque
      const LatLng(24.872446, 91.805228),
      //gate
      const LatLng(24.872035, 91.805023),
      //gate
      const LatLng(24.871887, 91.804902),
      //gate
      const LatLng(24.869605, 91.804312),
      // Leading University
    ],
    [
      const LatLng(24.9195921903525, 91.87392059713328),
      //lakaktura ///3
      const LatLng(24.90714748043896, 91.87245450390617),
      //borobazar
      const LatLng(24.905088516301166, 91.87106349628722),
      //amborkhana
      const LatLng(24.90547090434948, 91.86802985196657),
      //unimart
      const LatLng(24.905930728924986, 91.86556269348777),
      //archedia
      const LatLng(24.906427378967386, 91.86225956651951),
      //royal crown
      const LatLng(24.90721840366236, 91.86080539784462),
      //subidbazar point
      const LatLng(24.9078017259765, 91.85972135757919),
      //subidbazar market
      const LatLng(24.908425663246092, 91.85751582816737),
      //khanpalace
      const LatLng(24.90979075136369, 91.85636928633673),
      //londoni
      const LatLng(24.911083978801564, 91.85474328167884),
      //pathantula
      const LatLng(24.910316362988187, 91.84974852907494),
      //pollobi
      const LatLng(24.910320144358096, 91.84883129560582),
      //modina market
      const LatLng(24.910509212721024, 91.8455209169557),
      //highway
      const LatLng(24.90921606112149, 91.83520124953007),
      //syl-sun highway
      const LatLng(24.91113778348122, 91.83223409583512),
      //sust
      const LatLng(24.912876396514108, 91.82466657471946),
      //temukhi point
      const LatLng(24.90979507099398, 91.82346372047036),
      //temukhi bridge
      const LatLng(24.907599295712018, 91.82294264998309),
      //temukhi bridge
      const LatLng(24.904814531145284, 91.8243575569687),
      //temukhi bridge
      const LatLng(24.904814531145284, 91.8243575569687),
      //temukhi bridge
      const LatLng(24.893311008658657, 91.82760485134656),
      //temukhi bridge
      const LatLng(24.88901240053569, 91.82927661262278),
      //temukhi bridge
      const LatLng(24.88597339555394, 91.830504795193),
      //railcrossing
      const LatLng(24.88169528090037, 91.81006195062095),
      // kamalbazar bridge(You can update with actual coordinates)
      const LatLng(24.880947, 91.809343),
      // kamalbazar
      const LatLng(24.877336, 91.809461),
      // kamalbazar
      const LatLng(24.876776, 91.808166),
      // kamalbazar
      const LatLng(24.876428, 91.808123),
      // kamalbazar
      const LatLng(24.876104, 91.807147),
      // kamalbazar
      const LatLng(24.875403, 91.805141),
      //gate
      const LatLng(24.874411, 91.805097),
      //mosque
      const LatLng(24.872446, 91.805228),
      //gate
      const LatLng(24.872035, 91.805023),
      //gate
      const LatLng(24.871887, 91.804902),
      //gate
      const LatLng(24.869605, 91.804312),
      // Leading University
    ],
    [
      const LatLng(24.896335637108603, 91.90028560336768),

      /// Ilagaor point /// //route-4
      const LatLng(24.896169381704166, 91.9001975954663),
      //tilagor 2
      const LatLng(24.895797656884437, 91.89901117910699),
      //tilagor 3
      const LatLng(24.89533241289594, 91.89828794641564),
      //chatbuzz
      const LatLng(24.895258776985447, 91.89695217976342),
      //road
      const LatLng(24.89565707974201, 91.8953839454686),
      //road
      const LatLng(24.894877208434295, 91.89342457509964),
      //dutch bangla
      const LatLng(24.895416089996665, 91.89210725829213),
      //Shibgonj
      const LatLng(24.895252082814398, 91.89070876235303),
      // Shibgonj point
      const LatLng(24.895131587603164, 91.88860179341883),
      // dudhwala
      const LatLng(24.89537927207625, 91.88653910408613),
      // road
      const LatLng(24.89529341413798, 91.88463657720321),
      // dadapir
      const LatLng(24.895294077054988, 91.88291527890833),
      // supreme
      const LatLng(24.895433239126554, 91.88166449327946),
      // Mirabazar
      const LatLng(24.895162175895468, 91.88027708073611),
      // Mirabazar2
      const LatLng(24.89472954189311, 91.87886182266932),
      // naiorpul
      const LatLng(24.893964330464318, 91.87851428057807),
      // naiorpul mosque
      const LatLng(24.893176715212903, 91.878388647501),
      // sylhet paradice
      const LatLng(24.89179552581205, 91.87793568847462),
      // subhanighat
      const LatLng(24.891404386775047, 91.87805547893012),
      // subhanighat police
      const LatLng(24.890028336479773, 91.87906245907237),
      // ena bus service
      const LatLng(24.88879555666966, 91.88008699120212),
      // veg market
      const LatLng(24.888627702718797, 91.88011557337053),
      // road
      const LatLng(24.88615074269323, 91.88104448101845),
      // Uposhor
      const LatLng(24.885041027439854, 91.88099846239612),
      // road
      const LatLng(24.884088145721982, 91.88050388279486),
      // road
      const LatLng(24.88333758451745, 91.88005322947083),
      // highway
      const LatLng(24.882508302941012, 91.87953054246763),
      // bridge
      const LatLng(24.880349201857193, 91.87834405679727),
      // bridge
      const LatLng(24.878778078798987, 91.8772712938747),
      // bandd
      const LatLng(24.877813088815802, 91.87552993891197),
      // chottor (You can update with actual coordinates)
      const LatLng(24.876110131830064, 91.86884199235213),
      // cng (You can update with actual coordinates)
      const LatLng(24.87503853121215, 91.86810501238814),
      // auto (You can update with actual coordinates)
      const LatLng(24.87324945648382, 91.86754975349136),
      // radom (You can update with actual coordinates)
      const LatLng(24.871777877310702, 91.86658393953793),
      // random (You can update with actual coordinates)
      const LatLng(24.869771982884032, 91.86517391844593),
      // random (You can update with actual coordinates)
      const LatLng(24.868288149606148, 91.86120634108418),
      // random (You can update with actual coordinates)
      const LatLng(24.867679261253905, 91.85810065402693),
      // bank (You can update with actual coordinates)
      const LatLng(24.867627828454253, 91.85704329272113),
      // chondirpul (You can update with actual coordinates)
      const LatLng(24.86529069891606, 91.8543827002042),
      // badikuna (You can update with actual coordinates)
      const LatLng(24.86450826339351, 91.85356395955962),
      // highway (You can update with actual coordinates)
      const LatLng(24.861845786299423, 91.84890988047448),
      // highway (You can update with actual coordinates)
      const LatLng(24.860612233887313, 91.84618742923544),
      // bypass point  (You can update with actual coordinates)
      const LatLng(24.86172987802158, 91.84601025847799),
      // bypass point  (You can update with actual coordinates)
      const LatLng(24.86363418416279, 91.84557511557257),
      // bypass point  (You can update with actual coordinates)
      const LatLng(24.868503717690757, 91.84423669328706),
      // bypass point  (You can update with actual coordinates)
      const LatLng(24.877454535465148, 91.83442437931517),
      // bypass point  (You can update with actual coordinates)
      const LatLng(24.880928101275817, 91.83149877635631),
      // bypass point  (You can update with actual coordinates)
      const LatLng(24.88597339555394, 91.830504795193),
      //railcrossing
      const LatLng(24.88169528090037, 91.81006195062095),
      // kamalbazar bridge(You can update with actual coordinates)
      const LatLng(24.880947, 91.809343),
      // kamalbazar
      const LatLng(24.877336, 91.809461),
      // kamalbazar
      const LatLng(24.876776, 91.808166),
      // kamalbazar
      const LatLng(24.876428, 91.808123),
      // kamalbazar
      const LatLng(24.876104, 91.807147),
      // kamalbazar
      const LatLng(24.875403, 91.805141),
      //gate
      const LatLng(24.874411, 91.805097),
      //mosque
      const LatLng(24.872446, 91.805228),
      //gate
      const LatLng(24.872035, 91.805023),
      //gate
      const LatLng(24.871887, 91.804902),
      //gate
      const LatLng(24.869605, 91.804312),
      // Leading University
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
          _centerPosition =
              driverLocation; // Set center position to the first driver's location

          // Add marker for the first driver
          _markers.add(Marker(
            markerId: MarkerId(snapshot.docs.first.id),
            position: driverLocation,
            icon: customIcon,
            infoWindow: InfoWindow(
              //todo here we can change the title

              title: 'Driver ${snapshot.docs.first.id}', // Display driver ID

              snippet:
                  'Latitude: ${data['latitude']}, Longitude: ${data['longitude']}',
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

                snippet:
                    'Latitude: ${data['latitude']}, Longitude: ${data['longitude']}',
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
          target:
              _centerPosition ?? LatLng(24.905118634980173, 91.8588028076225),
          // Default to a fallback position if no data
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
