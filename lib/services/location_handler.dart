import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

Future<Position> determinePosition(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission locationPermission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Future.delayed(Duration.zero, () async {
      bool serviceTurnedOn = await promptEnableLocation(context);

      if (!serviceTurnedOn) {
        return Future.error("Location service not Enabled");
      }
    });
  }

  locationPermission = await Geolocator.checkPermission();
  if (locationPermission == LocationPermission.denied) {
    locationPermission = await Geolocator.requestPermission();
    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      Future.delayed(Duration.zero, () {
        showPermissionDeniedDialog(context);
      });

      return Future.error("Location Service is denied");
    }
  }
  if (locationPermission == LocationPermission.deniedForever) {
    Future.delayed(Duration.zero, () {
      showPermissionDeniedForeverDialog(context);
    });
    return Future.error(
        "Location permissions are permanently denied, we cannot request permissions.");
  }

  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}

Future<bool> promptEnableLocation(BuildContext context) async {
  bool userAccepted = false;
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Location Services"),
      content: const Text(
          "Location services are disabled. Please enable them in the settings."),
      actions: [
        TextButton(
          onPressed: () async {
            await Geolocator.openLocationSettings();
            userAccepted = await Geolocator.isLocationServiceEnabled();
            Future.delayed(
                Duration.zero, () => Navigator.of(context).pop(userAccepted));
          },
          child: const Text("Enable"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text("Exit"),
        ),
      ],
    ),
  );
  return userAccepted;
}

void showPermissionDeniedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Location Permission"),
      content: const Text(
          "Location permissions are denied. Please enable them in the settings."),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("OK"),
        ),
      ],
    ),
  );
}

void showPermissionDeniedForeverDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Location Permission"),
      content: const Text(
          "Location permissions are permanently denied. Please enable them in the settings."),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("OK"),
        ),
      ],
    ),
  );
}
