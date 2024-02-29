import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: must_be_immutable
class GoogleMapsNavi extends HookConsumerWidget {
  GoogleMapsNavi({super.key});
  Position? currentPosition;
  late GoogleMapController controller;
  late StreamSubscription<Position> positionStream;

  //初期値
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(43.0686606, 141.3485613),
    zoom: 14,
  );

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high, //正確性:highはAndroid(0-100m),iOS(10m)
    distanceFilter: 100,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future(() async {
        LocationPermission permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          await Geolocator.requestPermission();
        }
      });
      positionStream =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((Position? position) {
        currentPosition = position;
        debugPrint(position == null
            ? "Unknown"
            : "${position.latitude.toString()}, ${position.longitude.toString()}");
        debugPrint("asdfklajkdf");
      });
      return null;
    });
    return GoogleMap(
      initialCameraPosition: _kGooglePlex,
      mapType: MapType.normal,
      myLocationButtonEnabled: true,
      onMapCreated: (GoogleMapController controllers) {
        controller = controllers;
      },
    );
  }
}
