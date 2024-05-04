import 'package:flutter_chat_app/core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final injector = GetIt.instance;

Future<void> initialization() async {
  // injector.registerLazySingletonAsync<SharedPreferences>(
  //     () async => await SharedPreferences.getInstance());

  injector.registerLazySingleton<NetworkInfoService>(() =>
      NetworkInfoServiceImpl(
          internetConnectionChecker: InternetConnectionChecker()));

  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // injector.registerLazySingleton<FlutterLocalNotificationsPlugin>(
  //     () => flutterLocalNotificationsPlugin);

  injector.registerLazySingleton(() => LocalNotificationService());

  injector.registerLazySingleton(() => FCMService().initialise());
  injector
      .registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
  injector.registerLazySingleton<FirebaseDbService>(() => FirebaseDbService());
}
