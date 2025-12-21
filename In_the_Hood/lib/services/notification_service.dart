import '../models/notification_model.dart';

class NotificationService {
  NotificationService();

  Future<bool> requestPermission() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return true;
  }

  NotificationModel? parsePayload(Map<String, dynamic> payload) {
    final notification = payload['notification'];
    if (notification is Map<String, dynamic>) {
      return NotificationModel.fromJson(notification);
    }
    return null;
  }

  Future<void> sendNotification({
    required String title,
    required String body,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
  }
}
