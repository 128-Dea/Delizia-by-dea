import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Ubah ini sesuai target:
  // - Web/Chrome: http://localhost:8080
  // - Android emulator: http://10.0.2.2:8080
  // - Device fisik: http://IP-KOMPUTER:8080
  static const String baseUrl = 'http://localhost:8080';

  static Future<bool> login(String username, String password) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
