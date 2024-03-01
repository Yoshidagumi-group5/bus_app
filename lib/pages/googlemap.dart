import 'dart:async';
import 'package:bus_app/main.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final completerProvider = StateProvider((ref) => Completer());
final markers = StateProvider((ref) => <Marker>{});
final pageProvider = StateProvider((ref) => true);
final myLocationProvider = StateProvider((ref) => const LatLng(0, 0));

void _getUserLocation(ref) async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  ref.read(pageProvider.notifier).state = false;
  ref.read(myLocationProvider.notifier).state =
      LatLng(position.latitude, position.longitude);
}

class GoogleMapsNavi extends HookConsumerWidget {
  const GoogleMapsNavi({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(myLocationProvider);
    _getUserLocation(ref);
    CameraPosition setInitPosition() {
      return CameraPosition(
        target: position,
        zoom: 14,
      );
    }

    CameraPosition initPosition = setInitPosition();
    final marker = ref.watch(markers);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Map"),
      ),
      body: ref.watch(pageProvider)
          ? const CircularProgressIndicator()
          : GoogleMap(
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
              minMaxZoomPreference: MinMaxZoomPreference.unbounded,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
    );
  }
}
