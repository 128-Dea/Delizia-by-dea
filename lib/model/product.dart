import 'package:intl/intl.dart';

class Product {
  String _id;
  String _nama;
  double _harga;
  String _kategori;
  String _gambar;
  int _stok;
  String _deskripsi;

  // Constructor
  Product(
    this._id,
    this._nama,
    this._harga,
    this._kategori,
    this._gambar,
    this._stok,
    this._deskripsi,
  );

  // Getter
  String get id => _id;
  String get nama => _nama;
  double get harga => _harga;
  String get kategori => _kategori;
  String get gambar => _gambar;
  int get stok => _stok;
  String get deskripsi => _deskripsi;

  // Setter
  set id(String value) {
    if (value.isNotEmpty) _id = value;
  }

  set nama(String value) {
    if (value.isNotEmpty) _nama = value;
  }

  set harga(double value) {
    if (value > 0) _harga = value;
  }

  set kategori(String value) {
    if (value.isNotEmpty) _kategori = value;
  }

  set gambar(String value) {
    if (value.isNotEmpty) _gambar = value;
  }

  set stok(int value) {
    if (value >= 0) _stok = value;
  }

  set deskripsi(String value) {
    if (value.isNotEmpty) _deskripsi = value;
  }

  // Format tampilan harga
  String get hargaFormatted {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 2,
    );
    return formatter.format(_harga);
  }

  // Method tambahan untuk menampilkan info produk
  void tampilkanInfo() {
    print("ID: $_id");
    print("Nama Kue: $_nama");
    print("Harga: ${hargaFormatted}");
    print("Kategori: $_kategori");
    print("Gambar: $_gambar");
    print("Stok: $_stok");
    print("Deskripsi: $_deskripsi");
  }
}
