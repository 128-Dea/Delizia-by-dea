import 'product.dart';

class KueUltah extends Product {
  String _ukuran; // kecil, sedang, besar
  String _ucapan;

  KueUltah(
    String id,
    String nama,
    double harga,
    String kategori,
    String gambar,
    int stok,
    String deskripsi,
    this._ukuran,
    this._ucapan,
  ) : super(id, nama, harga, kategori, gambar, stok, deskripsi);

  // Getter Setter
  String get ukuran => _ukuran;
  set ukuran(String value) {
    if (value.isNotEmpty) _ukuran = value;
  }

  String get ucapan => _ucapan;
  set ucapan(String value) {
    if (value.isNotEmpty) _ucapan = value;
  }

  @override
  void tampilkanInfo() {
    super.tampilkanInfo();
    print("Ukuran: $_ukuran");
    print("Ucapan: $_ucapan");
    print("=================");
  }

  static List<KueUltah> daftarKueUltah = [
    KueUltah(
      "U01",
      "Black Forest",
      150000,
      "Kue Ultah",
      "assets/images/black forest.jpeg",
      10,
      "Kue cokelat klasik berlapis krim segar, dilengkapi dengan taburan cokelat serut dan ceri di atasnya. Rasa manis legit berpadu dengan sedikit asam segar dari buah ceri.",
      "Sedang",
      "Selamat Ulang Tahun!",
    ),
    KueUltah(
      "U02",
      "Red Velvet",
      175000,
      "Kue Ultah",
      "assets/images/Red Velvet Cake.jpeg",
      8,
      "Kue berwarna merah khas dengan tekstur lembut dan rasa manis, yang dipadukan dengan cream cheese frosting yang gurih lembut. Elegan dan mewah di setiap potongannya.",
      "Besar",
      "Happy Birthday!",
    ),
    KueUltah(
      "U03",
      "Rainbow Cake",
      150000,
      "Kue Ultah",
      "assets/images/rainbow cake.jpeg",
      8,
      "Kue berlapis dengan warna-warni cerah seperti pelangi, bertekstur lembut, manis, dan biasanya dilapisi dengan krim putih yang lembut. Menjadi favorit di pesta ulang tahun.",
      "Besar",
      "Happy Birthday!",
    ),
    KueUltah(
      "U04",
      "Sponge Cake",
      130000,
      "Kue Ultah",
      "assets/images/sponge cake.jpeg",
      8,
      "Kue dasar dengan tekstur ringan, lembut, dan empuk seperti spons. Bisa dinikmati langsung atau dijadikan dasar berbagai kreasi kue tart.",
      "Besar",
      "Happy Birthday!",
    ),
    KueUltah(
      "U05",
      "Cheesecake",
      160000,
      "Kue Ultah",
      "assets/images/cheescake.jpeg",
      12,
      "Kue lembut berbahan utama keju krim dengan rasa manis gurih yang khas. Teksturnya creamy, sering disajikan dengan topping buah atau saus manis.",
      "Kecil",
      "Wish You All the Best!",
    ),
    KueUltah(
      "U06",
      "Brownis",
      80000,
      "Kue Ultah",
      "assets/images/brownis.jpeg",
      12,
      "Kue cokelat yang lembut, padat, dan fudgy dengan cita rasa manis legit. Cocok dinikmati bersama teh atau kopi.",
      "sedeng",
      "Wish You All the Best!",
    ),
    KueUltah(
      "U07",
      "Cupcake",
      10000,
      "Kue Ultah",
      "assets/images/cup cake.jpeg",
      1500,
      "Kue mungil dalam cup kertas, teksturnya lembut dengan topping krim manis dan taburan dekorasi cantik.",
      "kecil",
      "Wish You All the Best!",
    ),
    KueUltah(
      "U08",
      "Chocolate Cloud Cake",
      70000,
      "Kue Ultah",
      "assets/images/cloud coklat.jpeg",
      12,
      "Kue cokelat lembut selembut awan, dengan rasa manis pekat cokelat yang lumer di mulut.",
      "sedeng",
      "Happy Anniversary!",
    ),
  ];
}
