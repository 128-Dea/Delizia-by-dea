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
      "Kue Lapis merupakan salah satu kue tradisional Indonesia yang memiliki tampilan cantik dengan lapisan warna-warni yang tersusun rapi. Terbuat dari campuran tepung beras, santan, gula pasir, dan sedikit garam, kue ini memiliki tekstur kenyal dan lembut di setiap gigitannya. \nSetiap lapisannya dikukus secara bertahap, menciptakan perpaduan warna yang menggugah selera dan menjadi ciri khas tersendiri dari kue ini. Selain tampilannya yang menarik, aroma gurih santan berpadu manisnya gula membuat kue lapis digemari berbagai kalangan, dari anak-anak hingga orang tua.",
      "2 hari",
    ),
    KueBasah(
      "B02",
      "Onde-Onde",
      1000,
      "Kue Basah",
      "assets/images/onde-onde.jpeg",
      500,
      "Onde-Onde adalah salah satu jajanan tradisional yang paling populer di Indonesia, dikenal dengan bentuknya yang bulat dan taburan wijen di seluruh permukaannya. Lapisan luarnya terbuat dari tepung ketan yang digoreng hingga kecokelatan dan renyah, sementara bagian dalamnya berisi kacang hijau manis yang lembut. Perpaduan rasa gurih dari wijen dan adonan ketan berpadu sempurna dengan isian kacang hijau yang legit, menciptakan sensasi rasa yang khas dan disukai banyak orang. Selain rasanya yang nikmat, Onde-Onde juga memiliki aroma harum khas wijen yang menggugah selera sejak gigitan pertama.\nKue ini sering disajikan dalam berbagai acara seperti arisan, hajatan, hingga perayaan hari besar. Dengan bentuknya yang sederhana namun menggoda, Onde-Onde menjadi simbol jajanan pasar klasik yang tak lekang oleh waktu.",
      "2 hari",
    ),
    KueBasah(
      "B03",
      "Dadar Gulung",
      2000,
      "Kue Basah",
      "assets/images/dadar gulung.jpeg",
      1000,
      "Dadar Gulung adalah kue tradisional Indonesia yang terkenal dengan bentuk gulungannya yang rapi dan warna hijau khas dari daun pandan. Terbuat dari adonan tepung terigu, telur, santan, dan pandan, dadar ini dimasak menjadi lembaran tipis menyerupai pancake, kemudian diisi dengan parutan kelapa yang dicampur gula merah cair, menciptakan rasa manis gurih yang memanjakan lidah.\nAroma pandan yang harum berpadu dengan legitnya gula merah membuat kue ini menjadi salah satu jajanan pasar yang selalu digemari. Teksturnya lembut di luar dengan isian yang sedikit lengket dan kaya rasa di dalamnya.",
      "1 hari",
    ),
    KueBasah(
      "B04",
      "Putu Ayu",
      3000,
      "Kue Basah",
      "assets/images/putu ayu.jpeg",
      1000,
      "Putu Ayu adalah kue tradisional yang dikenal karena bentuknya yang cantik menyerupai bunga dan warna hijaunya yang lembut. Terbuat dari campuran tepung terigu, santan, gula, dan sari pandan, kue ini dikukus hingga mengembang lembut dengan aroma harum yang khas. Bagian atasnya diberi taburan kelapa parut yang gurih, memberikan kontras rasa dan tekstur yang pas antara lembut, manis, dan sedikit asin. Kue ini menjadi salah satu jajanan pasar favorit karena tampilannya menarik dan rasanya yang sederhana namun lezat. Putu Ayu sering disajikan dalam berbagai acara seperti arisan, syukuran, atau sebagai teman minum teh di sore hari.\nDengan kombinasi warna hijau dan putih yang menawan serta aroma pandan yang menggoda, Putu Ayu tidak hanya memanjakan lidah, tapi juga indah dipandang..",
      "2 hari",
    ),
    KueBasah(
      "B05",
      "Lemper",
      3000,
      "Kue Basah",
      "assets/images/lemper.jpeg",
      450,
      "Lemper, kue tradisional yang dibuat dari ketan pulen berisi suwiran ayam berbumbu gurih atau abon, dibungkus rapi dengan daun pisang yang memberi aroma khas saat dikukus atau dipanggang. Rasa gurih dari ketan berpadu sempurna dengan isian ayam yang lembut dan sedikit manis, menciptakan cita rasa yang mengenyangkan meski berukuran kecil.\nKue ini sering dijadikan sajian dalam acara keluarga, syukuran, hingga bekal perjalanan karena praktis dan tahan cukup lama. Teksturnya sedikit lengket namun lembut di mulut, membuatnya cocok dinikmati kapan saja, terutama bersama teh hangat. Aroma daun pisang yang harum berpadu dengan rasa gurih ketan menjadikan lemper tetap menjadi favorit banyak orang.",
      "2 hari",
    ),
    KueBasah(
      "B06",
      "Nagasari Pisang",
      3000,
      "Kue Basah",
      "assets/images/nagasari pisang.jpeg",
      300,
      "Nagasari Pisang termasuk jajanan tradisional yang lembut dan harum, dibuat dari campuran tepung beras, santan, dan sedikit gula yang dikukus bersama potongan pisang di dalamnya. Adonannya dibungkus daun pisang sebelum dikukus, memberi aroma khas yang menenangkan sekaligus rasa gurih alami.\nTeksturnya lembut dan sedikit kenyal, sementara rasa manis pisang berpadu sempurna dengan gurihnya adonan santan. Kue ini sering disajikan dalam acara keluarga, hajatan, hingga sebagai camilan sore hari karena rasanya ringan dan mengenyangkan. Warna putih dari adonan berpadu dengan kuning alami pisang menciptakan tampilan sederhana namun menggugah selera..",
      "1 hari",
    ),
    KueBasah(
      "B07",
      "Kue Pukis",
      5000,
      "Kue Basah",
      "assets/images/pukis.jpeg",
      500,
      "Kue Pukis termasuk jajanan tradisional yang banyak digemari karena teksturnya empuk dan rasanya manis lembut. Terbuat dari campuran tepung terigu, telur, gula, ragi, dan santan, lalu dipanggang di cetakan setengah lingkaran hingga permukaannya sedikit kecokelatan.\nAromanya wangi dan menggugah selera, apalagi saat baru diangkat dari cetakan. Bagian dalamnya lembut dan agak lembap, berpadu dengan berbagai topping seperti cokelat, keju, atau meses yang menambah cita rasa manis gurih.",
      "2 hari",
    ),
    KueBasah(
      "B08",
      "Kue Putu",
      2500,
      "Kue Basah",
      "assets/images/kue putu.jpeg",
      1000,
      "Kue Putu punya ciri khas unik dengan suara siulan kukusannya yang khas saat dijajakan. Terbuat dari tepung beras yang diisi gula merah cair, kemudian dikukus di dalam cetakan bambu kecil yang menghasilkan aroma harum berpadu dengan wangi pandan dan kelapa.\nSaat digigit, gula merah di bagian tengahnya meleleh lembut, memberi sensasi manis yang hangat di mulut. Teksturnya lembut, sedikit padat di luar namun lumer di dalam, cocok dinikmati selagi hangat dengan taburan kelapa parut yang gurih di permukaannya.\nKue ini sering ditemui di pasar malam atau penjual keliling, namun sekarng dapat dipesan di sini yaa, kue putu ini juga menjadi salah satu jajanan tradisional yang membawa nuansa nostalgia.",
      "1 hari",
    ),
    KueBasah(
      "B09",
      "Kue Lupis Ketan Pandan",
      3000,
      "Kue Basah",
      "assets/images/LUPIS KETAN PANDAN.jpeg",
      300,
      "Kue Lupis Ketan Pandan memiliki cita rasa khas yang berasal dari ketan pulen berpadu aroma daun pisang dan pandan yang harum. Adonan ketan dibungkus rapat membentuk segitiga, kemudian dikukus hingga matang dan bertekstur lengket lembut. Setelah itu, lupis disajikan dengan taburan kelapa parut segar dan siraman gula merah cair yang kental serta manis legit. Rasa gurih dari kelapa parut dan manisnya gula merah menciptakan kombinasi sempurna, membuat kue ini jadi favorit banyak orang terutama saat disantap di pagi atau sore hari. Warna hijau alami dari daun pandan menambah kesegaran tampilan sekaligus aroma yang menggugah selera.",
      "1 hari",
    ),
    KueBasah(
      "B10",
      "Kue Pie",
      3500,
      "Kue Basah",
      "assets/images/kue pie.jpeg",
      350,
      "Kue Pie memiliki perpaduan rasa dan tekstur yang unik, dengan kulit luar yang renyah serta isian lembut yang manis atau gurih. Kulit pie dibuat dari adonan tepung terigu, mentega, dan sedikit gula yang dipanggang hingga berwarna keemasan dan harum. Bagian dalamnya bisa diisi dengan berbagai varian seperti custard lembut, potongan buah segar, cokelat, hingga keju sesuai selera.\nKue ini sering disajikan dalam berbagai acara, dari pesta hingga hidangan penutup di kafe dan toko kue modern. Rasa manisnya tidak berlebihan, sementara tekstur kulitnya yang garing memberikan sensasi kontras yang menyenangkan di setiap gigitan..",
      "2 hari",
    ),
    KueBasah(
      "B11",
      "Apem",
      3000,
      "Kue Basah",
      "assets/images/Apem.jpeg",
      500,
      "Apem menjadi salah satu kue tradisional yang lekat dengan nuansa budaya dan makna syukur. Terbuat dari campuran tepung beras, santan, gula, dan ragi yang difermentasi, kemudian dikukus atau dipanggang hingga mengembang lembut dengan aroma khas yang menggugah selera.\nTeksturnya empuk dengan sedikit kekenyalan, sementara rasanya manis ringan dan terasa gurih dari santan. Warna apem biasanya putih kekuningan atau agak kecokelatan tergantung cara memasaknya. Kue ini sering disajikan dalam acara adat, kenduri, atau syukuran sebagai simbol harapan dan keberkahan..",
      "2 hari",
    ),
    KueBasah(
      "B12",
      "Klepon",
      2500,
      "Kue Basah",
      "assets/images/klepon.jpeg",
      2000,
      "Klepon menjadi salah satu jajanan tradisional yang paling dikenal dan disukai banyak orang. Terbuat dari tepung ketan yang diberi pewarna hijau alami dari daun pandan atau suji, kemudian dibentuk bulat kecil dan diisi dengan gula merah cair di bagian tengahnya. Setelah direbus hingga mengapung, klepon dilumuri kelapa parut segar yang memberi sensasi gurih saat disantap.\nBegitu digigit,mmmm gula merah di dalamnya langsung meleleh di mulut, berpadu sempurna dengan tekstur lembut ketan dan kelapa yang sedikit kasar. Perpaduan rasa manis, gurih, dan aroma pandan yang harum membuat klepon selalu menghadirkan kenangan jajanan pasar tempo dulu.",
      "1 hari",
    ),
  ];
}
