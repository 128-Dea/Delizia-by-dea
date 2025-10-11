import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'services/preferences_service.dart';

import 'screens/splash_screen.dart';
import 'screens/LoginScreen.dart';
import 'screens/welcome_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Ambil preferensi sebelum runApp
  final isLoggedIn = await PreferencesService.getLoggedIn();
  final themeNotifier = ThemeNotifier(await PreferencesService.getDarkMode());

  runApp(MyApp(themeNotifier: themeNotifier, isLoggedIn: isLoggedIn));
}

class MyApp extends StatefulWidget {
  final ThemeNotifier themeNotifier;
  final bool isLoggedIn;

  const MyApp({
    super.key,
    required this.themeNotifier,
    required this.isLoggedIn,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _loggedIn;

  @override
  void initState() {
    super.initState();
    _loggedIn = widget.isLoggedIn;
  }

  void _updateLoginStatus(bool value) async {
    setState(() {
      _loggedIn = value;
    });
    await PreferencesService.setLoggedIn(value);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.themeNotifier,
      builder: (context, isDarkMode, _) {
        return MaterialApp(
          title: 'Delizia by Dea',
          debugShowCheckedModeBanner: false,
          theme: isDarkMode
              ? ThemeData.dark(useMaterial3: true)
              : ThemeData(
                  primarySwatch: Colors.teal,
                  scaffoldBackgroundColor: const Color.fromARGB(
                    255,
                    247,
                    245,
                    242,
                  ),
                ),
          home: const SplashScreen(),

          // Semua route dikelola di sini
          routes: {
            "/login": (context) =>
                LoginScreen(onLoginSuccess: () => _updateLoginStatus(true)),

            "/welcome": (context) {
              final args = ModalRoute.of(context)!.settings.arguments;
              final username = args is String ? args : "User";
              return WelcomeScreen(
                username: username,
                themeNotifier: widget.themeNotifier,
              );
            },

            "/dashboard": (context) {
              final args = ModalRoute.of(context)!.settings.arguments;
              final username = args is String ? args : "User";
              return DashboardScreen(
                username: username,
                themeNotifier: widget.themeNotifier,
              );
            },
          },
        );
      },
    );
  }
}
