import 'package:flutter/material.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Map extends StatelessWidget {
  const Map({Key? key, required this.googleMapsLink, required this.name})
      : super(key: key);

  final String googleMapsLink;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: PlatformMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(52.4940361, 13.4440809),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: MarkerId('marker_1'),
            position: const LatLng(52.4940361, 13.4440809),
            consumeTapEvents: true,
            infoWindow: InfoWindow(
              title: name,
            ),
          ),
        },
        onTap: (location) => launchUrlString(googleMapsLink),
        rotateGesturesEnabled: false,
        scrollGesturesEnabled: false,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        tiltGesturesEnabled: false,
      ),
    );
  }
}
