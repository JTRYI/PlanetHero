
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotifHelper {
  NotifHelper._();

  static Future<void> initNotif() async {
    //for debugging
    await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    // set up oneSignal App id
    await OneSignal.shared.setAppId("143e30e2-35c0-4918-bbfa-7f312bacca0e");

    //wait for user to allow push notification to their phone
    await OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((pushNotificationPermission) {
      // log("Permission Accepted $pushNotificationPermission");
    });
  }
}
