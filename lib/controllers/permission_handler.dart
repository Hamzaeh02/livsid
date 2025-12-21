import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController {

  static const _locationKey = 'location_permission_asked';
  static const _notificationKey = 'notification_permission_asked';

  @override
  void onInit() {
    super.onInit();
    checkPermissionsOnce();
  }

  Future<void> checkPermissionsOnce() async {
    final prefs = await SharedPreferences.getInstance();

    // 📍 Location
    if (!(prefs.getBool(_locationKey) ?? false)) {
      await Permission.location.request();
      prefs.setBool(_locationKey, true);
    }

    // 🔔 Notification
    if (!(prefs.getBool(_notificationKey) ?? false)) {
      await Permission.notification.request();
      prefs.setBool(_notificationKey, true);
    }
  }
}
