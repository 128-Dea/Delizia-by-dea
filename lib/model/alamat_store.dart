class Alamat {
  String nama;
  String jalan;
  String kecamatan;
  String desa;
  String kabupaten;
  String provinsi;
  String kodepos;

  Alamat({
    required this.nama,
    required this.jalan,
    required this.kecamatan,
    required this.desa,
    required this.kabupaten,
    required this.provinsi,
    required this.kodepos,
  });

  @override
  String toString() {
    return "$nama, $jalan, $desa, $kecamatan, $kabupaten, $provinsi, $kodepos";
  }
}

class AlamatStore {
  static final AlamatStore _instance = AlamatStore._internal();
  factory AlamatStore() => _instance;
  AlamatStore._internal();

  Alamat? alamat;
}
