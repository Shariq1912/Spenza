import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationWidget {
  static Widget buildLocationText(Position? position) {

    return Column(
      children: [
        Text(
          'Latitude: ${position!.latitude}',
          style: TextStyle(fontSize: 16),
        ),
        Text(
          'Longitude: ${position.longitude}',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}