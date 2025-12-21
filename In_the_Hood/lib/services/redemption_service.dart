class RedemptionService {
  // This is a placeholder for the user's points balance.
  // In a real app, this would be fetched from a database.
  int _points = 500;

  int get points => _points;

  Future<bool> redeemPoints(int pointsToRedeem) async {
    if (_points >= pointsToRedeem) {
      _points -= pointsToRedeem;
      return true;
    } else {
      return false;
    }
  }
}
