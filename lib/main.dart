import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:siop_ppl_agro/firebase_options.dart';
import 'package:siop_ppl_agro/providers/history.dart';
import 'package:siop_ppl_agro/providers/lahan.dart';
import 'package:siop_ppl_agro/providers/sensor.dart';
import 'package:siop_ppl_agro/services/notifikasi_services.dart';
import 'package:siop_ppl_agro/views/pages/lahan/lahan.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializingSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializingSetting =
      InitializationSettings(android: initializingSettingsAndroid);
  flutterLocalNotificationsPlugin.initialize(initializingSetting);

  await Permission.notification.request();

  runApp(MyApp(
    notificationsPlugin: flutterLocalNotificationsPlugin,
  ));
}

class MyApp extends StatelessWidget {
  final FlutterLocalNotificationsPlugin notificationsPlugin;

  const MyApp({Key? key, required this.notificationsPlugin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationService = NotificationService(notificationsPlugin);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LahanProvider()),
        ChangeNotifierProvider(create: (context) => HistoryProvider()),
        ChangeNotifierProvider(
            create: (context) => SensorProvider(0, notificationService)),
      ],
      child: MaterialApp(
          title: 'PPl-Agro SIOP',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: HomeLahan(
            notificationService: notificationService,
          )),
    );
  }
}
  