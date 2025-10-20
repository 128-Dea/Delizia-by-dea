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

  String get hargaFormatted {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 2,
    );
    return formatter.format(_harga);
  }

  // Method untuk menampilkan info produk
  void tampilkanInfo() {
    print("ID: $_id");
    print("Nama Kue: $_nama");
    print("Harga: ${hargaFormatted}");
    print("Kategori: $_kategori");
    print("Gambar: $_gambar");
    print("Stok: $_stok");
    print("Deskripsi: $_deskripsi");
  }

  // Convert Product ke Map (untuk disimpan di SharedPreferences)
  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'nama': _nama,
      'harga': _harga,
      'kategori': _kategori,
      'gambar': _gambar,
      'stok': _stok,
      'deskripsi': _deskripsi,
    };
  }

  // Convert Map ke Product (saat load dari SharedPreferences)
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      map['id'] ?? '',
      map['nama'] ?? '',
      (map['harga'] as num).toDouble(),
      map['kategori'] ?? '',
      map['gambar'] ?? '',
      map['stok'] ?? 0,
      map['deskripsi'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory Product.fromJson(Map<String, dynamic> json) => Product.fromMap(json);
}
