import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'amplifyconfiguration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const InTheHoodApp());
}

Future<void> _configureAmplify() async {
  if (Amplify.isConfigured) {
    return;
  }

  final api = AmplifyAPI();
  final auth = AmplifyAuthCognito();
  final storage = AmplifyStorageS3();

  try {
    await Amplify.addPlugins([api, auth, storage]);
    await Amplify.configure(amplifyconfig);
  } on AmplifyAlreadyConfiguredException {
    safePrint('Amplify was already configured.');
  } catch (error) {
    safePrint('Failed to configure Amplify: $error');
  }
}

class InTheHoodApp extends StatefulWidget {
  const InTheHoodApp({super.key});

  @override
  State<InTheHoodApp> createState() => _InTheHoodAppState();
}

class _InTheHoodAppState extends State<InTheHoodApp> {
  late final Future<void> _amplifyInit;

  @override
  void initState() {
    super.initState();
    _amplifyInit = _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _amplifyInit,
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'In the Hood',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color(0xFF0B0C10),
          ),
          home: snapshot.connectionState == ConnectionState.done
              ? const OnboardingScreen1()
              : const Scaffold(
                  backgroundColor: Color(0xFF0B0C10),
                  body: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF00FFFF),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

// === ONBOARDING SCREEN 1 (SPLASH / INTRO) ===

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [Color(0xFF00FFFF), Color(0xFF0B0C10)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Embossed Neon Logo
              Text(
                'In the Hood',
                style: GoogleFonts.orbitron(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [Color(0xFF00FFFF), Color(0xFFFF00FF)],
                    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                  shadows: const [
                    Shadow(
                      color: Color(0xFF00FFFF),
                      blurRadius: 20,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'The AI-powered local marketplace\nwhere trust meets trade.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 80),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnboardingScreen2(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.cyanAccent,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// === ONBOARDING SCREEN 2 (NEIGHBORHOOD MAP) ===

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Grayscale map (placeholder image)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Discover what's happening\nin your neighborhood.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.orbitron(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: const [
                      Shadow(color: Color(0xFF00FFFF), blurRadius: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Events, sales, and stories — all verified by AI.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00FFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 14,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Allow Location Access',
                    style: GoogleFonts.orbitron(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// === HOME PLACEHOLDER ===

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isSignedIn = false;
  bool _isSignUpComplete = false;
  bool _isLoading = false;
  String _statusMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    final userAttributes = <CognitoUserAttributeKey, String>{};
    if (email.isNotEmpty) {
      userAttributes[CognitoUserAttributeKey.email] = email;
    }
    if (phone.isNotEmpty) {
      userAttributes[CognitoUserAttributeKey.phoneNumber] = phone;
    }

    setState(() {
      _isLoading = true;
      _statusMessage = '';
    });

    try {
      final res = await Amplify.Auth.signUp(
        username: username,
        password: password,
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );
      setState(() {
        _isSignUpComplete = res.isSignUpComplete;
        _statusMessage = res.isSignUpComplete
            ? 'Sign up complete. You can sign in.'
            : 'Sign up initiated. Check your email/SMS to confirm.';
      });
    } on AuthException catch (e) {
      setState(() {
        _statusMessage = 'Sign up failed: ${e.message}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signIn() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      _isLoading = true;
      _statusMessage = '';
    });

    try {
      final res = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      setState(() {
        _isSignedIn = res.isSignedIn;
        _statusMessage =
            res.isSignedIn ? 'Signed in.' : 'Additional steps required.';
      });
    } on AuthException catch (e) {
      setState(() {
        _statusMessage = 'Sign in failed: ${e.message}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signOut() async {
    setState(() {
      _isLoading = true;
      _statusMessage = '';
    });

    try {
      await Amplify.Auth.signOut();
      setState(() {
        _isSignedIn = false;
        _statusMessage = 'Signed out.';
      });
    } on AuthException catch (e) {
      setState(() {
        _statusMessage = 'Sign out failed: ${e.message}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome to In the Hood',
                textAlign: TextAlign.center,
                style: GoogleFonts.orbitron(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Create an account or sign in to continue.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(color: Colors.white70),
              ),
              const SizedBox(height: 32),
              _buildInputField(
                label: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _buildInputField(
                label: 'Phone Number',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              _buildInputField(
                label: 'Username',
                controller: _usernameController,
              ),
              const SizedBox(height: 16),
              _buildInputField(
                label: 'Password',
                controller: _passwordController,
                isPassword: true,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _signUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00FFFF),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  _isLoading ? 'Working...' : 'Sign Up',
                  style: GoogleFonts.orbitron(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _isLoading ? null : _signIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white10,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  _isLoading ? 'Working...' : 'Sign In',
                  style: GoogleFonts.orbitron(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: _isLoading ? null : _signOut,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white70,
                  side: const BorderSide(color: Colors.white30),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  _isLoading ? 'Working...' : 'Sign Out',
                  style: GoogleFonts.orbitron(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
              _buildStatusCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF00FFFF)),
        ),
        filled: true,
        fillColor: Colors.white10,
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Status',
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _statusMessage.isEmpty
                ? 'No activity yet.'
                : _statusMessage,
            style: GoogleFonts.inter(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Text(
            _isSignedIn ? 'Signed in' : 'Signed out',
            style: GoogleFonts.inter(
              color: _isSignedIn ? Colors.greenAccent : Colors.redAccent,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _isSignUpComplete ? 'Sign up complete' : 'Sign up incomplete',
            style: GoogleFonts.inter(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
