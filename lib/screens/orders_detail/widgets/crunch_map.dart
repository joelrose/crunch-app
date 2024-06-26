import 'dart:typed_data';

import 'package:alpaca/alpaca.dart';
import 'package:custom_map_markers/custom_map_markers.dart' as custom;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
              target: map.LatLng(
                52.49403052895202,
                13.446307045002678,
              ),
              zoom: 15,
            ),
            markers: {
              map.Marker(
                markerId: map.MarkerId('0'),
                position: const map.LatLng(
                  52.49403052895202,
                  13.446307045002678,
                ),
                icon: map.BitmapDescriptor.fromBytes(markers[0]),
              ),
            },
          );
        },
      ),
    );
  }

  Widget _customMarker() {
    return SvgPicture.asset(
      'assets/icons/map-pin.svg',
      width: 35,
      height: 35,
      color: AlpacaColor.blackColor,
    );
  }
}
