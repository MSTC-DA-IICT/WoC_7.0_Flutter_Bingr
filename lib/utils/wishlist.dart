class WishlistItem {
  final String id;       // Unique ID of the movie/show
  final String title;    // Title of the movie/show
  final String poster;   // Poster URL
  final String type;     // Movie, Series, or TV Show

  WishlistItem({
    required this.id,
    required this.title,
    required this.poster,
    required this.type,
  });

  // Convert to JSON for storage
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'poster': poster,
        'type': type,
      };

  // Convert JSON to WishlistItem
  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      id: json['id'],
      title: json['title'],
      poster: json['poster'],
      type: json['type'],
    );
  }
}
