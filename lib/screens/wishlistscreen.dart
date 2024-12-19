import 'package:bingr/main.dart';
import 'package:bingr/utils/wishlist.dart';
import 'package:bingr/utils/wishlistmanager.dart';
import 'package:flutter/material.dart';



class WishlistScreen extends StatefulWidget {
  final String email;

  const WishlistScreen({required this.email});

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late WishlistManager _wishlistManager;
  List<WishlistItem> _wishlist = [];

  @override
  void initState() {
    super.initState();
    _wishlistManager = WishlistManager(userKey: 'wishlist_${e}');
    _loadWishlist();
  }

  Future<void> _loadWishlist() async {
    final wishlist = await _wishlistManager.loadWishlist();
    setState(() {
      _wishlist = wishlist;
      print(wishlist[0].id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My List'),
      ),
      body: _wishlist.isEmpty
          ? Center(child: Text('No items in your list'))
          : ListView.builder(
              itemCount: _wishlist.length,
              itemBuilder: (context, index) {
                final item = _wishlist[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(item.poster),
                    title: Text(item.title),
                    subtitle: Text(item.type),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red,),
                      onPressed: () async {
                        await _wishlistManager.removeFromWishlist(item.id);
                        _loadWishlist();
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
