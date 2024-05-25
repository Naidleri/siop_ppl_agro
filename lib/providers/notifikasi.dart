import 'package:siop_ppl_agro/providers/sensor.dart';
import 'package:siop_ppl_agro/services/notifikasi_services.dart';

class Notifikasi {
  final NotificationService _notificationService;
  final SensorProvider sensorProvider;

  Notifikasi(this._notificationService, this.sensorProvider) {
    sensorProvider.addListener(_checkForNotifications);
  }

  void _checkForNotifications() {
    final servo = sensorProvider.sensorData?.servo;

    if (servo == 90) {
      _notificationService.showNotification(
          'Siram Otomatis', 'Lahan Anda Telah Disiram');
    }
  }
}
