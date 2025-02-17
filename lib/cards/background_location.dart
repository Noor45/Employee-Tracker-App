import 'package:location/location.dart';
import 'package:workmanager/workmanager.dart';
import 'package:motion_toast/motion_toast.dart';


const String locationTaskKey = "locationTask";

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == locationTaskKey) {
      Location location = Location();

      bool _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return Future.value(false);
        }
      }

      PermissionStatus _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return Future.value(false);
        }
      }

      LocationData _locationData = await location.getLocation();

      // Handle your location logic here. For example, you can send the location to your server.

      return Future.value(true);
    }
    return Future.value(false);
  });
}
