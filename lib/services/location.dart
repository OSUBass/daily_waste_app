import 'package:location/location.dart';

class LocationServices{

  Future<bool> checkServiceEnabled (location, _serviceEnabled) async {
   _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {return false;}
    }
    return true;
  }

  Future<Enum> checkPermissionGranted(location, _permissionGranted)async {
    _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            return PermissionStatus.denied;
          }
        }
        return PermissionStatus.granted;
  }
}