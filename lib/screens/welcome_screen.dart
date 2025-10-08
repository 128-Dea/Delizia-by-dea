import 'package:flutter/material.dart';
import 'dart:ui';
import 'dashboard_screen.dart';
import 'theme_notifier.dart';

class WelcomeScreen extends StatelessWidget {
  final String username;
  final ThemeNotifier themeNotifier;

  const WelcomeScreen({
    super.key,
    required this.username,
    required this.themeNotifier,
  });

  @override
  Widget build(BuildContext context) {
    String displayName = username.contains("@")
        ? username.split("@")[0]
        : username;

    if (displayName.isNotEmpty) {
      displayName = displayName[0].toUpperCase() + displayName.substring(1);
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/kue_bg.jpeg", fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.25)),

          // Konten tengah
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    color: Colors.white.withOpacity(0.3),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/images/logosplash.png",
                          height: 250,
                          color: const Color.fromARGB(255, 127, 87, 14),
                        ),
                        const SizedBox(height: 40),

                        Text(
                          "Welcome $displayName !",
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 85, 76, 15),
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 10),

                        const Text(
                          "Sweetness is not just in the taste, but in the moments we share together.\n"
                          "Manis itu bukan hanya pada rasa, tapi juga pada momen yang kita bagi bersama.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        const SizedBox(height: 30),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              104,
                              89,
                              5,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashboardScreen(
                                  username: displayName,
                                  themeNotifier: themeNotifier,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Get Started",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
