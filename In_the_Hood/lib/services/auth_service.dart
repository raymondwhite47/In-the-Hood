import '../models/user_model.dart';
import 'firebase_service.dart';

class AuthService {
  AuthService(this._firebaseService);

  final FirebaseService _firebaseService;

  Future<UserModel> login(String email, String password) async {
    await _firebaseService.initialize();
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return UserModel(id: 'demo', name: 'Demo User', email: email, hoodPoints: 42, verified: true);
  }

  Future<UserModel> signup(String name, String email, String password) async {
    await _firebaseService.initialize();
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return UserModel(id: 'new-user', name: name, email: email);
  }
}
