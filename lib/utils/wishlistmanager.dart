import 'dart:convert';
import 'package:bingr/utils/wishlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistManager {
  final String userKey;

  WishlistManager({required this.userKey});

  // Load wishlist
  Future<List<WishlistItem>> loadWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(userKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((item) => WishlistItem.fromJson(item)).toList();
    }
    return [];
  }

  // Save wishlist
  Future<void> saveWishlist(List<WishlistItem> wishlist) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(wishlist.map((e) => e.toJson()).toList());
    await prefs.setString(userKey, jsonString);
  }

  // Add an item to wishlist
  Future<void> addToWishlist(WishlistItem item) async {
    final wishlist = await loadWishlist();
    print("wishlist");
    if (!wishlist.any((element) => element.id == item.id)) {
      wishlist.add(item);
      await saveWishlist(wishlist);
    }
    print(wishlist);
  }

  // Remove an item from wishlist
  Future<void> removeFromWishlist(String id) async {
    final wishlist = await loadWishlist();
    wishlist.removeWhere((item) => item.id == id);
    await saveWishlist(wishlist);
  }
}
