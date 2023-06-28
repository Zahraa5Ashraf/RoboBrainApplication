import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '../constants.dart';

class map extends StatefulWidget {
  const map({super.key});

  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {
  final _mapController = MapController.withUserPosition(
      trackUserLocation: UserTrackingOption(
    enableTracking: true,
    unFollowUser: false,
  ));
  Map<String, String> markerMap = {};

  @override
  void initState() {
    super.initState();
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

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OSMFlutter(
      controller: _mapController,
      mapIsLoading: const Center(
        child: CircularProgressIndicator(),
      ),
      userTrackingOption: UserTrackingOption(
        enableTracking: true,
        unFollowUser: false,
      ),
      initZoom: 12,
      minZoomLevel: 8,
      maxZoomLevel: 14,
      stepZoom: 1.0,
      userLocationMarker: UserLocationMaker(
        personMarker: MarkerIcon(
          icon: Icon(
            Icons.location_history_rounded,
            color: Colors.red,
            size: 48,
          ),
        ),
        directionArrowMarker: MarkerIcon(
          icon: Icon(
            Icons.double_arrow,
            size: 48,
            color: kPrimary2,
          ),
        ),
      ),
      roadConfiguration: RoadOption(
        roadColor: Colors.yellowAccent,
      ),
      markerOption: MarkerOption(
          defaultMarker: MarkerIcon(
        icon: Icon(
          Icons.person_pin_circle,
          color: Colors.blue,
          size: 56,
        ),
      )),
      onMapIsReady: (isReady) async {
        if (isReady) {
          await Future.delayed(const Duration(seconds: 1), () async {
            await _mapController.currentLocation();
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
}
