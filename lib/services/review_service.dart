import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/ulasan_model.dart';

class ReviewService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addReview(String productId, Review review) async {
    await _firestore
        .collection("products")
        .doc(productId)
        .collection("reviews")
        .add(review.toJson());
  }

  Stream<List<Review>> getReviews(String productId) {
    return _firestore
        .collection("products")
        .doc(productId)
        .collection("reviews")
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Review.fromJson(doc.data())).toList(),
        );
  }
}
