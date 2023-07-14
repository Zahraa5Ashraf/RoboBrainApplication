// ignore_for_file: camel_case_types, prefer_const_constructors

import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healthcare/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:healthcare/views/global.dart';
import 'login/components/body.dart';

class map extends StatefulWidget {
  const map({super.key});

  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final CameraPosition _kwheelchair = CameraPosition(
    target: LatLng(Token.chairlatitude, Token.chairlongitude),
    zoom: 15,
  );
  final CameraPosition _caregiver = CameraPosition(
    target: LatLng(Token.position!.latitude, Token.position!.longitude),
    zoom: 15,
  );
  LatLng destiation = LatLng(Token.chairlatitude, Token.chairlongitude);
  LatLng sourceLocation =
      LatLng(Token.position!.latitude, Token.position!.longitude);
  List<LatLng> polylineCoordinates = [];

  static final Polyline _kpolyline = Polyline(
    polylineId: const PolylineId('polylineID'),
    points: [
      LatLng(Token.chairlatitude, Token.chairlongitude),
      LatLng(Token.position!.latitude, Token.position!.longitude),
    ],
    width: 5,
    color: kPrimary2,
  );

  Timer? _timer;

  Future<void> updateWheelchairLocation() async {
    try {
      var url = Uri.parse(
          "${Token.server}caregiver/location/${Token.selectedchairid}");

      var response = await http.get(
        url,
        headers: {
          'content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
      );
      var data = json.decode(response.body);
      print(data);
      setState(() {
        destiation = LatLng(data["latitude"], data["longitude"]);
        Token.chairlatitude = data["latitude"];
        Token.chairlongitude = data["longitude"];
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

void startTimer() {
  _timer = Timer.periodic(const Duration(minutes: 1), (_) async {
    await updateWheelchairLocation();

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: destiation,
      zoom: 14,
    )));

    setState(() {
      sourceLocation = LatLng(Token.chairlatitude, Token.chairlongitude);
    });
  });
}


  void stopTimer() {
    _timer?.cancel();
  }

  // @override
  // void dispose() {
  //   _mapController.dispose();
  //   super.dispose();
  // }
  var title = 'Find Wheelchair';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text(
          'Map',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/animatedbackground.gif'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Token.position == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              mapType: MapType.hybrid,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              polylines: {
                _kpolyline,
              },
              initialCameraPosition: CameraPosition(
                  target: destiation,
                  // LatLng(position!.latitude, position!.longitude),
                  zoom: 14),
              markers: {
                Marker(
                  markerId: const MarkerId("source"),
                  infoWindow: InfoWindow(title: 'wheelchair '),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueMagenta),
                  position: sourceLocation,
                ),
                Marker(
                  markerId: MarkerId("destination"),
                  infoWindow: InfoWindow(title: Token.first_nameuser),
                  position: destiation,
                ),
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (title == 'Find Wheelchair') {
            _findwheelchair();
          } else if (title == 'locate me') {
            _locateme();
          }
          setState(() {
            title =
                (title == 'Find Wheelchair') ? 'locate me' : 'Find Wheelchair';
          });
        },
        label: Text(
          '$title',
          style: TextStyle(color: kPlaceholder3),
        ),
        icon: const Icon(
          Icons.wheelchair_pickup_rounded,
          color: kPlaceholder3,
        ),
      ),
    );
  }

  Future<void> _findwheelchair() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kwheelchair));
  }

  Future<void> _locateme() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_caregiver));
  }
}
