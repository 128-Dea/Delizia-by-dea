import 'product.dart';

class KueBasah extends Product {
  String _dayaTahan;

  KueBasah(
    String id,
    String nama,
    double harga,
    String kategori,
    String gambar,
    int stok,
    String deskripsi,
    this._dayaTahan,
  ) : super(id, nama, harga, kategori, gambar, stok, deskripsi);

  // Getter Setter
  String get dayaTahan => _dayaTahan;
  set dayaTahan(String value) {
    if (value.isNotEmpty) _dayaTahan = value;
  }

  @override
  void tampilkanInfo() {
    super.tampilkanInfo();
    print("Daya Tahan: $_dayaTahan");
    print("=================");
  }

  static List<KueBasah> daftarKueBasah = [
    KueBasah(
      "B01",
      "Kue Lapis",
      3000,
      "Kue Basah",
      "assets/images/kue lapis.jpeg",
      500,
      "Kue berlapis warna-warni yang terbuat dari campuran tepung beras, santan, dan gula. Teksturnya kenyal, lembut, dan biasanya disajikan dengan warna cerah berlapis-lapis yang menarik. Cocok sebagai camilan manis di sore hari.",
      "2 hari",
    ),
    KueBasah(
      "B02",
      "Onde-Onde",
      1000,
      "Kue Basah",
      "assets/images/onde-onde.jpeg",
      500,
      "Kue berbentuk bulat dengan lapisan luar dari tepung ketan yang ditaburi wijen, berisi kacang hijau manis. Gurih di luar, lembut dan manis di dalam, menjadi salah satu jajanan pasar paling populer.",
      "2 hari",
    ),
    KueBasah(
      "B03",
      "Dadar Gulung",
      2000,
      "Kue Basah",
      "assets/images/dadar gulung.jpeg",
      1000,
      "Pancake tipis berwarna hijau (dari daun pandan) yang digulung dengan isian kelapa parut dan gula merah. Rasanya manis, gurih, dan harum pandan yang khas.",
      "1 hari",
    ),
    KueBasah(
      "B04",
      "Putu Ayu",
      3000,
      "Kue Basah",
      "assets/images/putu ayu.jpeg",
      1000,
      "Kue kukus berbentuk cantik seperti bunga, terbuat dari tepung terigu, santan, dan gula, dengan taburan kelapa parut di bagian atas. Teksturnya lembut, wangi pandan, dan manis legit.",
      "2 hari",
    ),
    KueBasah(
      "B05",
      "Lemper",
      3000,
      "Kue Basah",
      "assets/images/lemper.jpeg",
      450,
      "Ketan yang diisi dengan suwiran ayam berbumbu atau abon, kemudian dibungkus daun pisang. Rasanya gurih, sedikit lengket, dan mengenyangkan. Biasanya jadi camilan favorit di acara keluarga.",
      "2 hari",
    ),
    KueBasah(
      "B06",
      "Nagasari Pisang",
      3000,
      "Kue Basah",
      "assets/images/nagasari pisang.jpeg",
      300,
      "Kue basah tradisional dari tepung beras berisi potongan pisang, dibungkus daun pisang, lembut dan manis alami.",
      "1 hari",
    ),
    KueBasah(
      "B07",
      "Kue Pukis",
      5000,
      "Kue Basah",
      "assets/images/pukis.jpeg",
      500,
      "Kue empuk dengan rasa manis lembut, yang diberi topping cokelat, keju, atau meses.",
      "2 hari",
    ),
    KueBasah(
      "B08",
      "Kue Putu",
      2500,
      "Kue Basah",
      "assets/images/kue putu.jpeg",
      1000,
      "Kue tradisional dari tepung beras berisi gula merah cair, dikukus dalam bambu, disajikan dengan taburan kelapa parut.",
      "1 hari",
    ),
    KueBasah(
      "B09",
      "Kue Lupis Ketan Pandan",
      3000,
      "Kue Basah",
      "assets/images/LUPIS KETAN PANDAN.jpeg",
      300,
      "Ketan berbalut daun pisang berbentuk segitiga, diberi taburan kelapa parut dan disiram gula merah cair yang legit.",
      "1 hari",
    ),
    KueBasah(
      "B10",
      "Kue Pie",
      3500,
      "Kue Basah",
      "assets/images/kue pie.jpeg",
      350,
      "Kue dengan kulit renyah dan isi bervariasi, mulai dari buah segar, custard, hingga cokelat, manis ataupun gurih.",
      "2 hari",
    ),
    KueBasah(
      "B11",
      "Apem",
      3000,
      "Kue Basah",
      "assets/images/Apem.jpeg",
      500,
      "Kue tradisional berbahan dasar tepung beras dan santan, berbentuk bulat dengan tekstur empuk dan sedikit kenyal. Rasanya manis ringan, sering disajikan pada acara adat atau syukuran.",
      "2 hari",
    ),
    KueBasah(
      "B12",
      "Klepon",
      2500,
      "Kue Basah",
      "assets/images/klepon.jpeg",
      2000,
      "Bola ketan berwarna hijau dengan isian gula merah cair di dalamnya, lalu dilapisi kelapa parut. Saat digigit, gula merah meleleh di mulut, berpadu dengan gurihnya kelapa.",
      "1 hari",
    ),
  ];
}
