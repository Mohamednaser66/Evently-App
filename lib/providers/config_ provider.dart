import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ConfigProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;

  bool get isLight => currentTheme == ThemeMode.light;
  String currentLang = "en";

  bool get isEng => currentLang == "en";

  changeAppTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;
    notifyListeners();
  }

  void changeAppLang(String newLang) {
    if (currentLang == newLang) return;
    currentLang = newLang;
    notifyListeners();
  }

  Location location = Location();
  String locationMessage = 'check location';

  getLocation() async {
    bool isPermissionEnabled = await checkPermission();
    if (!isPermissionEnabled) {
      locationMessage = 'check permission';
      notifyListeners();
      return;
    }
    bool isServiceEnabled = await checkServiceEnabled();
    if (!isServiceEnabled) {
      locationMessage = 'check service lock';
      notifyListeners();
      return;
    }
    LocationData myLocation = await location.getLocation();
    goToLocation(LatLng(myLocation.latitude?? 0, myLocation.longitude?? 0));
    notifyListeners();
  }

  checkPermission() async {
    PermissionStatus permissionState = await location.hasPermission();
    if (permissionState == PermissionStatus.denied) {
      permissionState = await location.requestPermission();
    }
    return permissionState == PermissionStatus.granted;
  }

  checkServiceEnabled() async {
    bool isServiceEnable = await location.serviceEnabled();
    if (!isServiceEnable) {
      isServiceEnable = await location.requestService();
    }
    return isServiceEnable;
  }

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
}
