import '../models/user_model.dart';
import 'aws_auth_session.dart';

class AuthService {
  AuthService(this._authSession);

  final AwsAuthSession _authSession;

  Future<UserModel> login(String email, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final user = UserModel(id: 'demo', name: 'Demo User', email: email, hoodPoints: 42, verified: true);
    _authSession.setCurrentUser(user.id);
    return user;
  }

  Future<UserModel> signup(String name, String email, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final user = UserModel(id: 'new-user', name: name, email: email);
    _authSession.setCurrentUser(user.id);
    return user;
  }
}
