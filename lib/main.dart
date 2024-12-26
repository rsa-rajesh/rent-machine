import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rent_mechine/routes/app_pages.dart';
import 'package:rent_mechine/screen/auth/login/login_binding.dart';
import 'package:rent_mechine/screen/auth/login/login_view.dart';
import 'package:rent_mechine/screen/welcome/welcome_binding.dart';
import 'package:rent_mechine/screen/welcome/welcome_view.dart';
import 'core/services/PushNotificationService.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
}

void main() async {
  await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = GetStorage();
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {

    super.initState();

    //firebase integration
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.topic("rent_machine");
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      storage.write("fcm_token", value);
      if (kDebugMode) {
        print('device fcm token');
        print(value);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rent Mechanic',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: (storage.read("login") != null && storage.read("login") == true)
          ? const WelcomePage()
          : const LoginPage(),
      initialBinding:
          (storage.read("login") != null && storage.read("login") == true)
              ? WelcomeBinding()
              : LoginBinding(),
      getPages: AppPages.pages,
    );
  }
}
