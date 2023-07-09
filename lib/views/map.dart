// ignore_for_file: camel_case_types

import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  Timer? _timer;

  Future<void> sensorupdate(Timer timer) async {
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
        Token.chairlatitude = data["latitude"];
        Token.chairlongitude = data["longitude"];
      });
    } catch (e) {
      // print(e.toString());
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), sensorupdate);
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  // @override
  // void dispose() {
  //   _mapController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('map'),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
