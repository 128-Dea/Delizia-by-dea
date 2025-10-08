import 'product.dart';

class KueKering extends Product {
  String _rasa;

  KueKering(
    String id,
    String nama,
    double harga,
    String kategori,
    String gambar,
    int stok,
    String deskripsi,
    this._rasa,
  ) : super(id, nama, harga, kategori, gambar, stok, deskripsi);

  // Getter Setter
  String get rasa => _rasa;
  set rasa(String value) {
    if (value.isNotEmpty) _rasa = value;
  }

  @override
  void tampilkanInfo() {
    print("Rasa: $_rasa");
    print("=================");
  }

  static List<KueKering> daftarKueKering = [
    KueKering(
      "K01",
      "Nastar",
      75000,
      "Kue Kering",
      "assets/images/nastar.jpeg",
      25,
      "Kue kering klasik berisi selai nanas manis legit dengan tekstur lembut dan lumer di mulut. Biasanya jadi bintang meja saat Lebaran.",
      "Nanas",
    ),
    KueKering(
      "K02",
      "Kastengel",
      85000,
      "Kue Kering",
      "assets/images/kastengel.jpeg",
      28,
      "Kue keju berbentuk stik kecil dengan rasa gurih asin khas keju edam yang dipanggang renyah. Harumnya bikin nagih.",
      "Keju",
    ),
    KueKering(
      "K03",
      "Kue Sagu",
      85000,
      "Kue Kering",
      "assets/images/kue sagu.jpeg",
      28,
      "Kue kering dari tepung sagu dengan campuran keju, punya tekstur yang renyah di luar. Cocok untuk pecinta rasa gurih manis.",
      "Manis dan Gurih",
    ),
    KueKering(
      "K04",
      "Kue Lidah Kucing",
      40000,
      "Kue Kering",
      "assets/images/lidah kucing.jpeg",
      28,
      "Kue tipis panjang dengan tekstur super renyah dan rasa manis ringan. Disebut “lidah kucing” karena bentuknya yang pipih menyerupai lidah.",
      "Vanila",
    ),
    KueKering(
      "K05",
      "Semprit",
      60000,
      "Kue Kering",
      "assets/images/Semprit.jpeg",
      28,
      "Kue kering berbentuk bunga dengan tekstur renyah dan rasa manis gurih. Sering diberi tambahan choco chips atau selai di tengahnya.",
      "Coklat, Strawberry, Nanas, Keju",
    ),
    KueKering(
      "K06",
      "Putri Salju",
      65000,
      "Kue Kering",
      "assets/images/putri salju.jpeg",
      30,
      "Kue kering lembut berbentuk bulan sabit yang dibalut gula halus putih seperti salju. Rasanya manis, gurih, dan lumer di mulut.",
      "Vanilla",
    ),
    KueKering(
      "K07",
      "Kue Kacang",
      60000,
      "Kue Kering",
      "assets/images/kue kacang.jpeg",
      20,
      "Kue kering berbahan dasar kacang tanah yang ditumbuk, dipanggang hingga wangi, dengan rasa gurih manis khas kacang.",
      "Kacang",
    ),
    KueKering(
      "K08",
      "Kue Chocolate Chip Cookies",
      50000,
      "Kue Kering",
      "assets/images/chip cookies.jpeg",
      20,
      "Kue kering renyah dengan potongan cokelat chip yang meleleh saat digigit, favorit segala usia.",
      "manis dan chocolate",
    ),
    KueKering(
      "K09",
      "Kue Bawang",
      35000,
      "Kue Kering",
      "assets/images/bawang.jpeg",
      20,
      "Kue gurih dan renyah berbentuk tipis, terbuat dari adonan tepung dengan taburan bawang yang harum.",
      "gurih dan renyah",
    ),
    KueKering(
      "K10",
      "Akar kelapa",
      35000,
      "Kue Kering",
      "assets/images/akar kelapa.jpeg",
      20,
      "Kue tradisional berbentuk unik menyerupai akar, rasanya gurih manis dengan tekstur garing.",
      "gurih, manis",
    ),
  ];
}
