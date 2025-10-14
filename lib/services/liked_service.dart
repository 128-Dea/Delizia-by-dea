import 'package:shared_preferences/shared_preferences.dart';
import '../model/product.dart';

class LikedService {
  static List<Product> likedProducts = [];

  static Future<void> loadLikes(List<Product> semuaProduct) async {
    final prefs = await SharedPreferences.getInstance();
    final likedNames = prefs.getStringList('liked_products') ?? [];

    likedProducts = semuaProduct
        .where((p) => likedNames.contains(p.nama))
        .toList();
  }

  static Future<void> saveLikes() async {
    final prefs = await SharedPreferences.getInstance();
    final likedNames = likedProducts.map((p) => p.nama).toList();
    await prefs.setStringList('liked_products', likedNames);
  }

  static void toggleLike(Product product) {
    if (isLiked(product)) {
      likedProducts.removeWhere((p) => p.nama == product.nama);
    } else {
      likedProducts.add(product);
    }
    saveLikes();
  }

  static bool isLiked(Product product) {
    return likedProducts.any((p) => p.nama == product.nama);
  }
}
