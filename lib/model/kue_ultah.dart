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
      "Kue cokelat klasik yang tak lekang oleh waktu. Black Forest hadir dengan lapisan bolu cokelat lembut yang diselimuti krim segar dan dihiasi taburan cokelat serut di seluruh permukaannya. Di bagian atasnya, ceri merah manis menambah sentuhan warna dan rasa asam segar yang menyeimbangkan manis legitnya krim dan cokelat.\nAromanya khas dan menggoda, sementara setiap potongannya memberikan kombinasi rasa lembut, manis, dan sedikit segar yang sempurna di lidah. Cocok untuk momen ulang tahun yang hangat, perayaan kecil bersama keluarga, atau sekadar memanjakan diri di hari istimewa.",
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
      "Kue ini punya warna merah khas yang langsung bikin jatuh hati. Teksturnya lembut dan agak moist, dengan rasa manis yang pas berpadu sama cream cheese frosting yang gurih dan lembut. Setiap potongannya berasa mewah tapi tetap ringan di lidah.\nRed Velvet ini sering jadi pilihan favorit buat ulang tahun karena tampilannya elegan dan rasanya nggak bikin enek.",
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
      "Kue ulang tahun berlapis warna pelangi yang cerah dan menggoda ini selalu berhasil mencuri perhatian di setiap perayaan. Setiap lapisannya punya tekstur lembut dan rasa manis yang pas, berpadu dengan krim putih lembut yang melapisinya dengan halus. Saat dipotong, warna-warni lapisan dalamnya terlihat cantik banget — bikin siapa pun yang lihat langsung pengin mencicipi. Selain tampilannya yang ceria, Rainbow Cake juga punya cita rasa lembut dan ringan di mulut, cocok buat semua usia.",
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
      "Kue ulang tahun klasik dengan tekstur ringan dan empuk seperti spons, memberikan sensasi lembut setiap kali digigit. Sponge Cake ini punya rasa manis yang lembut dan aroma vanila yang harum, cocok untuk siapa pun yang suka kue ringan tapi tetap nikmat. \nBiasanya disajikan apa adanya atau dihias dengan krim, buah segar, hingga cokelat leleh sesuai selera. Teksturnya yang lembut membuat kue ini juga sering jadi dasar berbagai kreasi tart ulang tahun. Ukurannya cukup besar, pas untuk dibagikan bersama keluarga dan teman, dengan tulisan “Happy Birthday!” di atasnya yang menambah kesan hangat dan meriah.",
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
      "Kue lembut berbahan dasar keju krim ini punya cita rasa manis gurih yang khas dan begitu memanjakan lidah sejak gigitan pertama. Teksturnya halus, lembut, dan creamy — terasa lumer di mulut dengan aroma keju yang harum tapi tetap ringan, tidak bikin enek. Setiap lapisannya dibuat dengan bahan pilihan dan teknik pemanggangan yang pas, sehingga menghasilkan keseimbangan sempurna antara rasa manis, gurih, dan sedikit asam alami dari kejunya.",
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
      "Kue cokelat yang satu ini selalu jadi favorit di setiap kesempatan. Teksturnya padat namun lembut, dengan rasa cokelat yang kaya dan sedikit rasa pahit khas kakao asli yang bikin rasanya seimbang, tidak terlalu manis. Saat digigit, bagian dalamnya terasa fudgy dan moist, sementara bagian pinggirnya sedikit renyah — perpaduan sempurna yang bikin nagih di setiap potongannya.\nBrownis ini cocok disajikan untuk ulang tahun sederhana maupun sebagai hadiah manis untuk orang tersayang. Aroma cokelatnya yang harum langsung terasa begitu kotaknya dibuka, Cocok dinikmati bersama teh atau kopi.",
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
      "Kue mungil yang dikemas dalam cup kertas ini selalu berhasil mencuri perhatian dengan tampilannya yang manis dan warna-warni. Teksturnya lembut dan empuk, berpadu sempurna dengan topping krim manis di atasnya yang dihias dengan berbagai dekorasi cantik seperti sprinkle, cokelat serut, atau potongan buah kecil. Setiap gigitannya menghadirkan rasa manis lembut yang bikin suasana langsung terasa lebih hangat dan ceria.\nCupcake ini sering jadi pilihan favorit untuk ulang tahun anak-anak, hadiah kecil untuk sahabat, atau pelengkap pesta kecil di rumah. Meski berukuran kecil, tampilannya imut dan elegan, cocok dijadikan kue ulang tahun bergaya modern yang praktis tapi tetap berkesan.",
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
      "Kue cokelat lembut yang satu ini benar-benar sesuai namanya — selembut awan. Teksturnya ringan, halus, dan lumer begitu menyentuh lidah, menghadirkan sensasi manis pekat khas cokelat premium yang langsung bikin jatuh cinta di gigitan pertama. Setiap lapisannya dibuat dengan adonan lembut yang dipanggang sempurna, menghasilkan rasa cokelat yang kaya tapi tetap ringan di mulut.\nChocolate Cloud Cake ini cocok banget untuk momen spesial seperti ulang tahun atau perayaan anniversary. Disajikan dengan taburan gula halus atau lelehan cokelat di atasnya, tampilannya sederhana namun elegan.",
      "sedeng",
      "Happy Anniversary!",
    ),
    KueUltah(
      "U09",
      "Tiramisu Cake",
      90000,
      "Kue Ultah",
      "assets/images/Tiramisu cake.jpeg",
      12,
      "Kue khas Italia yang satu ini punya cita rasa elegan dan lembut yang sulit dilupakan. Tiramisu Cake terbuat dari lapisan sponge lembut yang direndam dengan kopi espresso, lalu disusun bergantian dengan krim keju mascarpone yang halus dan creamy. Perpaduan rasa pahit kopi dan manis lembut krimnya menciptakan keseimbangan sempurna yang bikin setiap potongan terasa istimewa.\nAroma kopinya yang khas berpadu dengan taburan bubuk kakao di bagian atas, memberikan sentuhan akhir yang menggoda. Kue ini cocok banget disajikan untuk perayaan ulang tahun, anniversary, atau momen spesial bersama orang terdekat. Ukurannya pas untuk dinikmati bersama keluarga kecil atau sahabat, dan tampilannya yang elegan selalu berhasil mencuri perhatian di meja hidangan.",
      "Sedang",
      "Happy Anniversary!",
    ),
  ];
}
