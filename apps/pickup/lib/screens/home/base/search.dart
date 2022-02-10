import 'package:flutter/material.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: PlatformMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(52.493762, 13.446425),
              zoom: 10.0,
            ),
            markers: <Marker>{
              Marker(
                markerId: MarkerId('marker_1'),
                position: const LatLng(52.493762, 13.446425),
                consumeTapEvents: true,
                infoWindow: const InfoWindow(
                  title: 'PlatformMarker',
                  snippet: "Hi I'm a Platform Marker",
                ),
                onTap: () {
                  // print("Marker tapped");
                },
              ),
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            // onTap: (location) => print('onTap: $location'),
            onCameraMove: (cameraUpdate) {
              // print('onCameraMove: $cameraUpdate');
            },
            // onMapCreated: (controller) {
            //   Future.delayed(const Duration(seconds: 2)).then(
            //     (_) {
            //       controller.animateCamera(
            //         CameraUpdate.newCameraPosition(
            //           const CameraPosition(
            //             bearing: 270.0,
            //             target: LatLng(51.5160895, -0.1294527),
            //             tilt: 30.0,
            //             zoom: 18,
            //           ),
            //         ),
            //       );
            //       controller
            //           .getVisibleRegion()
            //           .then((bounds) => print("bounds: ${bounds.toString()}"));
            //     },
            //   );
            // },
          ),
        ),
      ],
    );
  }
}
