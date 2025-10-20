import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/order_history.dart';
import '../model/product.dart';

class OrderHistoryService {
  static const String _key = 'order_history';
  static List<OrderHistory> _riwayatPesanan = [];

  /// Getter riwayat pesanan (untuk digunakan di UI)
  static List<OrderHistory> get riwayatPesanan => _riwayatPesanan;

  /// ✅ Muat data dari SharedPreferences saat aplikasi dimulai
  static Future<void> loadPesanan() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];

    _riwayatPesanan = data
        .map((item) {
          try {
            final jsonData = jsonDecode(item);
            return OrderHistory.fromJson(jsonData);
          } catch (e) {
            print("❌ Gagal decode item riwayat: $e");
            return null;
          }
        })
        .whereType<OrderHistory>()
        .toList();
  }

  /// ✅ Simpan semua data ke SharedPreferences
  static Future<void> _savePesanan() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = _riwayatPesanan.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }

  /// ✅ Tambahkan pesanan baru
  static Future<void> tambahPesanan(OrderHistory pesanan) async {
    _riwayatPesanan.add(pesanan);
    await _savePesanan();
  }

  /// ✅ Hapus semua pesanan
  static Future<void> hapusSemuaPesanan() async {
    _riwayatPesanan.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
