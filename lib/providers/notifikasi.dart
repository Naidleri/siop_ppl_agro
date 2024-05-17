import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:siop_ppl_agro/providers/sensor.dart';

class Notifikasi {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final SensorProvider sensorProvider;

  Notifikasi(this.flutterLocalNotificationsPlugin, this.sensorProvider);

  void checkForNotifications() {
    final servo = sensorProvider.sensorData?.servo;

    if (servo == 90) {
      showNotification('Siram Otomatis', 'Lahan Anda Telah Disiram');
    }
  }

  Future<void> showNotification(String title, String message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'Your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker text',
      playSound: true,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      message,
      platformChannelSpecifics,
    );
  }
}
