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
      "Nastar selalu jadi kue favorit di setiap momen perayaan, terutama saat Lebaran. Terbuat dari adonan tepung terigu, mentega, dan kuning telur yang dipanggang hingga berwarna keemasan, lalu diisi dengan selai nanas manis legit yang dibuat dari buah nanas segar. Teksturnya lembut, sedikit rapuh, dan langsung lumer di mulut saat digigit. \nRasa manis asam dari selai nanas berpadu sempurna dengan adonan kue yang gurih dan buttery, menciptakan sensasi khas yang sulit ditolak. Bentuknya mungil dan berkilau karena olesan kuning telur di permukaannya, menjadikannya tampil cantik di toples saji.\nKue ini sering menjadi simbol kehangatan dan kebersamaan, menemani momen silaturahmi bersama keluarga. Nastar juga tahan lama, bisa disimpan hingga beberapa minggu dalam wadah tertutup rapat tanpa kehilangan rasa dan kerenyahannya.",
      "Nanas",
    ),
    KueKering(
      "K02",
      "Kastengel",
      85000,
      "Kue Kering",
      "assets/images/kastengel.jpeg",
      28,
      "Kastengel adalah kue kering gurih yang selalu hadir di setiap perayaan besar seperti Lebaran dan Natal. Terbuat dari campuran tepung terigu, mentega, kuning telur, dan parutan keju edam, kue ini dipanggang hingga berwarna keemasan dengan aroma keju yang menggoda.\nRasanya gurih, asin, dan sedikit buttery dengan tekstur renyah di luar namun lembut saat digigit. Setiap batang kecilnya sering ditaburi keju parut di atasnya, menambah cita rasa sekaligus membuat tampilannya semakin menggugah selera.",
      "Keju",
    ),
    KueKering(
      "K03",
      "Kue Sagu",
      85000,
      "Kue Kering",
      "assets/images/kue sagu.jpeg",
      28,
      "Kue Sagu dikenal dengan teksturnya yang ringan dan mudah hancur di mulut. Terbuat dari tepung sagu, mentega, gula halus, dan sedikit keju parut, kue ini punya cita rasa gurih manis yang khas dan aroma wangi yang lembut saat dipanggang.\nSetiap gigitan memberi sensasi renyah di luar namun langsung lumer begitu menyentuh lidah. Rasanya tidak terlalu manis, pas untuk dinikmati bersama kopi atau teh hangat. Bentuknya yang kecil dan berpola cantik menjadikannya salah satu kue kering favorit di toples sajian hari raya.",
      "Manis dan Gurih",
    ),
    KueKering(
      "K04",
      "Kue Lidah Kucing",
      40000,
      "Kue Kering",
      "assets/images/lidah kucing.jpeg",
      28,
      "Kue Lidah Kucing punya ciri khas bentuk tipis memanjang dengan tekstur super renyah yang langsung patah saat digigit. Terbuat dari campuran mentega, gula, putih telur, dan tepung terigu, kue ini memiliki rasa manis lembut berpadu aroma vanila yang harum.\nNama “lidah kucing” berasal dari bentuknya yang pipih dan melengkung, menyerupai lidah hewan kecil tersebut. Proses pemanggangannya harus tepat agar hasilnya tipis, kering, dan berwarna keemasan di tepiannya. Kue ini sering menjadi pilihan camilan ringan atau suguhan khas saat hari raya karena tampilannya yang rapi dan rasanya yang ringan.",
      "Vanila",
    ),
    KueKering(
      "K05",
      "Semprit",
      60000,
      "Kue Kering",
      "assets/images/Semprit.jpeg",
      28,
      "Kue Semprit dikenal dengan bentuknya yang cantik menyerupai bunga kecil dan aroma mentega yang harum saat baru keluar dari oven. Terbuat dari campuran tepung terigu, mentega, telur, dan gula halus, kue ini memiliki tekstur renyah namun tetap lembut di mulut.\nRasanya manis gurih dengan sentuhan butter yang khas. Di bagian tengahnya sering diberi topping seperti choco chips, selai strawberry, nanas, atau parutan keju yang menambah variasi rasa dan tampilan menarik. Kue ini kerap menjadi andalan di meja tamu saat hari raya atau sebagai camilan sehari-hari karena rasanya yang ringan dan tidak mudah bikin enek.",
      "Coklat, Strawberry, Nanas, Keju",
    ),
    KueKering(
      "K06",
      "Putri Salju",
      65000,
      "Kue Kering",
      "assets/images/putri salju.jpeg",
      30,
      "Putri Salju selalu mencuri perhatian dengan bentuk bulan sabitnya yang lembut dan balutan gula halus putih menyerupai salju. Terbuat dari campuran tepung terigu, mentega, kacang mede atau almond halus, serta sedikit vanila, kue ini punya tekstur rapuh yang langsung lumer di mulut.\nRasanya manis gurih dengan aroma mentega yang lembut, memberikan sensasi lembut sejak gigitan pertama. Taburan gula halus di seluruh permukaannya menambah keindahan dan memberi rasa manis yang pas tanpa berlebihan.",
      "Vanilla",
    ),
    KueKering(
      "K07",
      "Kue Kacang",
      60000,
      "Kue Kering",
      "assets/images/kue kacang.jpeg",
      20,
      "Kue Kacang punya aroma khas yang langsung bikin nostalgia. Dibuat dari kacang tanah yang disangrai lalu ditumbuk halus, dicampur dengan tepung, gula, dan minyak, kue ini dipanggang hingga matang sempurna.\nRasanya gurih manis dengan tekstur yang renyah namun mudah lumer di mulut. Permukaannya sering diberi olesan kuning telur sehingga tampak mengilap dan menggugah selera. Kue klasik ini sering jadi favorit karena rasanya sederhana tapi nagih — biasanya tersedia untuk camilan saat berkumpul bersama keluarga.",
      "Kacang",
    ),
    KueKering(
      "K08",
      "Kue Chocolate Chip Cookies",
      50000,
      "Kue Kering",
      "assets/images/chip cookies.jpeg",
      20,
      "Kue Chocolate Chip Cookies adalah kue kering klasik yang selalu jadi favorit segala usia. Terbuat dari adonan mentega, gula, dan tepung yang dipanggang hingga renyah di luar namun tetap sedikit chewy di dalam.\nSetiap gigitannya menghadirkan sensasi manis dengan potongan cokelat chip yang lembut menambah cita rasa khas cokelat yang bikin nagih. Kue ini cocok dinikmati kapan saja — saat santai, menemani kopi, atau sebagai camilan manis di sore hari.",
      "manis dan chocolate",
    ),
    KueKering(
      "K09",
      "Kue Bawang",
      35000,
      "Kue Kering",
      "assets/images/bawang.jpeg",
      20,
      "Kue bawang adalah camilan gurih yang selalu jadi favorit saat kumpul keluarga. Terbuat dari campuran tepung terigu, telur, margarin, dan taburan bawang yang harum, kemudian digoreng hingga kering keemasan. Teksturnya tipis, renyah, dan punya rasa gurih bawang yang khas, bikin susah berhenti ngemil setelah satu gigitan.",
      "gurih dan renyah",
    ),
    KueKering(
      "K10",
      "Akar kelapa",
      35000,
      "Kue Kering",
      "assets/images/akar kelapa.jpeg",
      20,
      "Kue tradisional khas Indonesia yang bentuknya menyerupai akar tanaman dengan lilitan unik. Terbuat dari campuran tepung ketan, santan, gula, dan sedikit garam, kemudian digoreng hingga berwarna keemasan. Teksturnya renyah di luar namun tidak terlalu keras, dengan rasa gurih manis yang pas di lidah. Biasanya disajikan saat hari raya atau sebagai camilan sore hari ditemani teh hangat.",
      "gurih, manis",
    ),
  ];
}
