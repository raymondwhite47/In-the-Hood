class NotificationModel {
  NotificationModel({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
    );
  }
}
