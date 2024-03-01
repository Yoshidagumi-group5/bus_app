import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final completerProvider = StateProvider((ref) => Completer());
final markers = StateProvider((ref) => <Marker>{});

class GoogleMapsNavi extends HookConsumerWidget {
  const GoogleMapsNavi({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const CameraPosition initPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.5,
    );
    final marker = ref.watch(markers);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Map"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initPosition,
        markers: marker,
        onMapCreated: (GoogleMapController controller) async {
          final complete = ref.watch(completerProvider);
          complete.complete(controller);
          marker.add(const Marker(
            markerId: MarkerId('marker_1'),
            position: LatLng(37.42796133580664, -122.085749655962),
          ));
        },
        minMaxZoomPreference: const MinMaxZoomPreference(16, 18),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
