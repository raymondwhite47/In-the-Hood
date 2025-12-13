class TrustService {
  TrustService();

  Future<double> calculateTrustScore({required int verifications, required int positiveReviews}) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final baseScore = 50.0 + verifications * 10;
    final reviewBonus = positiveReviews * 2;
    return (baseScore + reviewBonus).clamp(0, 100).toDouble();
  }

  Future<bool> verifyUser({required String fullName, required String documentId}) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return fullName.isNotEmpty && documentId.isNotEmpty;
  }
}
