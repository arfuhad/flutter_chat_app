import 'package:flutter_chat_app/core/core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class LocalNotificationService {
  //local notification

  final Function(NotificationResponse)? onDidReceiveNotificationResponse;

  final Function(NotificationResponse)?
      onDidReceiveBackgroundNotificationResponse;

  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late InitializationSettings initializationSettings;

  late AndroidNotificationDetails _androidDetails;
  late DarwinNotificationDetails _iosDetails;
  late NotificationDetails notificationDetails;

  LocalNotificationService(
      {this.onDidReceiveNotificationResponse,
      this.onDidReceiveBackgroundNotificationResponse}) {
    // flutterLocalNotificationsPlugin =
    //     injector<FlutterLocalNotificationsPlugin>();

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const DarwinInitializationSettings iOSSettings =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestCriticalPermission: true,
            requestSoundPermission: true);

    initializationSettings = const InitializationSettings(
        android: androidSettings, iOS: iOSSettings);

    // flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onDidReceiveBackgroundNotificationResponse:
    //         onDidReceiveBackgroundNotificationResponse,
    //     onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    _androidDetails = const AndroidNotificationDetails(
        NotificationKeys.channelId, NotificationKeys.channelName,
        priority: Priority.max, importance: Importance.max);

    _iosDetails = const DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);

    notificationDetails =
        NotificationDetails(android: _androidDetails, iOS: _iosDetails);
    initialized(
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveBackgroundNotificationResponse,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  Future<void> initialized(
      {Function(NotificationResponse)? onDidReceiveNotificationResponse,
      Function(NotificationResponse)?
          onDidReceiveBackgroundNotificationResponse}) async {
    bool? initialized = await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveBackgroundNotificationResponse,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    print("Local Notification: initialized: $initialized");

    if (!initialized!) {
      flutterLocalNotificationsPlugin.pendingNotificationRequests();
    }
  }
}
