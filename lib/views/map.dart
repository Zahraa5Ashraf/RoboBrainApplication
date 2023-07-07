// ignore_for_file: camel_case_types

import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:healthcare/views/global.dart';
import '../constants.dart';
import 'login/components/body.dart';

class map extends StatefulWidget {
  const map({super.key});

  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {
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

      setState(() {
        Token.chairlatitude = data["latitude"];
        Token.chairlongitude = data["longitude"];
      });
    } catch (e) {
      // print(e.toString());
    }
  }

  final _mapController = MapController.withPosition(
    initPosition: GeoPoint(
      latitude: Token.chairlatitude,
      longitude: Token.chairlongitude,
    ),
  );
  Map<String, String> markerMap = {};
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapController.listenerMapSingleTapping.addListener(() async {
        var position = _mapController.listenerMapSingleTapping.value;
        if (position != null) {
          await _mapController.addMarker(position,
              markerIcon: const MarkerIcon(
                icon: Icon(
                  Icons.pin_drop,
                  color: Colors.pinkAccent,
                  size: 48,
                ),
              ));
          var key = '${position.latitude},${position.longitude}';
          markerMap[key] = markerMap.length.toString();
        }
      });
    });
  }

  // @override
  // void dispose() {
  //   _mapController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return OSMFlutter(
      onLocationChanged: (p0) {
        print('chage');
      },
      controller: _mapController,
      mapIsLoading: const Center(
        child: CircularProgressIndicator(),
      ),
      userTrackingOption: const UserTrackingOption(
        enableTracking: false,
        unFollowUser: false,
      ),
      initZoom: 14,
      minZoomLevel: 8,
      maxZoomLevel: 18.8,
      stepZoom: 1.0,
      userLocationMarker: UserLocationMaker(
        personMarker: const MarkerIcon(
          icon: Icon(
            Icons.location_history_rounded,
            color: Colors.red,
            size: 48,
          ),
        ),
        directionArrowMarker: const MarkerIcon(
          icon: Icon(
            Icons.double_arrow,
            size: 48,
            color: kPrimary2,
          ),
        ),
      ),
      roadConfiguration: const RoadOption(
        roadColor: Colors.yellowAccent,
      ),
      markerOption: MarkerOption(
          defaultMarker: const MarkerIcon(
        icon: Icon(
          Icons.person_pin_circle,
          color: Colors.blue,
          size: 56,
        ),
      )),
      onMapIsReady: (isReady) async {
        if (isReady) {
          await Future.delayed(const Duration(seconds: 1), () async {
            await _mapController.goToLocation(GeoPoint(
                latitude: Token.chairlatitude,
                longitude: Token.chairlongitude));
            await _addMarker(
              GeoPoint(
                  latitude: Token.chairlatitude,
                  longitude: Token.chairlongitude),
            );
          });
        }
      },
      onGeoPointClicked: (geoPoint) {
        var key = '${geoPoint.latitude},${geoPoint.longitude}';
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Card(
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Position ${markerMap[key]}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor,
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                              ),
                              Text(key),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.clear),
                        )
                      ],
                    )),
              );
            });
      },
    );
  }

  Future<void> _addMarker(GeoPoint position) async {
    await _mapController.addMarker(
      position,
      markerIcon: const MarkerIcon(
        icon: Icon(
          Icons.pin_drop,
          color: Colors.pinkAccent,
          size: 48,
        ),
      ),
    );
  }
}
