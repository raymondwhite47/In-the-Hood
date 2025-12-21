class PointsModel {
  final String userId;
  int points;

  PointsModel({required this.userId, required this.points});

  Map<String, dynamic> toMap() => {'userId': userId, 'points': points};

  factory PointsModel.fromMap(Map<String, dynamic> map) {
    return PointsModel(userId: map['userId'], points: map['points']);
  }
}
