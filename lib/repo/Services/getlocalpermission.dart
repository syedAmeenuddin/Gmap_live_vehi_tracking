import 'package:location/location.dart';

class getlocalpermission {
  Location location = Location();
  getservice() async {
    bool serviceenable = await location.serviceEnabled();
    if (serviceenable == false) {
      await location.requestService();
    }
    return serviceenable;
  }

  getlocationservice() async {
    PermissionStatus permissionstatus = await location.hasPermission();
    if (permissionstatus == PermissionStatus.granted) {
      return true;
    } else {
      await location.requestPermission();
      if (permissionstatus == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  Future getpermissions() async {
    if (await getlocalpermission().getservice() == false) {
      await location.requestService();
    }
    if (await getlocalpermission().getlocationservice() == false) {
      await location.requestPermission();
    }
    
    return true;
  }
}
