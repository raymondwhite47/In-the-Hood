import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../services/firebase_service.dart';
import '../../widgets/custom_button.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;

  Future<void> _login() async {
    setState(() => _loading = true);
    final AuthService authService = AuthService(FirebaseService());
    await authService.login(_emailController.text, _passwordController.text);
    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome back')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('In the Hood', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text('Discover what neighbors are selling, swapping, or giving away.'),
            const SizedBox(height: 24),
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            CustomButton(
              label: _loading ? 'Signing in...' : 'Login',
              onPressed: _loading ? () {} : _login,
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/signup');
              },
              child: const Text('Create an account'),
            ),
          ],
        ),
      ),
    );
  }
}
