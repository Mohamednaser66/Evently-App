import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class SelectedLocationProvider extends ChangeNotifier{
  late GoogleMapController controller;
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(30.614612468008364, 32.25006734210147),
    zoom: 17,
  );
  Set<Marker> markers = {
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(30.614612468008364, 32.25006734210147),
      infoWindow: InfoWindow(title: 'ismailia'),
    ),
  };

  goToLocation(LatLng newLocation) {
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(newLocation.latitude, newLocation.longitude),
          zoom: 17,
        ),
      ),
    );
    markers ={
      Marker(
          markerId: MarkerId('m'),
          position: LatLng(newLocation.latitude, newLocation.longitude)
      )
    };
    notifyListeners();
  }
  LatLng? selectedLocation ;

  changeSelectedLocation(LatLng location ){
    selectedLocation =location;
    goToLocation(location);
    notifyListeners();

  }

}