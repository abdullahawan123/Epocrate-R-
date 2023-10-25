import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rushd/view/screens/splash_screen.dart';
import 'package:rushd/widgets/custom_error.dart';
import 'package:sizer/sizer.dart';

import 'controllers/controller_payments.dart';
import 'firebase_options.dart';
import 'helpers/constants.dart';
import 'helpers/style.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Future.delayed(Duration(seconds: 2));
  colorConfig();
  Stripe.publishableKey = PaymentsController.stripePublishableKey;

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FlutterDownloader.initialize(debug: true);
  TestClass.registerCallback();
  runApp(const MyApp());
}
  static void registerCallback() {
    FlutterDownloader.registerCallback((id, status, progress) {
      DownloadTaskStatus taskStatus = DownloadTaskStatus.complete;
      callback(id, taskStatus, progress);
    });
  }
}

void colorConfig() {
  appPrimaryColor = MaterialColor(
    0xFF222448,
    const <int, Color>{
      50: const Color(0xFF222448),
      100: const Color(0xFF222448),
      200: const Color(0xFF222448),
      300: const Color(0xFF222448),
      400: const Color(0xFF222448),
      500: const Color(0xFF222448),
      600: const Color(0xFF222448),
      700: const Color(0xFF222448),
      800: const Color(0xFF222448),
      900: const Color(0xFF222448),
    },
  );
  appBoxShadow = [BoxShadow(blurRadius: 18, color: Color(0x414D5678))];
  buttonColor = const Color(0xFF222448);
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    startNotificationService();
    super.initState();
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {}
  }

  void setupNotificationChannel() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const settingsAndroid = AndroidInitializationSettings('@mipmap/launcher_icon');
    final settingsIOS =
    DarwinInitializationSettings(onDidReceiveLocalNotification: (id, title, body, payload) => null /*onSelectNotification(payload)*/);
    await flutterLocalNotificationsPlugin.initialize(InitializationSettings(android: settingsAndroid, iOS: settingsIOS));

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? iOS = message.notification?.apple;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    icon: android.smallIcon,
                    enableVibration: true,
                    // importance: Importance.max,
                    priority: Priority.max,
                    // ongoing: false,
                    // autoCancel: true,
                    // visibility: NotificationVisibility.public,
                    enableLights: true
                  // other properties...
                ),
                iOS: DarwinNotificationDetails(
                  sound: iOS?.sound?.name,
                  presentAlert: true,
                  presentBadge: true,
                  presentSound: true,
                )));

        // showOngoingNotification(flutterLocalNotificationsPlugin, title: notification.title ?? "", body: notification.body ?? "");
      }
    });
  }

  void initNotificationChannel() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/launcher_icon');
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();
    const DarwinInitializationSettings initializationSettingsMacOS = DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS, macOS: initializationSettingsMacOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return GetMaterialApp(
          home:  SplashScreen(),
          locale: Locale('en', 'US'),
          debugShowCheckedModeBanner: false,
          title: "Rushd User",
          transitionDuration: Duration(milliseconds: 600),
          defaultTransition: Transition.fadeIn,
          theme: ThemeData(
            fontFamily: 'SEGOEUI',
            primarySwatch: appPrimaryColor,
            checkboxTheme: CheckboxThemeData(
              checkColor: MaterialStateProperty.all(Colors.white),
              fillColor: MaterialStateProperty.all(appPrimaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              side: BorderSide(color: Color(0xff585858), width: 1),
            ),
            appBarTheme: AppBarTheme(
              color: appPrimaryColor,
              elevation: 0,
              titleTextStyle: normal_h1Style_bold_web.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: "SEGOEUI"),
              centerTitle: false,
              systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
              iconTheme: IconThemeData(color: Colors.white),
            ),
            dividerColor: Colors.grey,
            scaffoldBackgroundColor: Color(0xFFFAFBFF),
            backgroundColor: Color(0xFFFAFBFF),
          ),
          builder: (context, widget) {
            ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
              return CustomError(errorDetails: errorDetails);
            };
            return ScrollConfiguration(behavior: NoColorScrollBehavior(), child: widget!);
            // return widget!;
            // return ScrollConfiguration(behavior: ScrollBehaviorModified(), child: widget!);
          },
        );
      },
    );
  }

  void startNotificationService() async {
    var status = await Permission.notification.request();
    if (status.isGranted){
      setupInteractedMessage();
      setupNotificationChannel();
      initNotificationChannel();
    }
  }
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.', // description
  importance: Importance.max,
);

