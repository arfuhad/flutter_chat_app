import 'dart:developer';
import 'dart:io';
// import 'package:aicds/features/auth/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/core.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  if (message.notification != null) {
    log('FCM Service: Background Messaging: Message also contained a notification: ${message.notification}');
    log('FCM Service: Message data | title : ${message.notification?.title}');
    log('FCM Service: Message data | body : ${message.notification?.body}');
    var localNotification = LocalNotificationService();
    // var localNotification = injector<LocalNotificationService>();
    localNotification.initialized();

    await flutterLocalNotificationsPlugin.show(1, message.notification!.title,
        message.notification!.body, localNotification.notificationDetails);
  }
}

class FCMService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future initialise() async {
    var localNotification = LocalNotificationService();
    if (Platform.isIOS) {
      NotificationSettings settings = await _fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      log('FCM Service: User granted permission---->>>>>>>>>: ${settings.authorizationStatus}');

      String? apnsToken = await _fcm.getAPNSToken();
      if (apnsToken == null) {
        log("FCM Service: APNS token initialise ==> APNS token not available");
        throw FirebaseException(
          plugin: 'firebase_messaging',
          code: 'apns-token-not-set',
          message:
              'APNS token has not been set yet. Please ensure the APNS token is available by calling `getAPNSToken()`.',
        );
      } else {
        log("FCM Service: APNS token initialise ==> $apnsToken");
      }
    }

    _fcm.getToken().then((String? value) {
      log("FCM Service: token initialise ==> $value");
      if (value != null && value.isNotEmpty) {
        ///TODO: need to add riverpod to set token
        /*var authCubit = BlocProvider.of<AuthCubit>(context);
        authCubit.deviceToken = value;*/

        // var dashBoardVCubit = BlocProvider.of<DashboardCubit>(context);
        // dashBoardVCubit.deviceToken = value;

        // try {
        //   dashBoardVCubit.setDeviceTokenForClient();
        // } catch (error) {
        //   print("Error on fcmSetDeviceToken $error");
        // }
        debugPrint('@@@@ Device for client is now set');
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log('FCM Service: Got a message whilst in the foreground!');
      log('FCM Service: Message data: ${message.data}');

      if (message.notification != null) {
        log('FCM Service: Foreground messaging: Message also contained a notification: ${message.notification}');

        await flutterLocalNotificationsPlugin.show(
            1,
            message.notification!.title,
            message.notification!.body,
            localNotification.notificationDetails);
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // FirebaseMessaging.onMessageOpenedApp()

    // If someone taps on FCM notification and the app is running on background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('FCM Service: User has tapped the FCM');

      // locator<NavigationService>()
      //     .navigateTo(NotificationScreen.routeName, replace: true);
    });

    // If the app is in terminate state and user taps on the FCM notification
    _fcm.getInitialMessage().then((RemoteMessage? message) async {
      if (message != null) {
        log("FCM Service: Message : $message");
      }
    });
  }
}
