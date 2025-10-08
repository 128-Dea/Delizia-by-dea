class Review {
  final String user;
  final double rating;
  final String comment;

  Review({required this.user, required this.rating, required this.comment});

  Map<String, dynamic> toJson() {
    return {"user": user, "rating": rating, "comment": comment};
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      user: json["user"] ?? "Pembeli",
      rating: (json["rating"] ?? 0).toDouble(),
      comment: json["comment"] ?? "",
    );
  }
}
