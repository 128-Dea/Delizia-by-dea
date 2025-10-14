import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../services/preferences_service.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback? onLoginSuccess;

  const LoginScreen({super.key, this.onLoginSuccess});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;
  bool _obscureText = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  // GoogleSignIn diinisialisasi dengan clientId
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        "976980168725-r98pgf7ee6ea8fiqtkj5mgdbhec3g6sd.apps.googleusercontent.com",
  );

  // Fungsi login manual
  void _login(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email dan password tidak boleh kosong!")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoadingScreen()),
    );

    await Future.delayed(const Duration(seconds: 2));

    final username = usernameController.text.isNotEmpty
        ? usernameController.text
        : emailController.text.split("@")[0];

    await PreferencesService.setLoggedIn(true);
    widget.onLoginSuccess?.call();

    Navigator.pushReplacementNamed(context, "/welcome", arguments: username);
  }

  // Login menggunakan Google
  Future<void> _loginWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LoadingScreen()),
        );

        await Future.delayed(const Duration(seconds: 2));

        await PreferencesService.setLoggedIn(true);
        widget.onLoginSuccess?.call();

        Navigator.pushReplacementNamed(
          context,
          "/welcome",
          arguments: account.displayName ?? "User",
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login Google dibatalkan.")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login Google gagal: $error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 700;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 215, 194),
      body: Center(
        child: Container(
          height: isMobile ? null : 500,
          width: isMobile ? double.infinity : 900,
          margin: isMobile ? const EdgeInsets.all(16) : EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: isMobile
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildLeftPanel(),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: _buildLoginForm(context),
                      ),
                    ],
                  ),
                )
              : Row(
                  children: [
                    Expanded(flex: 1, child: _buildLeftPanel()),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: _buildLoginForm(context),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  // Bagian kiri (logo + teks)
  Widget _buildLeftPanel() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(245, 222, 184, 140),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 233, 215, 194),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/logosplash.png",
                height: 180,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 15),
              const Text(
                "Delizia",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "A taste that reminds you of home,\ncomfort, and the joy of simple things.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //  Form login
  Widget _buildLoginForm(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome to Delizia by Dea",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 20),
          if (!isLogin)
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                hintText: "Username",
                border: UnderlineInputBorder(),
              ),
            ),
          if (!isLogin) const SizedBox(height: 16),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: "Email",
              border: UnderlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: passwordController,
            obscureText: _obscureText,
            decoration: InputDecoration(
              hintText: "Password",
              border: const UnderlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Reset Password"),
                    content: const Text(
                      "Fitur reset password belum tersedia. Silakan hubungi admin.",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                "Forgot password?",
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade800,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () => _login(context),
              child: Text(
                isLogin ? "Sign in" : "Create Account",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(child: Divider(thickness: 1)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text("or"),
              ),
              Expanded(child: Divider(thickness: 1)),
            ],
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => _loginWithGoogle(context),
            icon: Image.network(
              "https://cdn-icons-png.flaticon.com/512/281/281764.png",
              height: 20,
            ),
            label: const Text("Sign in with Google"),
          ),
          const SizedBox(height: 20),
          Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text(
                isLogin
                    ? "New here? Create Account"
                    : "Already have an account? Sign in",
                style: const TextStyle(
                  color: Colors.teal,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: LoadingAnimationWidget.fourRotatingDots(
          color: Colors.teal,
          size: 100,
        ),
      ),
    );
  }
}
