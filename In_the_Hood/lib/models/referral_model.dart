class ReferralModel {
  final String referrerId;
  final String referredId;
  final DateTime createdAt;
  ReferralModel({required this.referrerId, required this.referredId, required this.createdAt});

  Map<String, dynamic> toMap() => {
    'referrerId': referrerId,
    'referredId': referredId,
    'createdAt': createdAt.toIso8601String(),
  };
}
