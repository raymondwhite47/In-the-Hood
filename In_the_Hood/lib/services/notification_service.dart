class NotificationService {
  NotificationService();

  Future<bool> requestPermission() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return true;
  }

  Future<void> sendNotification({
    required String title,
    required String body,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
  }
}
