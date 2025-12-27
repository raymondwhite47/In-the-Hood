class AwsAuthSession {
  AwsAuthSession._();

  static final AwsAuthSession instance = AwsAuthSession._();

  String? _currentUserId;

  String? get currentUserId => _currentUserId;

  void setCurrentUser(String userId) {
    _currentUserId = userId;
  }

  void clear() {
    _currentUserId = null;
  }
}
