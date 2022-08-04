import 'dart:typed_data';

import 'package:alpaca/alpaca.dart';
import 'package:custom_map_markers/custom_map_markers.dart' as custom;
import 'package:flutter/material.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart' as map;
import 'package:skeleton_loader/skeleton_loader.dart';

class CrunchMap extends StatelessWidget {
  const CrunchMap({Key? key, required this.googleMapsLink, required this.name})
      : super(key: key);

  final String googleMapsLink;
  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: custom.CustomMapMarkerBuilder(
        markerWidgets: [_customMarker()],
        builder: (BuildContext context, List<Uint8List>? markers) {
          if (markers == null) {
            return SkeletonLoader(
              highlightColor: const Color(0xFFF1EFEF),
              builder: Container(
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
            );
          }

          return map.PlatformMap(
            initialCameraPosition: const map.CameraPosition(
              target: map.LatLng(52.4940361, 13.4440809),
              zoom: 14.4746,
            ),
            markers: {
              map.Marker(
                markerId: map.MarkerId('0'),
                position: const map.LatLng(52.4940361, 13.4440809),
                icon: map.BitmapDescriptor.fromBytes(markers[0]),
              ),
            },
          );
        },
      ),
    );
  }

  Widget _customMarker() {
    return const Icon(
      Icons.food_bank,
      color: AlpacaColor.primary100,
      size: 50,
    );
  }
}
